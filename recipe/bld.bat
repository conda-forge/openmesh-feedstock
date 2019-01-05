
mkdir build
cd build

set CMAKE_CONFIG="Release"

cmake -LAH -G"NMake Makefiles"                               ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                        ^
  -DCMAKE_FIND_ROOT_PATH="%LIBRARY_PREFIX%"                  ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                  ^
  -DBUILD_APPS=OFF                                           ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target INSTALL
if errorlevel 1 exit 1

ctest --output-on-failure
if errorlevel 1 exit 1
