GEN_VERSION=1.27.0
ARCH=linux-x86_64

MAVEN_HOST=https://repo1.maven.org/maven2
MAVEN_PROJECT=io/grpc/protoc-gen-grpc-java
FILE_BASE=protoc-gen-grpc-java
FILE=${FILE_BASE}-${GEN_VERSION}-${ARCH}.exe
REPO=${MAVEN_HOST}/${MAVEN_PROJECT}/${GEN_VERSION}/${FILE}
INSTALL_DIR=/usr/bin

if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_java_sdk() {
  echo "Installing: Java SDK"
  ${_sudo} apt-get install openjdk-11-jdk
}

install_java_grpc_deps(){
  ${_sudo} apt-get install wget
  ${_sudo} mkdir -p ${INSTALL_DIR}
  if [[ -f "${INSTALL_DIR}/${FILE}" ]]; then
    rm -f "${INSTALL_DIR}/${FILE}"
  fi
  ${_sudo} wget -P ${INSTALL_DIR} ${REPO}
  final_name=${INSTALL_DIR}/${FILE_BASE}
  ${_sudo} mv ${INSTALL_DIR}/${FILE} ${final_name}
  ${_sudo} chmod +x ${final_name}
}

test_java(){
  cd ../test || exit
  bash ./test_java.sh
  cd ../langs || exit
}

install_java_sdk
install_java_grpc_deps
test_java