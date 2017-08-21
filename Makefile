AWS=/usr/local/bin/aws
DIR=./input
# Becasue these logs are big pick a day and look at it - e.g. July 20th (Thursday)
SRC=s3://.../AWSLogs/355746917450/elasticloadbalancing/us-east-1/2017/07/20

download:
	${AWS} s3 sync ${SRC} ${DIR}

logs:
	find ${DIR} -type f -name \*.log -exec cat >> all.logs {} \;

tlsinfo:
	awk '{ print $$NF  }' < all.logs > tls.tmp
	sort tls.tmp | uniq -c | sort -n

cipherinfo:
	awk '{ print $$(NF -1) }' < all.logs > cipher.tmp
	sort cipher.tmp | uniq -c | sort -n

clean:
	-rm *.tmp

cleanall: clean
	-rm -rf all.logs ${DIR}
