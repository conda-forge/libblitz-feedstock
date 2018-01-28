cd %SRC_DIR%
7z x Blitz-VS2010.zip -aoa

set SLN_FILE=Blitz-Library.sln
set SLN_CFG=Release
if "%ARCH%"=="32" (set SLN_PLAT=Win32) else (set SLN_PLAT=x64)

REM Build step
msbuild "%SLN_FILE%" /p:Configuration=%SLN_CFG%,Platform=%SLN_PLAT%,PlatformToolset=v140
msbuild "%SLN_FILE%" /p:Configuration=%SLN_CFG%,Platform=%SLN_PLAT%,PlatformToolset=v140,ConfigurationType=DynamicLibrary
if errorlevel 1 exit 1

copy %SRC_DIR%\lib\%SLN_PLAT%\blitz.dll %LIBRARY_BIN%\
copy %SRC_DIR%\lib\%SLN_PLAT%\blitz.lib %LIBRARY_LIB%\

mkdir %LIBRARY_LIB%\pkgconfig

(
@echo prefix=%CONDA_PREFIX:\=/%/Conda/Library
@echo exec_prefix=${prefix}
@echo libdir=${exec_prefix}/lib
@echo includedir=${prefix}/include
@echo.
@echo Name: blitz
@echo Description: blitz Library
@echo Version: 0.10
@echo Requires: 
@echo Libs: -L${libdir} -lblitz
@echo Cflags: -I${includedir} -pthread
) > %LIBRARY_LIB%\pkgconfig\blitz.pc