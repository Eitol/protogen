OUT=./gen/python
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_python() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  python3 -m grpc_tools.protoc -I${PROTOS} --python_out=${OUT} --grpc_python_out=${OUT} ${PROTOS}/*
}


gen_python
check_file "${OUT}/cart_pb2.py" "Python"