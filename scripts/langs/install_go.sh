GO_PKG_VERSION=1.13

if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

instal_go() {
  echo "Installing: Go"
  ${_sudo} apt-get -y install golang-${GO_PKG_VERSION}
  gobin="${HOME}/go/bin"
  export PATH="${PATH}:/usr/lib/go-${GO_PKG_VERSION}/bin:${gobin}"
  echo "export PATH=\"${PATH}\"" >> ~/.bashrc
  echo "export PATH=\"${PATH}\"" >> ~/.profile
}

install_grpc_go_deps(){
  echo "Installing: Go grpc deps"
  echo "grpc..."
  go get -u google.golang.org/grpc
  echo "protoc-gen-grpc-gateway..."
  go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  go get github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
  go get github.com/golang/protobuf/protoc-gen-go
  go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway
  go install github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger
  go install github.com/golang/protobuf/protoc-gen-go
}

test_go(){
  cd ../test || exit
  bash ./test_go.sh
  cd ../langs || exit
}

instal_go
install_grpc_go_deps
test_go