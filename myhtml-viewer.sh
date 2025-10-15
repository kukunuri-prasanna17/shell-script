#!/bin/bash

MY_HTML_FILE=C:\Devops\daws-86s\repos\shell-script\template.html

if [ ! -f $MY_HTML_FILE]; then
   echo "This $MY_HTML_FILE doesn't exists"
   exit 1
fi

#command to line-browerser to display my html code into sh

sudo apt install w3m 
w3m -dump $MY_HTML_FILE
echo "created w3m dump for hmtl" 

