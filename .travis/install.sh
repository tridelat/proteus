#!/bin/bash

if [[ "$1" == "conda" ]]; then
  git lfs pull
  sudo apt-get update
  if [[ "$2" == "linux" ]]
  then
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh;
  elif [[ "$2" == "osx" ]]
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O miniconda.sh;
  then
  fi
  bash miniconda.sh -b -p $HOME/miniconda
  source "$HOME/miniconda/etc/profile.d/conda.sh"
  hash -r
  conda config --set always_yes yes --set changeps1 no
  conda update -q conda
  conda info -a
  conda env create -f environment-dev.yml
  conda activate proteus-dev
  pip install -v -e .
elif [[ "$1" == "hashdist" ]]; then
  git lfs pull
  ./stack/hit/bin/hit init-home
  ./stack/hit/bin/hit remote add http://levant.hrwallingford.com/hashdist_src --objects="source"
  ./stack/hit/bin/hit remote add http://levant.hrwallingford.com/hashdist_ubuntu_16_04 --objects="build"
  make stack/default.yaml
  pushd $HOME
  mkdir -p hashdist_src
  mkdir -p hashdist_bld
  rm -rf .hashdist/src .hashdist/bld
  ln -s $HOME/hashdist_src .hashdist/src
  ln -s $HOME/hashdist_bld .hashdist/bld
  popd
  pushd stack
  echo $PWD
  ls -l
  ./hit/bin/hit build -j 2 -v default.yaml
  popd
  export PATHSAVE=$PATH
  export PATH=$PWD/linux/bin:$PATH
  export LD_LIBRARY_PATH=$PWD/linux/lib:$LD_LIBRARY_PATH
  PROTEUS_OPT="-w -O2 -UNDEBUG" FC=gfortran CC=mpicc CXX=mpicxx make develop N=1
  export SSL_CERT_DIR=/etc/ssl/certs
  #./linux/bin/pip3 install matplotlib
fi
