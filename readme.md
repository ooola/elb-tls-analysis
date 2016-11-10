ELB TLS Analysis
================

This project prints statistics on the TLS version negotiated between a browser and an ELB.

## Usage

Sample with ~12M connections which is ~4.13 GB of results

```
$ make download logs uniq
. . .
awk '{ print $NF  }' < all.logs > results.tmp
sort results.tmp | uniq -c | sort -n
8038 TLSv1.1
41796 TLSv1
12085318 TLSv1.2
```

This means a total of 12135152 connections.

- TLSv1.1 -     8038/12135152 = 0.000662373244274
- TLSv1   -    41796/12135152 = 0.003444209021857
- TLSv1.2 - 12085318/12135152 = 0.995893417733869

Note: The numbers can be verified with *grep TLSv1.1 all.logs | wc -l *, for example. 
