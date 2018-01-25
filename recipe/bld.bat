cd %SRC_DIR%
7z x Blitz-VS2010.zip -aoa

set SLN_FILE=Blitz-Library.sln
set SLN_CFG=Release
if "%ARCH%"=="32" (set SLN_PLAT=Win32) else (set SLN_PLAT=x64)

REM Build step
msbuild "%SLN_FILE%" /p:Configuration=%SLN_CFG%,Platform=%SLN_PLAT%,PlatformToolset=v140
if errorlevel 1 exit 1

rem  ---------------------

rem C:\cygwin\bin\unzip Blitz-VS2005.NET.zip
rem powershell.exe -nologo -noprofile -command "& { Add-Type -A 'System.IO.Compression.FileSystem'; [IO.Compression.ZipFile]::ExtractToDirectory('Blitz-VS2005.NET.zip', ''); }"
rem cd Blitz-VS2005.NET

rem devenv "%SLN_FILE%" /Build "%SLN_CFG%|%SLN_PLAT%"