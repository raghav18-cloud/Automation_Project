# Automation_Project
This project is indetend to work on AWS services and autmate serveral install using sheel script.

First created IAM roles, security group,EC2 instance and s3 bucket.
Once the above resourcse ate created , have wriiten shell script to install packgaes below
1>apache2
2>up the apache2 servieces .
3>install aws cli maunally.
4>capture the log files of apache2 and psuh them to s3 bucket from the shellscript commands.
5>creating an inventory file in /var/www/html/inventory.html, this invetory file contains four feilds 
Log Type         Time Created         Type        Size
the shell script is providing the data to inventory file with the above fields mentioned, importantly this file will always be apended.
6>further have setup a cronjob for the automation.sh script to run every minute to collect and append the data into inventory file
to have a  complete automation setup.

With the automation.sh shell script the process of installing packages,collecting data and appending to inventoryfile is completely  automated.
