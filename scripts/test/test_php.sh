OUT=./gen/php
PROTOS=./protos

PROTO_GEN_PATH=/usr/bin/grpc_php_plugin

# Importing the commons functions
. ./test_commons.sh

gen_php() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  protoc -I${PROTOS} \
  --php_out=${OUT} \
  --grpc_out=${OUT} \
  --plugin=protoc-gen-grpc=${PROTO_GEN_PATH} \
  ${PROTOS}/*
}


gen_php
check_file "${OUT}/GPBMetadata/Cart.php" "PHP"