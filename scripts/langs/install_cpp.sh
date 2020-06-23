if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_cpp() {
  # Is installed in base/install_grpc.sh
  echo "Ready: CPP "
}

test_cpp() {
  cd ../test || exit
  bash ./test_cpp.sh
  cd ../langs || exit
}

install_cpp
test_cpp
