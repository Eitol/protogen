if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

PROTOBUF_VERSION=3.6.1

install_protoc() {
  ${_sudo} apt-get install autoconf automake libtool curl make g++ unzip wget git -y
  ${_sudo} apt-get install libpthread-stubs0-dev build-essential gawk -y
  git clone https://github.com/google/protobuf.git
  cd protobuf || exit
  git submodule update --init --recursive
  ./autogen.sh
  ./configure --prefix=/usr
  make -j"$(nproc)"
  make check
  ${_sudo} make install
  ${_sudo} ldconfig
}

install_common_protos() {
  INITIAL_PATH=$(pwd)
  REPO=https://github.com/google/protobuf/releases/download
  ZIP_FILE=protoc-${PROTOBUF_VERSION}-linux-x86_64.zip
  URL=${REPO}/v${PROTOBUF_VERSION}/${ZIP_FILE}
  INSTALL_DIR=/usr/src/protoc/
  if [[ "$(command -v wget)" ==  "" ]]; then
    ${_sudo} apt-get install wget -y
  fi
  ${_sudo} mkdir -p ${INSTALL_DIR}
  cd ${INSTALL_DIR} || exit
  if [[ ! -f ${ZIP_FILE} ]];then
    ${_sudo} wget ${URL} ${INSTALL_DIR}${ZIP_FILE}
    ${_sudo} unzip ${ZIP_FILE}
  fi
  if [[ ! -f "/usr/local/bin/protoc" ]]; then
    ${_sudo} ln -s ${INSTALL_DIR}bin/protoc /usr/local/bin/protoc
  fi
  cd "${INITIAL_PATH}" || exit
}

#install_protoc
install_common_protos
