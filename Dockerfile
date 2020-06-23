FROM ubuntu:19.10 as base
ENV DEBIAN_FRONTEND noninteractive
# Install base deps
ADD scripts/base/ /opt/protogen/base
RUN cd /opt/protogen/base && bash install_base.sh

ADD scripts/test/test_commons.sh /opt/protogen/scripts/test/
ADD scripts/test/protos/ /opt/protogen/scripts/test/protos

WORKDIR /opt/protogen/scripts/langs

# C/C++
ADD scripts/langs/install_cpp.sh /opt/protogen/scripts/langs
ADD scripts/test/test_cpp.sh /opt/protogen/scripts/test
RUN bash install_cpp.sh

# Go
ADD scripts/langs/install_go.sh /opt/protogen/scripts/langs
ADD scripts/test/test_go.sh /opt/protogen/scripts/test
RUN bash install_go.sh

# Dart
ADD scripts/langs/install_dart.sh /opt/protogen/scripts/langs
ADD scripts/test/test_dart.sh /opt/protogen/scripts/test
RUN bash install_dart.sh

# Java
ADD scripts/langs/install_java.sh /opt/protogen/scripts/langs
ADD scripts/test/test_java.sh /opt/protogen/scripts/test
RUN bash install_java.sh

# Node
ADD scripts/langs/install_node.sh /opt/protogen/scripts/langs
ADD scripts/test/test_node.sh /opt/protogen/scripts/test
RUN bash install_node.sh

# Python
ADD scripts/langs/install_python.sh /opt/protogen/scripts/langs
ADD scripts/test/test_python.sh /opt/protogen/scripts/test
RUN bash install_python.sh

# PHP
ADD scripts/langs/install_php.sh /opt/protogen/scripts/langs
ADD scripts/test/test_php.sh /opt/protogen/scripts/test
RUN bash install_php.sh

# Ruby
ADD scripts/langs/install_ruby.sh /opt/protogen/scripts/langs
ADD scripts/test/test_ruby.sh /opt/protogen/scripts/test
RUN bash install_ruby.sh

# WEB
ADD scripts/langs/install_web.sh /opt/protogen/scripts/langs
ADD scripts/test/test_web.sh /opt/protogen/scripts/test
RUN bash install_web.sh

# C#
ADD scripts/langs/install_csharp.sh /opt/protogen/scripts/langs
ADD scripts/test/test_csharp.sh /opt/protogen/scripts/test
RUN bash install_csharp.sh

