FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
# copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore
# copy everything else and build app
COPY . ./
RUN dotnet build -c Release
RUN dotnet publish -c Release -o /out
FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime
WORKDIR /app
COPY --from=build /out ./
ENTRYPOINT ["dotnet", "hellowebApp.dll"]