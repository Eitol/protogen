if [[ "$(command -v sudo)" == "" ]]; then
  _sudo=""
else
  _sudo="sudo"
fi

INSTALL_PATH=/usr/bin

get_latest_plugin_version() {
  file="maven-metadata.xml"
  wget https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-kotlin/${file}
  xqilla -i "${file}" <(echo "/metadata/versioning/release/text()")
  (rm -f ${file}) >>/dev/null
}

install_kotlin() {
  tmp_dir=/tmp/testPROTOGEN
  mkdir ${tmp_dir}
  cd ${tmp_dir} || exit
  if [[ "$(command -v wget)" == "" || "$(command -v xqilla)" == "" ]]; then
    ${_sudo} apt-get update
    ${_sudo} apt-get install wget xqilla
  fi
  version=$(get_latest_plugin_version)
  plugin_file=protoc-gen-grpc-kotlin-${version}-linux-x86_64.exe
  wget https://repo1.maven.org/maven2/io/grpc/protoc-gen-grpc-kotlin/"${version}"/"${plugin_file}"
  ${_sudo} mv ./"${plugin_file}" "${INSTALL_PATH}"/protoc-gen-grpc-kotlin
  chmod +x "${INSTALL_PATH}"/protoc-gen-grpc-kotlin
  #rm -rf ${tmp_dir}
  cd - || exit
}

test_kotlin() {
  cd ../test || exit
  bash ./test_kotlin.sh
  cd ../langs || exit
}

install_kotlin
