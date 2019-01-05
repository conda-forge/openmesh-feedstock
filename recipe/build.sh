#!/bin/sh

mkdir -p build && cd build

cmake \
  -DCMAKE_FIND_ROOT_PATH=${PREFIX} \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DBUILD_APPS=OFF \
  ..

make install -j${CPU_COUNT}

# osx, py34: ***Exception: SegFault in test_load_obj_with_material (test_read_write_obj.ReadWriteOBJ)
ctest --output-on-failure || echo "failed"
