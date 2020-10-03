#!/bin/bash
# Atum version 1.0
# Requirements are Dirb, NMAP and Whatweb
# Atum is a script that automates lan enumeration
s 
if [ -z "$1" ]
then 
    echo "Usage. tool.sh <IP Address>"
    exit 1
fi
results = $1
results += "Results"
printf "/n-----Quick LAN Enumeration By Atum-----/n/n" > $results

printf "/n-----Ports-----/n/n" > $results

echo "Running a Port scan on $1..."
nmap $1 | tail -n +5 | head -n -3 >> $results

echo "Pinging $1 to Check Average Ping..."
ping $1 -c 10 > temp1

echo "Running WhatWeb..."
whatweb $1 -v > temp2

echo "preforming Directory enumeration..."
dirb http://$1 > temp3

echo "Running Full NMAP Scan..."
nmap $1 -sS -O -D 1.1.1.1,2.2.2.2,3.3.3.3,4.4.4.4,5.5.5.5,6.6.6.6,7.7.7.7,8.8.8.8,9.9.9.9,10.10.10.10,11.11.11.11,12.12.12.12,13.13.13.13,14.14.14.14,15.15.15.15 > temp4
if [ -e temp1 ]
then
        printf "\n----- Ping-----\n\n" >> $results
        cat temp1 >> $results
        rm temp1
fi

if [ -e temp2 ]
then
    printf "\n----- WEB -----\n\n" >> $results
        cat temp2 >> $results
        rm temp2
fi

if [ -e temp3 ]
then
        printf "\n----- Directories -----\n\n" >> $results
        cat temp3 >> $results
        rm temp3
fi

if [ -e temp4 ]
then
        printf "\n----- Full - NMAP -----\n\n" >> $results
        cat temp4 >> $results
        rm temp4
fi

cat $results
