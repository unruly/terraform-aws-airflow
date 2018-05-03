#!/bin/bash

set -x

function install_anaconda() {
    wget --quiet https://repo.continuum.io/archive/Anaconda2-5.1.0-Linux-x86_64.sh -O Anaconda-latest-Linux-x86_64.sh

    bash Anaconda-latest-Linux-x86_64.sh -f -b -p /home/centos/anaconda2 > /dev/null

    rm -f Anaconda-latest-Linux-x86_64.sh
}

function install_with_conda() {
    for PACKAGE in $*; do
        conda install -qy $PACKAGE
    done
}

function install_with_pip() {
    for PACKAGE in $*; do
        pip install -q $PACKAGE
    done
}

function install_dependencies() {
    yum install -y gcc
    yum install -y bzip2
    yum install -y wget
}

function install_python_and_python_packages() {
    echo ". /home/centos/anaconda2/etc/profile.d/conda.sh" >> /home/centos/.bashrc

    source /home/centos/anaconda2/etc/profile.d/conda.sh

    conda update -yn base conda
    conda create -q -yn py34 python=3.4
    conda activate py34

    pip install -q --upgrade pip

    install_with_conda \
        numpy \
        scipy \
        scikit-learn \
        pandas

    pip install -qU setuptools --ignore-installed

    install_with_pip \
        apache-airflow \
        psycopg2-binary \
        cryptography

    chown -R centos: /home/centos/anaconda2
}

function start_airflow() {
    mkdir -p /home/centos/airflow
    mv /var/tmp/airflow.cfg /home/centos/airflow/

    export AIRFLOW_HOME=/home/centos/airflow

    conda activate py34
    airflow initdb

    mkdir -p /var/log/airflow

    nohup airflow webserver > /var/log/airflow/webserver.log &
    nohup airflow scheduler > /var/log/airflow/scheduler.log &
}

START_TIME=$(date +%s)

service sshd start

install_dependencies
install_anaconda
install_python_and_python_packages
start_airflow

END_TIME=$(date +%s)
ELAPSED=$(($END_TIME - $START_TIME))

echo "Deployment complete. Time elapsed was [$ELAPSED] seconds"
