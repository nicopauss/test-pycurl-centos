Simple repository with a docker file and a run script for testing pycurl with centos.

To simply try to compile and install pycurl through pip with centos 7 or 8, run:
```
$ ./run_pycurl_centos.sh centos7
or
$ ./run_pycurl_centos.sh centos8
```

To run it with the fix https://github.com/nicopauss/pycurl/tree/fix-centos-install:
```
$ ./run_pycurl_centos.sh centos7 --with-fix
or
$ ./run_pycurl_centos.sh centos8 --with-fix
```
