#!/bin/bash

yum install -y bzip2 wget
USER=/home/ec2-user

wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b -f -p $USER/miniconda
$USER/miniconda/bin/conda install -c conda-forge -y awscli

chown -R ec2-user:ec2-user $USER/miniconda

rm Miniconda3-latest-Linux-x86_64.sh