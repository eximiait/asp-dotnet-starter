var builder = WebApplication.CreateBuilder(args);
builder.Services.AddControllersWithViews();


var configuration = new ConfigurationBuilder()
					.SetBasePath(Directory.GetCurrentDirectory())
					.AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
					.AddJsonFile($"appsettings.override.json", optional: true, reloadOnChange: false)
    				.AddJsonFile($"appsettings.secret.json", optional: true, reloadOnChange: false)
					.AddUserSecrets<Program>(optional: true, reloadOnChange: true)
					.AddEnvironmentVariables()
					.AddCommandLine(args)
					.Build();

builder.Services.Configure<AppSettings>(configuration.GetSection("Variables"));

var app = builder.Build();
app.UseRouting();
app.MapControllers();
app.MapDefaultControllerRoute();

app.Run();
