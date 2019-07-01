FROM mcr.microsoft.com/windows/servercore:ltsc2016

# setup chocolatey
ENV chocolateyUseWindowsCompression=false
RUN @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
RUN choco config set cachelocation C:\chococache

# install prereqs for vsts release agent
RUN choco install \
git \
docker-cli \
--confirm \
&& rmdir /S /Q C:\chococache

# set the working directory
RUN mkdir C:\BuildAgent
WORKDIR C:/BuildAgent

# copy our start scripts
COPY ./Start.* ./

CMD ["Start.cmd"]
