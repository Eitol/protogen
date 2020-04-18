OUT=./gen/node
PROTOS=./protos

# Importing the commons functions
. ./test_commons.sh

gen_js() {
  mkdir -p ${OUT}
  rm -rf  "${OUT:?}/*"

  plugin_bin_path=$(command -v protoc-gen-ts)
  protoc -I=${PROTOS} --plugin="protoc-gen-ts=${plugin_bin_path}" \
      --js_out="import_style=commonjs,binary:${OUT}" \
      --ts_out="${OUT}" \
      ${PROTOS}/*
}

gen_js
check_file "${OUT}/cart_pb.js" "Javascript"
check_file "${OUT}/cart_pb.d.ts" "Typescript"