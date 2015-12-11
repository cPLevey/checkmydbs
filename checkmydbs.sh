#!/bin/sh
all_mysql_dbs=$(mysql -e "show databases" |grep -v '-' |grep -v 'Database');
cpanel_user_dbs=$(/usr/local/cpanel/bin/whmapi1 list_databases |grep name |sed 's/      name: //g' |sort);
system_ignore_dbs="information_schema cphulkd eximstats leechprotect modsec mysql performance_schema roundcube whmxfer horde";
    for ignored_db in $system_ignore_dbs; do all_mysql_dbs=$(echo "$all_mysql_dbs" |grep -v $ignored_db); done
    for user_db in $cpanel_user_dbs; do all_mysql_dbs=$(echo "$all_mysql_dbs" |grep -v $user_db); done
    echo "[!] These MySQL databases weren't created by cPanel. [!]";
    echo "=====";
    echo "$all_mysql_dbs";
    echo "=====";
