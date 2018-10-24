# ipmimon
ipmi sensor monitoring via ipmitool to influxdb &amp; grafana.

#### Install ipmitools and curl.

**Ubuntu/Debian : **

```
apt-get update
apt-get install ipmitool curl
```

```
git clone https://github.com/cyborg00222/ipmimon/
cd ipmimon
mkdir /root/scripts/
cp ipmimon.sh /root/scripts
chmod +x ipmimon.sh
modprobe ipmi_devintf
echo "ipmi_devintf" >> /etc/modules
```

#### Install crontab
```
crontab -e
*/1 * * * * /bin/bash /root/scripts/ipmimon.sh
```
