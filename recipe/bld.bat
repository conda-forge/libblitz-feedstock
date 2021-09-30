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

REM Copy headers
mkdir %LIBRARY_INC%\blitz
mkdir %LIBRARY_INC%\blitz\array
mkdir %LIBRARY_INC%\blitz\gnu
mkdir %LIBRARY_INC%\blitz\meta
mkdir %LIBRARY_INC%\blitz\ms

copy %SRC_DIR%\blitz\*.h %LIBRARY_INC%\blitz\
copy %SRC_DIR%\blitz\array\*.h %LIBRARY_INC%\blitz\array\
copy %SRC_DIR%\blitz\gnu\*.h %LIBRARY_INC%\blitz\gnu\
copy %SRC_DIR%\blitz\meta\*.h %LIBRARY_INC%\blitz\meta\
copy %SRC_DIR%\blitz\ms\*.h %LIBRARY_INC%\blitz\ms\

copy %SRC_DIR%\blitz\*.cc %LIBRARY_INC%\blitz\
copy %SRC_DIR%\blitz\array\*.cc %LIBRARY_INC%\blitz\array\
copy %SRC_DIR%\blitz\gnu\*.cc %LIBRARY_INC%\blitz\gnu\
copy %SRC_DIR%\blitz\meta\*.cc %LIBRARY_INC%\blitz\meta\
copy %SRC_DIR%\blitz\ms\*.cc %LIBRARY_INC%\blitz\ms\

REM make pkg-config file
mkdir %LIBRARY_LIB%\pkgconfig

(
@echo prefix=%CONDA_PREFIX:\=/%/Conda/Library
@echo exec_prefix=${prefix}
@echo libdir=${exec_prefix}/lib
@echo includedir=${prefix}/include
@echo.
@echo Name: blitz
@echo Description: blitz Library
@echo Version: 1.0.1
@echo Requires: 
@echo Libs: -L${libdir} -lblitz
@echo Cflags: -I${includedir} -pthread
) > %LIBRARY_LIB%\pkgconfig\blitz.pc
