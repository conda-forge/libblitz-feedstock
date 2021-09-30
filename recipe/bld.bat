cd %SRC_DIR%

md build
cd build

cmake .. -DCMAKE_BUILD_TYPE=Release -DPython3_EXECUTABLE="%PYTHON%" -DCMAKE_INSTALL_PREFIX="%PREFIX%" -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS=ON
if errorlevel 1 exit /b 1

cmake --build . --config Release
if errorlevel 1 exit /b 1

cmake --build . --target install
if errorlevel 1 exit /b 1
