#!/bin/bash

IFS=","
TIMEOUT=3000

for i in \
  simple,standard,QQ \
  simple,standard,Fp \
  simple,generic,QQ \
  simple,generic,Fp \
  cyclic5,standard,QQ \
  cyclic5,standard,Fp \
  cyclic5,generic,QQ \
  cyclic5,generic,Fp \
  cyclic6,standard,QQ \
  cyclic6,standard,Fp \
  cyclic6,generic,QQ \
  cyclic6,generic,Fp \
  cyclic7,standard,QQ \
  cyclic7,standard,Fp \
  cyclic7,generic,QQ \
  cyclic7,generic,Fp \
  agk,standard,QQ \
  agk,standard,Fp \
  agk,generic,QQ \
  agk,generic,Fp \
  tran3.3,standard,QQ \
  tran3.3,standard,Fp \
  tran3.3,generic,QQ \
  tran3.3,generic,Fp \
  newellp1,standard,QQ \
  newellp1,standard,Fp \
  katsura6,standard,QQ \
  katsura6,standard,Fp \
  katsura6,generic,QQ \
  katsura6,generic,Fp \
  katsura7,standard,QQ \
  katsura7,standard,Fp \
  katsura7,generic,QQ \
  katsura7,generic,Fp \
  katsura8,standard,QQ \
  katsura8,standard,Fp \
  katsura8,generic,QQ \
  katsura8,generic,Fp \
  simple,oscar,QQ \
  simple,oscar,Fp \
  cyclic5,oscar,QQ \
  cyclic5,oscar,Fp \
  cyclic6,oscar,QQ \
  cyclic6,oscar,Fp \
  tran3.3,oscar,QQ \
  tran3.3,oscar,Fp \
  agk,oscar,QQ \
  agk,oscar,Fp \
  newellp1,oscar,QQ \
  newellp1,oscar,Fp \
  cyclic7,oscar,QQ \
  cyclic7,oscar,Fp \
  katsura6,oscar,QQ \
  katsura6,oscar,Fp \
  katsura7,oscar,QQ \
  katsura7,oscar,Fp \
  katsura8,oscar,QQ \
  katsura8,oscar,Fp \
  newellp1,generic,QQ \
  newellp1,generic,Fp 
do
  set -- $i

  timeout --foreground --kill-after=10s $TIMEOUT julia benchmark.jl $1 $2 $3 3600
  if [ $? -eq 124 ]; then
    echo -e "NaN" >> results.csv
  else
    echo >> results.csv
  fi
done
