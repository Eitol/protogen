OUT=./gen/sharp
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_kotlin() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  protoc_gen_grpc_kotlin=$(whereis protoc-gen-grpc-kotlin | awk '{print $2}')
  protoc -I=${PROTOS} --plugin=protoc-gen-grpc-kotlin="${protoc_gen_grpc_kotlin}" --grpc-kotlin_out="${OUT}" --kotlin_out="${OUT}" ${PROTOS}/*
}

gen_kotlin
check_file "${OUT}/CartGrpc.cs" "C#"