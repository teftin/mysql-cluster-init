#!/bin/sh -x

basedir=/opt/mysql-cluster-gpl-7.0.9-osx10.5-x86_64
datadir=/opt/mysql-data

function stop_ndb {
    $basedir/bin/ndb_mgm -e shutdown
}

function stop_sql {
    $basedir/bin/mysqladmin -u root -S /tmp/mysqld-$(($1-50)).s shutdown
}

stop_sql 51
stop_ndb
