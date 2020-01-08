# Define custom utilities
# Test for OSX with [ -n "$IS_OSX" ]

function pre_build {
    # Any stuff that you need to do before you start building the wheels
    # Runs in the root directory of this repository.
    if [ -z "$IS_OSX" ]; then
      if [ `uname -m` = "aarch64" ]; then
         yum update -y && yum install -y wget && yum clean all;
         mkdir /tmp/dl;
         cd /tmp/dl;
         wget https://cmake.org/files/v3.13/cmake-3.13.3.tar.gz;
         tar -zxvf cmake-3.13.3.tar.gz;
         cd cmake-3.13.3 && ./bootstrap --prefix=/usr/local && make && make install && export PATH=/usr/local/bin:$PATH
      else
         pip install cmake;
      fi
  # Version in manylinux1 container too old.
    fi
}

function run_tests {
    # The function is called from an empty temporary directory.
    cd ../tests
    python -c "import freetype; print('Using FreeType version ', freetype.version())"
    pytest
}
