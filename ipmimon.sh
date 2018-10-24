#!/bin/bash
#Peter Kowalsky - 24.10.2018
#IPMI Sensor Monitoring (ipmimon) -> InfluxDB
#Usage : ./ipmimon.sh

HOSTNAME=$(hostname)
INFLUX_DB_LOC="http://localhost:8086/write?db=opentsdb"
CURL_ARGS="-i -XPOST"
INFLUX_PREFIX="ipmimon"
debug="on"

raw_sensor_data="$(ipmitool sensor list)"

if [[ $debug == "on" ]]; then
    echo "#######################"
    echo "RAW IPMI SENSOR DATA :"
    echo ""
    echo "$raw_sensor_data"
    echo ""
    echo "#######################"
    echo ""
fi

while read -r line; do
    line=$(echo "$line" | sed 's/ \{1,\}/ /g')
    value=$(echo "$line" | cut -d'|' -f2)
    value=${value:1:-1}
    name=$(echo "$line" | cut -d'|' -f1)
    name=${name:0:-1}
    if [[ $value != "na" ]]; then
        if [[ $debug == "off" ]]; then curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "$INFLUX_PREFIX,host=$HOSTNAME,name=$name value=$value"; else echo "Name : $name ; Value : $value"; fi
    fi
done <<< "$raw_sensor_data"
