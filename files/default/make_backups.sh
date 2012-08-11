#!/bin/sh

for db in  `echo '\l' | psql | grep openerp | cut -d ' ' -f 2`
do
   pg_dump -C $db | bzip2 > $HOME/backups/${db}_`date "+%Y%m%d-%H%M"`.sql.bz
done
