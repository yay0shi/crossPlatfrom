using Microsoft.AspNetCore.Mvc;
using Server.Models;
using Server.Repositories;

namespace Server.Controllers;

[ApiController]
[Route("api/movies")]
public class MoviesController : ControllerBase
{
    private readonly IMovieRepository _repository;

    public MoviesController(IMovieRepository repository)
    {
        _repository = repository;
    }

    [HttpGet]
    [ProducesResponseType(StatusCodes.Status200OK)]
    public IActionResult GetAll()
    {
        var movies = _repository.GetAll();
        return Ok(new {data = movies});
    }

    [HttpGet("{id:int}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public IActionResult GetById(int id)
    {
        var movie = _repository.GetById(id);
        if (movie == null)
        {
            return Problem(
                title: "Фильм не найден",
                detail: $"Фильм с id {id} отсутствует в каталоге",
                statusCode: StatusCodes.Status404NotFound);
        }
        return Ok(new {data = movie});
    }
}
