GO_PKG_VERSION=1.13

if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

instal_web() {
  ${_sudo} apt-get install git make libprotoc-dev -y
  echo "Installing: Web"
  git clone https://github.com/grpc/grpc-web.git
  cd grpc-web || exit
  ${_sudo} make install-plugin
  cd ..
}

test_web(){
  cd ../test || exit
  bash ./test_web.sh
  cd ../langs || exit
}

instal_web
test_web