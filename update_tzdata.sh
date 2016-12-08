#!/bin/bash
# author: Ed Lujan
# Based on http://helw.net/2011/04/28/updating-osx-for-egypts-dst-changes/ by Ahmed El-Helw and https://gist.github.com/tgirardi/95abcfafd5fefd6df02d3a8e6247834d by Tomás Girardi

# CHANGE THIS: 
# go to https://www.iana.org/time-zones and get the URL for the last DATA
# release
TZDATAVERSION="tzdata2016j.tar.gz"
URLTZDATASRC="https://www.iana.org/time-zones/repository/releases/${TZDATAVERSION}"
TZDATADIR="/tmp/tzdata"
### update tzdata
cd /tmp
if [ -d "${TZDATADIR}" ]; then
  rm -rf "${TZDATADIR}"
fi
mkdir "${TZDATADIR}"
cd "${TZDATADIR}"
wget "${URLTZDATASRC}"
tar -xzf "${TZDATAVERSION}"
sudo zic africa
sudo zic antarctica
sudo zic asia
sudo zic australasia
sudo zic backward
sudo zic etcetera
sudo zic europe
sudo zic factory
sudo zic northamerica
sudo zic pacificnew
sudo zic southamerica
sudo zic systemv

