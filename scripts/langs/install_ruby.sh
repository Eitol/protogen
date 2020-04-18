if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

install_ruby() {
  echo "Installing: Ruby"
  ${_sudo} apt-get -y install ruby-full
}

install_ruby_deps() {
  echo "Installing: Ruby deps"
  ${_sudo} gem install grpc-tools
}

test_ruby(){
  cd ../test || exit
  bash ./test_ruby.sh
  cd ../langs || exit
}

install_ruby
install_ruby_deps
test_ruby
