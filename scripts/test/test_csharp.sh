OUT=./gen/sharp
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_csharp() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  grpc_csharp_plugin=$(whereis grpc_csharp_plugin | awk '{print $2}')
  protoc -I=${PROTOS} --plugin=protoc-gen-grpc="${grpc_csharp_plugin}" --csharp_out=${OUT} --grpc_out=${OUT} ${PROTOS}/*
}

gen_csharp
check_file "${OUT}/CartGrpc.cs" "C#"