#!/usr/bin/env sh

NCORES=216

date

for i in `seq 1 ${NCORES}`; do
    flux submit -N 1 -n 1 flux start -s1 ensemble.sh
done

KEY=$(echo $(flux wreck kvs-path ${NCORES}).state)
kvs-watch-until.lua -t 1000 ${KEY} 'v == "complete"'
flux wreck ls
echo "First Level Done"

date
