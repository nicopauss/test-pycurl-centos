ARG CENTOS_VERSION=centos8
FROM centos:$CENTOS_VERSION
LABEL Description="Test pycurl build on centos ${CENTOS_VERSION}"

RUN ( yum install -y libcurl || yum install -y --allowerasing libcurl )      \
&&  yum install -y                                                           \
        gcc                                                                  \
        python3                                                              \
        python3-devel                                                        \
        libcurl-devel                                                        \
        git                                                                  \
        openssl-devel
