#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[37m"
LOGS_FOLDER="/VAR/LOG/Shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script started excuted at: $(date)"
    if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1  
    fi
validate(){ 
    if [ $1 -ne 0 ]; then 
        echo -e "ERROR::Installing $2 ... $R FAILURE $N"
        exit 1
    else
       echo -e "Installing $2 ... $G SUCESS $N"
    fi
}  

for package in $@
do 
  dnf list installed $package &>>LOG_FILE
  
  if [ $? -ne 0 ]; then
    dnf install $package -y &>>LOG_FILE
    validate $? $package
  else
   echo -e "Installing $package already installed..... $Y skipping $N"
  fi
done