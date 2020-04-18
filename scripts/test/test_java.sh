OUT=./gen/java
PROTOS=./protos

PROTO_GEN_PATH=/usr/bin/protoc-gen-grpc-java
# Importing the commons functions
. ./test_commons.sh

gen_java() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  protoc -I=${PROTOS} \
         --plugin=${PROTO_GEN_PATH} \
         --grpc-java_out=${OUT} \
          ${PROTOS}/*
}

gen_java
check_file "${OUT}/protos/model/CartServiceGrpc.java" "Java"