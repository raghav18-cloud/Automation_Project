###################################################################################
####Shell script written by raghavendra for perfomring the Automation task#########

#!/bin/bash	

##Creating variable

s3_bucket="upgrad-raghavendra"
myname="raghavendra"
timestamp=`date '+%d%m%Y-%H%M%S'`

##Perfomring update in the system 

sudo apt update -y


##Installing apache2 package 

sudo apt-get install apache2 -y


#checking if apache package is running or not.

sudo systemctl status apache2


###To run the package package

sudo systemctl start apache2

##To eneable apchae to services.


sudo systemctl enable apache2


######Archiving only the log files using tar command

sudo tar -cvf /tmp/raghavendra-httpd-logs-"$timestamp".tar /var/log/apache2/*.log

###Now connecting to aws cli and cpoying the log file from /tmp and uploading it into the 
aws s3 \
 cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
 s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
