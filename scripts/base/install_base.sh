if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_base(){
  ${_sudo} apt-get update
  bash ./install_base_deps.sh
  bash ./install_protoc.sh
}

install_base