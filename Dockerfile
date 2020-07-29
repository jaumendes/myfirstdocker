#Depending on the operating system of the host machines(s) that will build or run the containers, the image specified in the FROM statement may need to be changed.
#For more information, please see https://aka.ms/containercompat

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1-nanoserver-1909 AS base
WORKDIR /myfirstdocker
EXPOSE 5000
ENV ASPNETCORE=http://*:5000

FROM mcr.microsoft.com/dotnet/core/sdk:3.1-nanoserver-1909 AS build
WORKDIR /myfirstdocker
COPY ["myfirstdocker.csproj", "./"]
RUN dotnet restore "./myfirstdocker.csproj"
COPY . .
WORKDIR "/myfirstdocker/."
RUN dotnet build "myfirstdocker.csproj" -c Release -o /myfirstdocker/build

FROM build AS publish
RUN dotnet publish "myfirstdocker.csproj" -c Release -o /myfirstdocker/publish

FROM base AS final
WORKDIR /myfirstdocker
COPY --from=publish /myfirstdocker/publish .
ENTRYPOINT ["dotnet", "myfirstdocker.dll"]
