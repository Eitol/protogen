OUT=./gen/web
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_web() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  protoc -I=${PROTOS} --js_out=import_style=commonjs:${OUT} \
          --grpc-web_out=import_style=commonjs,mode=grpcwebtext:${OUT} ${PROTOS}/*
}

gen_web
check_file "${OUT}/cart_grpc_web_pb.js" "WEB"