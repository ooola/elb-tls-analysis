ELB TLS Analysis
================

This project prints statistics on the TLS version negotiated between a browser and an ELB.

## Usage

```
$ make download logs tlsinfo cipherinfo
. . .
awk '{ print $NF  }' < all.logs > tls.tmp
sort tls.tmp | uniq -c | sort -n
   5 Version/4
18787 TLSv1.1
47246 -
73562 TLSv1
7519221 TLSv1.2
awk '{ print $(NF -1) }' < all.logs > cipher.tmp
sort cipher.tmp | uniq -c | sort -n
   3 ECDHE-RSA-AES256-GCM-SHA384
   5 Gecko)
  64 ECDHE-RSA-AES256-SHA
 583 DES-CBC3-SHA
1235 AES128-SHA256
1716 ECDHE-RSA-AES256-SHA384
5513 AES128-SHA
20268 AES128-GCM-SHA256
47246 -
100311 ECDHE-RSA-AES128-SHA
586358 ECDHE-RSA-AES128-SHA256
6895519 ECDHE-RSA-AES128-GCM-SHA256
```

This means a total of 7658821 connections of which are 7611570 are TLS.

- TLSv1.1 -    73562/7611570 = 0.009664497600364
- TLSv1   -    18787/7611570 = 0.002468216149888
- TLSv1.2 -  7519221/7611570 = 0.987867286249749

For cipher suite we only look at actual cipher suites - exclude "Gecko)" and "-"

- 3/7611570	      = 0.0000003941368207  ECDHE-RSA-AES256-GCM-SHA384	
- 64/7611570	  = 0.000008408252174   ECDHE-RSA-AES256-SHA	
- 583/7611570	  = 0.00007659392215    DES-CBC3-SHA	
- 1235/7611570	  = 0.0001622529912     AES128-SHA256	
- 1716/7611570	  = 0.0002254462614     ECDHE-RSA-AES256-SHA384	
- 5513/7611570	  = 0.0007242920974	    AES128-SHA	
- 20268/7611570	  = 0.00266278836       AES128-GCM-SHA256	
- 100311/7611570  = 0.01317875287       ECDHE-RSA-AES128-SHA	
- 586358/7611570  = 0.07703509263       ECDHE-RSA-AES128-SHA256	
- 6895519/7611570 = 0.9059259785        ECDHE-RSA-AES128-GCM-SHA256	

Note 1: The numbers can be verified with *grep TLSv1.1 all.logs | wc -l *, for example. 

Note 2: "-" appear to be ELB generated. e.g.

```
2017-07-20T23:50:45.646884Z awseb-e-g-AWSEBLoa-1BZLVOO8F9WYI 54.228.16.0:14925 10.154.148.238:80 0.000041 0.001545 0.000036 200 200 0 95 "GET http://54.225.87.4:80/ HTTP/1.1" "Amazon Route 53 Health Check Service; ref:9003f1bf-04a8-4408-ae81-a021e7f0f1c2; report http://amzn.to/1vsZADi" - -
```
