cd %SRC_DIR%
7z x Blitz-VS2010.zip -aoa

set SLN_FILE=Blitz-Library.sln
set SLN_CFG=Release
if "%ARCH%"=="32" (set SLN_PLAT=Win32) else (set SLN_PLAT=x64)

REM Build step
msbuild "%SLN_FILE%" /p:Configuration=%SLN_CFG%,Platform=%SLN_PLAT%,PlatformToolset=v140
msbuild "%SLN_FILE%" /p:Configuration=%SLN_CFG%,Platform=%SLN_PLAT%,PlatformToolset=v140,ConfigurationType=DynamicLibrary
if errorlevel 1 exit 1

move %SRC_DIR%\lib\%SLN_PLAT%\blitz.dll %LIBRARY_BIN%
move %SRC_DIR%\lib\%SLN_PLAT%\blitz.lib %LIBRARY_LIB%
