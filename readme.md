ELB TLS Analysis
================

This project prints statistics on the TLS version negotiated between a browser and an ELB.

## Usage
```
$ make download logs uniq
. . .
awk '{ print $NF  }' < all.logs > results.tmp
sort results.tmp | uniq -c | sort -n
1185 TLSv1.1
12919 TLSv1
2000321 TLSv1.2
```

This means a total of 2014425 connections.
- TLSv1.1 -    1185/2014425 = 0.00058825719498
- TLSv1   -   12919/2014425 = 0.00641324447423
- TLSv1.2 - 2000321/2014425 = 0.99299849833079

Note: The numbers can be verified with *grep TLSv1.1 all.logs | wc -l *, for example. 
