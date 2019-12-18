#!/bin/bash
now=`date +%s`

if [ ! -z $1 ] && [ $1 == "update" ]
then
curl -s https://bimasislam.kemenag.go.id/widget/jadwalshalat/42d38931fbd98d4764cc39ab8694a0f1f42d2e7d > jadwal-hari-ini.txt 
echo "SELAMAT WAKTU TELAH DI UPDATE: JAKARTA"
fi

date2=`ls jadwal-hari-ini.txt `
if [ ! -z $date2 ]
then
date=`ls -alt jadwal-hari-ini.txt  | awk '{print $7 " "$6}'`
echo "waktu sholat JAKARTA date: $date"
else
echo "waktu sholat kosong"
curl -s https://bimasislam.kemenag.go.id/widget/jadwalshalat/42d38931fbd98d4764cc39ab8694a0f1f42d2e7d > jadwal-hari-ini.txt 
fi


  # ims=$(cat jadwal-hari-ini.txt | grep -A3 'IMSAK' | tail -1 | sed 's/\t//g')
  # sbh=$(cat jadwal-hari-ini.txt | grep -Po "wsbh='\K[^']*")
  # dha=$(cat jadwal-hari-ini.txt | grep -A3 'DHUHA' | tail -1 | sed 's/\t//g')
zuhur=$(cat jadwal-hari-ini.txt | grep -Po "wdhr = '\K[^']*")
asar=$(cat jadwal-hari-ini.txt | grep -A3 'ASHAR' | tail -1 | sed 's/\t//g')
margb=$(cat jadwal-hari-ini.txt | grep -Po "wmgh = '\K[^']*")
isya=$(cat jadwal-hari-ini.txt | grep -Po "wisy = '\K[^']*")

if [ ! -z $zuhur ]
then
formatz=`date -d "$zuhur" +%s`
sz=`expr $formatz \- $now`
zuhur1=`expr $sz / 60`
else
echo "waktu sholat zuhur blank"
fi

if [ ! -z $asar ]
then
formatsr=`date -d "$asar" +%s`
sz1=`expr $formatsr \- $now`
asar1=`expr $sz1 / 60`
else
echo "waktu sholat asar blank"
fi

if [ ! -z $margb ]
then
formatmg=`date -d "$margb" +%s`
sz2=`expr $formatmg \- $now`
magrib1=`expr $sz2 / 60`
else
echo "waktu sholat magrib blank"
fi

if [ ! -z $isya ]
then
formatsy=`date -d "$isya" +%s`
sz3=`expr $formatsy \- $now`
isya1=`expr $sz3 / 60`
else
echo "waktu sholat isya blank"
fi

if [ $zuhur1 -lt "1" ]
then
	echo "waktu zuhur lewat $zuhur1 menit: $zuhur"
#	zenity --info --text="ZUHUR LEWAT $zuhur1 menit"
#	`mplayer fajr_128_44.mp3`
else
	echo "waktu zuhur dimulai dalam $zuhur1 menit: $zuhur"
fi

if [ $asar1 -lt "1" ]
then
	echo "waktu asar lewat $asar1 menit: $asar"
else
	echo "waktu asar dimulai dalam $asar1 menit: $asar"
fi

if [ $magrib1 -lt "1" ]
then
	echo "waktu magrib lewat $magrib1 menit: $margb"
else
	echo "waktu magrib dimulai dalam $magrib1 menit: $margb"
fi

if [ $isya1 -lt "1" ]
then
	echo "waktu isya lewat $isya1 menit: $isya"
else
	echo "waktu isya dimulai dalam $isya1 menit: $isya"
fi
