FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /integration

COPY integration.csproj .
RUN dotnet restore

COPY . .
ENTRYPOINT ["dotnet", "test"]