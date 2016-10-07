AWS=/usr/local/bin/aws

download:
	${AWS} s3 sync s3://cspreporter-prod .

logs:
	find ./AWSLogs -type f -name \*.log -exec cat >> all.logs {} \;

uniq:
	awk '{ print $$NF  }' < all.logs > results.tmp
	sort results.tmp | uniq -c | sort -n

clean:
	-rm *.tmp

cleanall: clean
	-rm -rf all.logs ./AWSLogs
