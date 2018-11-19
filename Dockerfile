# build stage
FROM microsoft/dotnet:2.1-sdk AS build-env

WORKDIR /generator

# restore
COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj
COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# Allows seeing what files are being copied into image - doesnt work if cached
#RUN ls -alR

# copy src
COPY . .

# Can also run the following command to list files and directories copied into image
# docker build -t testing .
# docker run --rm testing ls -alR

# test
ENV TEAMCITY_PROJECT_NAME=${TEAMCITY_PROJECT_NAME}
RUN dotnet test tests/tests.csproj

# publish
RUN dotnet publish api/api.csproj -o /publish

# runtime stage
FROM microsoft/dotnet:2.1-aspnetcore-runtime
COPY --from=build-env /publish /publish
WORKDIR /publish
ENTRYPOINT ["dotnet", "api.dll"]
