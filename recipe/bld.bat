cd %SRC_DIR%

md build
cd build

cmake .. -DCMAKE_GENERATOR_PLATFORM="x64" -DCMAKE_BUILD_TYPE=Release -DPython3_EXECUTABLE="%PYTHON%"
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

cmake --build . --target install
if errorlevel 1 exit /b 1

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
