

set CMAKE_CONFIG="Release"

mkdir build && cd build

cmake -LAH -G"NMake Makefiles"                               ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                        ^
  -DCMAKE_FIND_ROOT_PATH="%LIBRARY_PREFIX%"                  ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                  ^
  -DBUILD_APPS=OFF                                           ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

ctest --output-on-failure
if errorlevel 1 exit 1

rem set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib
rem -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%"               ^
rem -DOPENMESH_PYTHON_VERSION="%PY_VER%"                       ^
rem -DOPENMESH_BUILD_PYTHON_UNIT_TESTS=ON ..

git clone https://www.graphics.rwth-aachen.de:9000/OpenMesh/openmesh-python.git
cd openmesh-python
git checkout 1.1.0
mkdir build && cd build
cmake -LAH -G"NMake Makefiles"                               ^
  -DCMAKE_BUILD_TYPE="%CMAKE_CONFIG%"                        ^
  -DCMAKE_FIND_ROOT_PATH="%LIBRARY_PREFIX%"                  ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"                  ^
  ..
if errorlevel 1 exit 1

cmake --build . --config %CMAKE_CONFIG% --target install
if errorlevel 1 exit 1

rem move %LIBRARY_PREFIX%\lib\python\openmesh.lib %SP_DIR%
rem move %LIBRARY_PREFIX%\lib\python\openmesh.pyd %SP_DIR%

ctest --output-on-failure
if errorlevel 1 exit 1
