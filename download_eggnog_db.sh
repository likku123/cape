#!/bin/bash
# Usage: Run sudo bash download_eggnog_db.sh /output/folder. It will download the database at the desired location
# Database download and creation takes from 15 to 45 minutes, and uncompresses to roughly 120GB.
# Tested on ami-097834fcb3081f51a

rpm -ivh ftp://fr2.rpmfind.net/linux/dag/redhat/el6/en/x86_64/dag/RPMS/axel-2.4-1.el6.rf.x86_64.rpm # or use it from https://www.hugeserver.com/kb/install-axel-centos-debian-linux/

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

DATABASE_VERSION="4.5.1"

mkdir -p $1/eggnog
cd $1/eggnog
chmod 777 $1/eggnog

#Download eggnog annotation and diamond database
wget -q -O og2level.tsv.gz http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/og2level.tsv.gz
wget -q -nH --user-agent=Mozilla/5.0 --relative --no-parent --reject "index.html*" --cut-dirs=4 -e robots=off -O eggnog.db.gz http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/eggnog.db.gz && echo "Decompressing..." && gunzip eggnog.db.gz
wget -q -nH --user-agent=Mozilla/5.0 --relative --no-parent --reject "index.html*" --cut-dirs=4 -e robots=off -O OG_fasta.tar.gz  http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/OG_fasta.tar.gz && echo "Decompressing..." && tar -zxf OG_fasta.tar.gz && rm OG_fasta.tar.gz
wget -q -nH --user-agent=Mozilla/5.0 --relative --no-parent --reject "index.html*" --cut-dirs=4 -e robots=off -O eggnog_proteins.dmnd.gz http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/eggnog_proteins.dmnd.gz && echo "Decompressing..." && gunzip eggnog_proteins.dmnd.gz

#Download euk database, aka EUK_500
mkdir -p $1/eggnog/hmmdb_levels/euk_500
cd $1/eggnog/hmmdb_levels/euk_500
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.hmm.h3f
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.hmm.h3i
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.hmm.h3m
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.hmm.h3p
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.hmm.idmap
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.info
axel -n 10 -q http://eggnogdb.embl.de/download/emapperdb-$DATABASE_VERSION/hmmdb_levels/euk_500/euk_500.pkl
