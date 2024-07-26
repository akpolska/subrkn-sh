#!/bin/bash
#basic script to recon and check host are live or not
#checking
if [ -z $1 ]
then 
	echo './subrkn.sh ||list of Domains||'
	exit 1
fi

echo '||---Finding Subdomains---||'
while read line 
do 
	for var in $line
	do
		echo '||---SCANNING---||' $var

		subfinder -silent -d $var > out1
		cat out1 >> subs1

		assetfinder -subs-only $var > out2
		cat out2 >> subs2

		rm out1 out2 

	done
done < $1

#combining the results 

sort -u subs1 subs2 > allsubs
rm subs1 subs2 
echo '||SAVED SUBDOMAINS TO FILES "allsubs"||'
echo 'FINDING LIVE HOSTS'
cat allsubs |httprobe > live-subs
echo '||Live hosts downloaded||'
echo '||COMPLETED! CHECK THE FILES named as "live-subs"||'
