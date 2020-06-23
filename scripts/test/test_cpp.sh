OUT=./gen/cpp
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_cpp() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  grpc_cpp_plugin=$(whereis grpc_cpp_plugin | awk '{print $2}')
  protoc -I=${PROTOS} --grpc_out=${OUT} --plugin=protoc-gen-grpc="${grpc_cpp_plugin}" ${PROTOS}/*
  protoc -I=${PROTOS} --cpp_out=${OUT} ${PROTOS}/*
}

gen_cpp
check_file "${OUT}/cart.pb.cc" "C/C++"