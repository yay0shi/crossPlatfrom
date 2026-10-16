using Server.Repositories;

namespace Server;

public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        builder.Services.AddControllers();
        builder.Services.AddSwaggerGen();
        builder.Services.AddSingleton<IMovieRepository,JsonMovieRepository>();
        builder.Services.AddProblemDetails();
        builder.Services.AddCors(options =>
        {
            options.AddPolicy("flutter", policy =>
                policy.AllowAnyOrigin()
                      .AllowAnyHeader()
                      .AllowAnyMethod());
        });
        
        var app = builder.Build();

        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }
        
        app.UseExceptionHandler();
        app.Services.GetRequiredService<IMovieRepository>();
        app.UseCors("flutter");
        app.UseStaticFiles();
        app.MapControllers();
        app.Run();
    }
}
