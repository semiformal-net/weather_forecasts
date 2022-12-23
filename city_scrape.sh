#!/bin/bash
set -euo pipefail

cat /dev/null > /tmp/config
RUNTIME=$(date +\%s)

PROV=( AB BC MB NB NL NS NT NU ON PE QC SK YT )
for prov in ${PROV[@]}; do
  cat /dev/null > "/tmp/${prov}"
  curl -s "https://weather.gc.ca/forecast/canada/index_e.html?id=${prov}" | egrep "\/city\/pages\/[a-z]{2}-[0-9]{1,}_metric_[ef].html" | egrep -o "[a-z]{2}-[0-9]{1,}" >> /tmp/${prov}
  if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "error with feed"
    exit 1
  fi

  for city in $(cat "/tmp/${prov}"); do
    #curl -s https://weather.gc.ca/rss/city/${city}_e.xml -o ./weather_forecasts/forecast_xml/${prov}/${city}_e$(date +\%s).xml
    echo -e "url = \"https://weather.gc.ca/rss/city/${city}_e.xml\""
    echo -e "output = \"forecast_xml/${prov}/${city}_e${RUNTIME}.xml\""
    echo -e "--create-dirs\n"
  done >> /tmp/config
done
#
# Rather than running curl hundreds of times, build up a config file to do all the downloads in one shot.
#
curl -s -K /tmp/config
if [ $? -ne 0 ];
  echo "curl failure"
  exit 2
fi

#
# Compress each province's forecasts
#
#for prov in ${PROV[@]}; do
#  tar -rvf "forecast_xml/${prov}.tar.gz" forecast_xml/${prov}/*.xml && rm -r "forecast_xml/${prov}"
#done
