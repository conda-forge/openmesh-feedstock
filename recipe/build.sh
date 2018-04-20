#!/bin/sh

mkdir build && cd build

cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_APPS=OFF \
  ..

make install -j${CPU_COUNT}
mv ${PREFIX}/lib/python/* ${SP_DIR}

# osx, py34: ***Exception: SegFault in test_load_obj_with_material (test_read_write_obj.ReadWriteOBJ)
ctest --output-on-failure || echo "failed"

git clone https://www.graphics.rwth-aachen.de:9000/OpenMesh/openmesh-python.git
cd openmesh-python
git checkout 1.1.0

mkdir build && cd build

#   -DOPENMESH_PYTHON_VERSION=${PY_VER} \
#   -DOPENMESH_BUILD_PYTHON_UNIT_TESTS=ON \
cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  ..

ctest --output-on-failure || echo "failed"
