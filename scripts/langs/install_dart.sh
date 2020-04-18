if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_dart_sdk() {
  echo "Installing: Dart SDK"
  ${_sudo} apt-get -y install apt-transport-https wget
  modif="false"
  if [[ "$(command -v pub)" == "" ]]; then
    export PATH="${PATH}:/usr/lib/dart/bin"
    modif="true"
  fi
  if [[ "$(command -v protoc-gen-dart)" == "" ]]; then
    export PATH="${PATH}:${HOME}/.pub-cache/bin"
    modif="true"
  fi
  if [[ "${modif}" == "true" ]]; then
    echo "PATH=\"${PATH}\"" | ${_sudo} tee -a /etc/environment
  fi
  ${_sudo} sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
  ${_sudo} sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
  ${_sudo} apt-get update
  ${_sudo} apt-get -y install dart
  pub global activate protoc_plugin
}

test_dart(){
  cd ../test || exit
  bash ./test_dart.sh
  cd ../langs || exit
}

install_dart_sdk
test_dart