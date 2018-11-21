FROM microsoft/dotnet:2.1-sdk AS build-env
WORKDIR /integration

COPY integration.csproj .
RUN dotnet restore

ENV TEAMCITY_PROJECT_NAME=fake
COPY . .
ENTRYPOINT ["dotnet", "test", "--logger:\"console;verbosity=normal\""]