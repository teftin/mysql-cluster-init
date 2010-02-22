#!/bin/bash -x

basedir=/opt/mysql-cluster-gpl-7.0.9-osx10.5-x86_64
datadir=/opt/mysql-data

function start_sql {
    $basedir/bin/mysqld \
        --defaults-file=$datadir/my.cnf \
        --user=root \
        --basedir=$basedir \
        --datadir=$datadir/cluster-sql-$1 \
        --socket=/tmp/mysqld-$(($1-50)).s --port=$((3306+$1)) \
        --log-error=$datadir/cluster-sql-$1/logerr \
        --pid-file=$datadir/cluster-sql-$1/pid \
        < /dev/null >> $datadir/cluster-sql-$1/stderr 2>&1 &
}

function start_ndb {
    $basedir/bin/ndbd \
        --defaults-file=$datadir/my.cnf \
        --ndb-nodeid=$1
}

function start_mgmd {
    $basedir/bin/ndb_mgmd \
        --defaults-file=$datadir/my.cnf \
        --configdir=$datadir/cluster-mgmt-$1 \
        --config-file=$datadir/cluster-mgmt-$1/config.ini \
        --reload \
        --ndb-nodeid=$1
}

start_mgmd 49
sleep 5
start_ndb 1
start_ndb 2
sleep 2
start_sql 51
