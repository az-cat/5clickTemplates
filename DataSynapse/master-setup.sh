#!/bin/bash -xv

TOKEN=$1
date
myhostname=`hostname`
externalip=`dig +short myip.opendns.com @resolver1.opendns.com`
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum -y install nodejs
npm install -g azure-cli

cd /opt/
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u121-b13/e9e7ea248e2c4826b92b3f075a80e441/jdk-8u121-linux-x64.tar.gz"
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
tar xzf jdk-8u131-linux-x64.tar.gz
export JAVA_HOME=/opt/jdk1.8.0_131
export PATH=$PATH:$JAVA_HOME/bin

mkdir tibco
cd tibco

wget "https://azbenchmarkstorage.blob.core.windows.net/datasynapsebenchmarkstorage/TIB_dsp_gridserver_6.2.0.tar.gz${TOKEN}" -O TIB_dsp_gridserver_6.2.0.tar.gz
wget "https://azbenchmarkstorage.blob.core.windows.net/datasynapsebenchmarkstorage/TIB_gridserver_6.2.0_hotfix07.jar${TOKEN}" -O TIB_gridserver_6.2.0_hotfix07.jar

tar -xzf TIB_dsp_gridserver_6.2.0.tar.gz
echo y | java -jar TIB_gridserver_6.2.0_hotfix07.jar /opt/tibco/datasynapse/manager
cd datasynapse/manager

sed -i -- "s/acceptEULA \= false/acceptEULA \= true/" install.silent
sed -i -- "s/EnterYourHostNameHere/$myhostname/" install.silent
sed -i -- "s/Required even if the machine you're installing on is the Primary Director\!/http:\/\/$externalip:8000/g" install.silent
sed -i -- "0,/$externalip:8000/s/http:\/\/$externalip:8000/http:\/\/$externalip:8080/" install.silent

date

./install.sh install.silent
service firewalld stop
./server.sh start

date