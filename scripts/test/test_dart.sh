OUT=./gen/dart
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_dart() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  protoc -I=${PROTOS} --dart_out=${OUT} ${PROTOS}/*
}

gen_dart
check_file "${OUT}/cart.pb.dart" "Dart"