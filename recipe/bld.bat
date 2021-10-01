cd %SRC_DIR%

md build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release -DPython3_EXECUTABLE="%PYTHON%" -DCMAKE_INSTALL_PREFIX="%PREFIX%" -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=ON
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

cmake --build . --config Release --target install
if errorlevel 1 exit /b 1

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
@echo Version: 0.10
@echo Requires:
@echo Libs: -L${libdir} -lblitz
@echo Cflags: -I${includedir} -pthread
) > %LIBRARY_LIB%\pkgconfig\blitz.pc
