FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app
ENV ASPNETCORE_URLS=""

COPY *.csproj ./
RUN dotnet restore

COPY . ./
RUN dotnet publish -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build-env /app/out .
ENTRYPOINT [ "dotnet", "PlatformService.dll", "--host=127.0.0.1" ]