PLUGIN_NAME="grpc_php_plugin"
LOCAL_BIN="./bins/opt/${PLUGIN_NAME}"
INSTALATION_DIR="/usr/bin"

if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_php() {
  echo "Installing: PHP"
  ${_sudo} apt-get update
  ${_sudo} apt-get install php php-dev php-pear phpunit dh-autoreconf cmake -y
}

install_pecl_package(){
  if [[ "$(pecl list | grep "$1")" == "" ]]; then
      ${_sudo} pecl install "$1" ||
      {
          echo "Could not pecl install foo";
      }
  fi
}

install_php_deps_compiled() {
  echo "Installing: PHP deps"
  install_pecl_package grpc
  install_pecl_package protobuf
  if [[ ! -d "grpc" ]]; then
    git clone -b "$(curl -L https://grpc.io/release)" https://github.com/grpc/grpc
  fi
  cd grpc || exit
  git submodule update --init
  if [[ ! -f ${LOCAL_BIN} ]]; then
    make grpc_php_plugin -j"$(nproc)"
  fi
  if [[ ! -f ${LOCAL_BIN} ]]; then
    echo "PHP plugin ERROR: Unable to make the plugin"
    exit 1
  fi
  ${_sudo} cp ${LOCAL_BIN} ${INSTALATION_DIR}
  ${_sudo} chmod +x "${INSTALATION_DIR}/${PLUGIN_NAME}"
  cd - || exit
}

install_php_deps() {
  grpc_php_plugin_path=$(whereis grpc_php_plugin | awk '{print $2}')
  if [[ "${grpc_php_plugin_path}" == "" ]]; then
    install_php_deps_compiled
  else
    echo "PHP plugin is already installed"
  fi
}


test_php(){
  cd ../test || exit
  bash ./test_php.sh
  cd ../langs || exit
}

install_php
install_php_deps
test_php
