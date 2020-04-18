OUT=./gen/go
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_go() {
  # shellcheck source=src/lib.sh
  mkdir -p ${OUT}
  rm -rf "${OUT:?}/*"
  protoc -I=${PROTOS} --go_out=plugins=grpc:${OUT} ${PROTOS}/*
}

gen_go
check_file "${OUT}/cart.pb.go" "Go"