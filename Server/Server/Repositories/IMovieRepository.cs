using Server.Models;

namespace Server.Repositories;

public interface IMovieRepository
{
    IReadOnlyList<Movie> GetAll();
    Movie? GetById(int id);
}
