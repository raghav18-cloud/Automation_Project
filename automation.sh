###################################################################################
####Shell script written by raghavendra for perfomring the Automation task#########

#!/bin/bash	

##Creating variables

s3_bucket="upgrad-raghavendra"
myname="raghavendra"
timestamp=`date '+%d%m%Y-%H%M%S'`

##Perfomring update in the system 

sudo apt update -y


##Installing apache2 package 

sudo apt-get install apache2 -y


###checking if apache2 service is running or not.

sudo systemctl status apache2


###To start the apache2 services

sudo systemctl start apache2

##To eneable apchae2 services.

sudo systemctl enable apache2


######Archiving only the log files using tar command

sudo tar -cvf /tmp/raghavendra-httpd-logs-"$timestamp".tar /var/log/apache2/*.log

###Now connecting to aws cli and cpoying the log file from /tmp and uploading it into the 
aws s3 \
 cp /tmp/${myname}-httpd-logs-${timestamp}.tar \
 s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
 
 
 
 
##Creating a inventory file with the header entires and changinfg the permission of the file


touch /var/www/html/inventory.html

chmod 777 /var/www/html/inventory.html



##Appending the contents to inventoryfile.

ls -lh /tmp/  | awk '/raghavendra/ {print $9"      "$5}'  | awk -F'-' '{print $2"-"$3,"   ",$4"-"$5}'  | sed 's/.tar/\ttar/g' | tail -1 >> /var/www/html/inventory.html


##Adding Header to the inventory file.
sed -i '1i Log Type        Date Created    Type    Size'  /var/www/html/inventory.html

##Removing duplicates  headres form the inverntory file when the script runs mutiple time so we can have a clean and correct data

sudo awk -i inplace '!x[$0]++' /var/www/html/inventory.html


##checking and Creating a crontab entry file with entry to run the script once a day.

if [[ -e /etc/cron.d/automation ]]
then
echo "file already exists,nothing to do" 
exit
else
echo "00 */24 * * * root /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
fi

