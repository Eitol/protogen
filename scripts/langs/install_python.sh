if [[ "$(command -v sudo)" == "" ]];then
  _sudo=""
else
  _sudo="sudo"
fi

install_python3(){
  if [[ "$(command -v sudo)" == "" ]];then
    ${_sudo} apt-get install python3 python3-pip -y
  fi
  ${_sudo} pip3 install grpcio-tools
}


test_python(){
  cd ../test || exit
  bash ./test_python.sh
  cd ../langs || exit
}

install_python3
test_python