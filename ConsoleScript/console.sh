#!/bin/sh

start_time=$(date +%s)

echo ReadyConsole

TYPE=$1
 
echo $TYPE


read value
if [ "$value" = "dev" ]
then
echo dev
else
echo adhoc
fi


declare -a dicScheme
dicScheme=(
["1"]="sstxone0:000:游戏0"
["2"]="sstxone1:111:游戏1"
)



for key in ${!dicScheme[*]};
do
echo "$key : ${dicScheme[$key]}"
done


 

read -a Target
for var in "${Target[@]}";
do
#echo "$var"
#echo "${dicScheme[$var]}"

value=${dicScheme[$var]}
value=${value//:/ }
echo "${value[0]}     ${value[1]}     ${value[2]}"


done


end_time=$(date +%s)
total_sec=$(($end_time - $start_time))
sec=$(($total_sec%60))
min=$((($total_sec-$sec)/60))



if [ $sec -gt 10 ]
then
secTxt="${sec}"
else
secTxt="0${sec}"
fi

if [ $min -gt 10 ]
then
minTxt="${min}"
else
minTxt="0${min}"
fi


echo "耗时:   $minTxt:$secTxt"