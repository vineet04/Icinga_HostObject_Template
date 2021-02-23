#! /bin/bash


for HOSTS in `find /tmp/dir/ -type f  -printf '%f\n'`

do
cat /tmp/hosts/$HOSTS| grep  -io '\bpr\w' > /dev/null 2>&1
if [ $? = 0 ]
then cat /tmp/hosts/$HOSTS >> /etc/icinga2/zones.d/master/hosts/prod.conf

elif [ $? = 1 ] &&  cat /tmp/hosts/$HOSTS| grep  -io '\bpp\w' > /dev/null 2>&1
then cat /tmp/hosts/$HOSTS >> /etc/icinga2/zones.d/master/hosts/preprod.conf

elif [ $? = 1 ] &&  (cat /tmp/hosts/$HOSTS| grep  -io '\bdev\w' || cat /tmp/hosts/$HOSTS| grep  -io '\btst\w') > /dev/null 2>&1
then  cat /tmp/hosts/$HOSTS  >> /etc/icinga2/zones.d/master/hosts/nonprod.conf

else
cat /tmp/hosts/$HOSTS >> /etc/icinga2/zones.d/master/hosts/ungrouped.conf
fi

done
