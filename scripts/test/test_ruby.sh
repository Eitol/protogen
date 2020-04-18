OUT=./gen/ruby
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_python() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"
  grpc_tools_ruby_protoc -I${PROTOS} --ruby_out=${OUT} --grpc_out=${OUT} ${PROTOS}/*
}


gen_python
check_file "${OUT}/cart_pb.rb" "Ruby"