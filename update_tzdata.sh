#!/bin/bash
# author: Ed Lujan
# Based on http://helw.net/2011/04/28/updating-osx-for-egypts-dst-changes/ by Ahmed El-Helw and https://gist.github.com/tgirardi/95abcfafd5fefd6df02d3a8e6247834d by Tomás Girardi

# CHANGE THIS: 
# go to https://www.iana.org/time-zones and get the URL for the last DATA
# release

TZDATAVERSION="tzdata2016j"
TZDATAFILE="${TZDATAVERSION}.tar.gz"
URLTZDATASRC="https://www.iana.org/time-zones/repository/releases/${TZDATAFILE}"
TZDATADIR="/tmp/tzdata"
# Update tzdata
if [ -d "${TZDATADIR}" ]; then
  rm -rf "${TZDATADIR}"
fi
mkdir "${TZDATADIR}"
cd "${TZDATADIR}"
wget "${URLTZDATASRC}"
tar -xvzf "${TZDATAFILE}"
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
echo "${TZDATAVERSION} installed"
echo "Done ..."

# Install icu4version
ICUVERSION=`ls /usr/share/icu/*.dat | grep -o "\(\d\d\)l\.dat" | grep -o "^\d\d"`
URLICUSRC="http://download.icu-project.org/files/icu4c/${ICUVERSION}.1/icu4c-${ICUVERSION}_1-src.zip"
ICUDIR="/tmp/icu4c"
cd "${ICUDIR}"
if [ -d "${ICUDIR}" ]; then
  rm -rf "${ICUDIR}"
fi
mkdir "${ICUDIR}"
cd "${ICUDIR}"
wget "${URLICUSRC}" -O icusrc.tar.gz
tar -xvzf icusrc.tar.gz
cd icu/source/tools/tzcode
# Download the same version of tzdata
wget "${URLTZDATASRC}"
cd ../../
# Compile
./runConfigureICU MacOSX --with-data-packaging=archive
gnumake
sudo install -o root -g wheel -m 0644 -Sp "data/out/icudt${ICUVERSION}l.dat" "/usr/share/icu/icudt${ICUVERSION}l.dat"
echo "${ICUVERSION} installed"
echo "Done ..."


