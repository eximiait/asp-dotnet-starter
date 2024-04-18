# Use an official ASP.NET Core runtime as a base image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080

# Use the SDK image to restore the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS deps
WORKDIR /src
COPY "MyAspNetCoreApp.csproj" .
RUN dotnet restore "MyAspNetCoreApp.csproj"

# Build the application
FROM deps AS build
COPY . .
RUN dotnet build "MyAspNetCoreApp.csproj" --no-restore -c Release

# Publish the application
FROM build AS publish
RUN dotnet publish "MyAspNetCoreApp.csproj" --no-restore -c Release -o /app/publish

# Create the final runtime image
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "MyAspNetCoreApp.dll"]