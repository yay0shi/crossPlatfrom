namespace Server.Models;

public class Movie
{
    public int Id { get; set; }
    public string Title { get; set; } = "";
    public string OriginalTitle { get; set; } = "";
    public string Description { get; set; } = "";
    public int ReleaseYear { get; set; }
    public List<string> Genres { get; set; } = new();
    public string Director { get; set; } = "";
    public List<string> Actors { get; set; } = new();
    public int DurationMinutes { get; set; }
    public string Country { get; set; } = "";
    public string AgeRating { get; set; } = "";
    public string PosterUrl { get; set; } = "";
    public double? Rating { get; set; }
}
