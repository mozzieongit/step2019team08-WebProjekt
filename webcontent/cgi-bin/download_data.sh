#!/bin/bash

## USAGE ##
# download_data.sh <number of days> [-l]
# <number of days> to extract from data
# -l . It enables logging to file /tmp/dwd_data_logs
# This script returns the path of the generated data files

url='https://opendata.dwd.de/climate_environment/CDC/observations_germany/climate/daily/kl/recent/tageswerte_KL_00701_akt.zip'
path="/tmp/${USER}_$$_dwd_data"
file='tageswerte_KL_00701_akt.zip'
val=''

doit() {
  if [ "$1" != "" ] && [ "$1" -gt "0" ]; then range=$1; else range=30; fi

  echo -e "\n$$ on \e[1;33m$(date)\e[0m in \e[31m$path \e[0m"
  mkdir "$path"
  if cd $path; then
    # download and unpack data
    curl -O "$url"
    unzip "$file"
    rm "$file" Metadaten_*
    line=$(($(wc -l $(ls -1rt | grep produkt )| cut -f1 -d' ')-1))
    if [ "$line" -lt "$range" ]; then range=$line ; echo "RANGE TOO LONG: $line lines available" ; fi
    tail -n "$range" $(ls -1rt produkt_* | tail -n 1) | cut -f 2,14 -d ';' | sed 's/ //g; s/;/ /g' > temp.dat
    tail -n "$range" $(ls -1rt produkt_* | tail -n 1) | cut -f 2,5 -d ';' | sed 's/ //g; s/;/ /g' > wind.dat
    tail -n "$range" $(ls -1rt produkt_* | tail -n 1) | cut -f 2,7 -d ';' | sed 's/ //g; s/;/ /g' > rain_height.dat
    tail -n "$range" $(ls -1rt produkt_* | tail -n 1) | cut -f 2,8 -d ';' | sed 's/ //g; s/;/ /g; s/ 4/ 0/g; s/ 6/ 1/g; s/ 7/ 2/g; s/ 8/ 3/g; s/ 9/ 0/g' > rain_form.dat
    tail -n "$range" $(ls -1rt produkt_* | tail -n 1) | cut -f 2,7,8 -d ';' | sed 's/ //g; s/;/ /g; s/ 4/ 0/g; s/ 6/ 1/g; s/ 7/ 2/g; s/ 8/ 3/g; s/ 9/ 0/g' > rain_all.dat

    #rm -rf "$path"
  fi
} 
if [ "$#" -gt "0" ]
  then
      days=$1
      if [ "$2" == "-l" ]; then log=true; fi
fi

if [ "$log" == "true" ]; then
  doit >>/tmp/dwd_data_logs 2>&1
else
  doit $days >/dev/null 2>&1
fi

val=$path
echo "$val"

# Alle Werte als tägliches Mittel
# Temperatur in °C
# Wind in m/s
# Niederschlagshöhe in mm
# Niederschlagsform:
#           0 kein Niederschlag (oder kein Wert)
#           1 nur Regen
#           2 nur Schnee
#           3 Regen und Schnee (und/oder Schneeregen)
