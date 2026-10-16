using System.Text.Json;
using Server.Models;
using System.Text.RegularExpressions;

namespace Server.Repositories;

public class JsonMovieRepository : IMovieRepository
{
    private static JsonSerializerOptions _jsonOptions = new(JsonSerializerDefaults.Web);

    private static readonly HashSet<string> AllowedAgeRatings =
        new HashSet<string>(StringComparer.Ordinal)
        {
            "0+",
            "6+",
            "12+",
            "16+",
            "18+"
        };
    
    private readonly IReadOnlyList<Movie> _movies;

    public JsonMovieRepository(IWebHostEnvironment env, ILogger<JsonMovieRepository> logger)
    {
        var path = Path.Combine(env.ContentRootPath, "Data", "movies.json");

        if (!File.Exists(path))
            throw Fail(logger, $"Файл не найден по пути: {path}");

        List<Movie?>? movies;
        try
        {
            var json = File.ReadAllText(path);
            movies = JsonSerializer.Deserialize<List<Movie?>>(json, _jsonOptions);
        }
        catch (Exception ex)
        {
            throw Fail(logger, $"Не удалось прочитать каталог: {path}",ex); 
        }

        if (movies is null)
            throw Fail(logger, $"Каталог пуст: {path}");
        
        var postersDirectory = Path.Combine(
            env.ContentRootPath,
            "wwwroot",
            "posters");
        
        var validatedMovies = Validate(movies, postersDirectory);
        _movies = validatedMovies.OrderBy(m => m.Id).ToList().AsReadOnly();
        
        logger.LogInformation("{Count} фильмов из загружено из {Path}", _movies.Count, path);
    }

    public IReadOnlyList<Movie> GetAll() => _movies;

    public Movie? GetById(int id) => _movies.FirstOrDefault(m => m.Id == id);

    private static InvalidOperationException Fail(ILogger logger, string message, Exception? inner = null)
    {
        logger.LogCritical(inner, "{Message}", message);
        return new InvalidOperationException(message, inner);
    }

    private static List<Movie> Validate(
        List<Movie?> movies,
        string postersDirectory)
    {
        var seen = new HashSet<int>();
        var res = new List<Movie>();
        
        foreach (var m in movies)
        {
            if (m is null)
                throw new InvalidOperationException($"Каталог null");
            if (m.Id <= 0)
                throw new InvalidOperationException($"id должен быть > 0: {m.Id}");
            if (!seen.Add(m.Id)) 
                throw new InvalidOperationException($"Повторяющийся id: {m.Id}");
            if (string.IsNullOrWhiteSpace(m.Title)) 
                throw new InvalidOperationException($"id {m.Id}: пустой {nameof(m.Title)}");
            if (string.IsNullOrWhiteSpace(m.OriginalTitle)) 
                throw new InvalidOperationException($"id {m.Id}: пустой {nameof(m.OriginalTitle)}");
            if (string.IsNullOrWhiteSpace(m.Description)) 
                throw new InvalidOperationException($"id {m.Id}: пустой {nameof(m.Description)}");
            if (string.IsNullOrWhiteSpace(m.Director)) 
                throw new InvalidOperationException($"id {m.Id}: пустой {nameof(m.Director)}");
            if (string.IsNullOrWhiteSpace(m.Country)) 
                throw new InvalidOperationException($"id {m.Id}: пустой {nameof(m.Country)}");
            if (m.ReleaseYear is < 1000 or > 9999) 
                throw new InvalidOperationException($"id {m.Id}: некорректный {nameof(m.ReleaseYear)}");
            if (m.DurationMinutes <= 0) 
                throw new InvalidOperationException($"id {m.Id}: {nameof(m.DurationMinutes)} должно быть > 0");
            if (m.Genres is null ||
                m.Genres.Count == 0 ||
                m.Genres.Any(string.IsNullOrWhiteSpace))
                throw new InvalidOperationException($"id {m.Id}: нужен хотя бы один непустой жанр");
            if (m.Actors is null || 
                m.Actors.Any(string.IsNullOrWhiteSpace))
                throw new InvalidOperationException($"id {m.Id}: имена актеров не должны быть пустыми");
            if (!AllowedAgeRatings.Contains(m.AgeRating))
                throw new InvalidOperationException($"id {m.Id}: {nameof(m.AgeRating)} '{m.AgeRating}' недопустим");
            if (string.IsNullOrWhiteSpace(m.PosterUrl) ||
                !Regex.IsMatch(m.PosterUrl, @"\A/posters/[A-Za-z0-9-]+\.(jpg|jpeg|png)\z"))
                throw new InvalidOperationException($"id {m.Id}: некорректный адрес постера");
            
            var posterPath = Path.Combine(
                postersDirectory,
                Path.GetFileName(m.PosterUrl));

            if (!File.Exists(posterPath))
                throw new InvalidOperationException($"id {m.Id}: файл постера не найден: {posterPath}");
            if (m.Rating is < 0 or > 10)
                throw new InvalidOperationException($"id {m.Id}: {nameof(m.Rating)} должен быть 0..10");
            res.Add(m);
        }
        return res;
    }
}
