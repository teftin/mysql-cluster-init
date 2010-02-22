#!/bin/bash -x

basedir=/opt/mysql-cluster-gpl-7.0.9-osx10.5-x86_64
datadir=/opt/mysql-data

cd $datadir
mkdir cluster-data-{1,2} cluster-mgmt-49 cluster-sql-51
ln -s ../config.ini cluster-mgmt-49
$basedir/scripts/mysql_install_db \
    --basedir=$basedir \
    --datadir=$datadir/cluster-sql-51
