#!/bin/bash -eu

readonly FIX_GIT_CLONE="git clone --depth 1 https://github.com/nicopauss/pycurl.git -b fix-centos-install /root/pycurl"
readonly FIX_DOCSTRINGS="( cd /root/pycurl && python3 setup.py docstrings )"
readonly FIX_PYCURL_INSTALL="file:///root/pycurl#egg=pycurl"


usage() {
    echo "$0 centos7/centos8 [--with-fix]"
}

main() {
    local centos_version
    local pycurl_install
    local docker_image_name
    local cmd

    centos_version=""
    pycurl_install="pycurl"
    cmd="cat /etc/centos-release"

    for i in "$@"; do
        case $i in
            --with-fix)
                cmd="$cmd && $FIX_GIT_CLONE && $FIX_DOCSTRINGS"
                pycurl_install="$FIX_PYCURL_INSTALL"
            ;;
            *)
                centos_version="$i"
            ;;
        esac
    done

    if [ -z "$centos_version" ]; then
        usage
        exit 1
    fi

    cmd="$cmd && python3 -m pip install -v $pycurl_install"
    cmd="$cmd && python3 -c 'import pycurl; print(pycurl.version_info())'"

    docker_image_name="python3-curl-$centos_version"

    docker build -t "$docker_image_name" \
                 --build-arg CENTOS_VERSION="$centos_version" .
    docker run -t "$docker_image_name" /bin/bash -c "$cmd"
}

main "$@"
