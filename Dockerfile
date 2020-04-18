FROM ubuntu:19.10 as base
ENV DEBIAN_FRONTEND noninteractive
ADD scripts/base/ /opt/base
RUN cd /opt/base && bash install_base.sh
ADD . /opt/
WORKDIR /opt/scripts/langs
RUN bash install_go.sh
RUN bash install_dart.sh
RUN bash install_java.sh
RUN bash install_node.sh
RUN bash install_python.sh
RUN bash install_ruby.sh
RUN bash install_php.sh
RUN bash install_cpp.sh
RUN bash install_web.sh