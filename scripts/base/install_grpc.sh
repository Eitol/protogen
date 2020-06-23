if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_grpc() {
  INSTALL_DIR=/usr
  ${_sudo} apt-get install -y build-essential autoconf libtool pkg-config cmake
  git clone --recurse-submodules -b "$(curl -L https://grpc.io/release)" https://github.com/grpc/grpc
  INITIAL_DIR=$(pwd)
  cd grpc || exit
  mkdir -p cmake/build
  cd cmake/build || exit
  cmake -DgRPC_INSTALL=ON \
      -DgRPC_BUILD_TESTS=ON \
      -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
      ../..
  make -j"$(nproc)"
  ${_sudo} make install
  cd "${INITIAL_DIR}" || exit
  # already included
  echo "Ready: GRPC is installed"
}

install_grpc