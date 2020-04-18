NODE_VERSION=12

if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_node(){
  ${_sudo} apt-get -y install wget curl dirmngr apt-transport-https lsb-release ca-certificates gcc g++ make
  ${_sudo} wget https://deb.nodesource.com/setup_${NODE_VERSION}.x
  ${_sudo} bash ./setup_${NODE_VERSION}.x
  ${_sudo} apt-get -y install nodejs
}

install_grpc_node_deps(){
	${_sudo} npm install -g grpc google-protobuf dotenv --unsafe-perm
	${_sudo} npm install -g typescript @types/node @types/google-protobuf @types/dotenv --unsafe-perm
	#${_sudo} npm install -g ts-protoc-gen --unsafe-perm
	${_sudo} npm install -g grpc-tools grpc_tools_node_protoc_ts --unsafe-perm
}

test_node(){
  cd ../test || exit
  bash ./test_node.sh
  cd ../langs || exit
}

install_node
install_grpc_node_deps
test_node

