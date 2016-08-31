#! /bin/bash


PROJECT_NAME="Unity-Iphone"
PROJECT_PATH="/Users/luozhuocheng/IOS/PackProject/LingYu"

echo check the unity version and xcode version
echo input configuration dev/dis

declare -a dicScheme

read version

if [ "$version" = "dev" ];
then

dicScheme=(
["1"]="AppStore:changyuyouxi_distribution:1000001:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5"
)    
elif [ "$version" = "dis" ];
then
dicScheme=(
["1"]="AppStore:changyuyouxi_distribution:1000001:游戏名字:adhoc:cdf78db7-5cfe-4cfd-9c9a-821ff9743ae5"
)
  
else
echo ============error
exit 0
fi





for key in ${!dicScheme[*]};
do
tSchemeValue=${dicScheme[$key]}
tSchemeValue=${tSchemeValue//:/ }
tSchemeValue=($tSchemeValue)

echo "$key : ${tSchemeValue[0]} ${tSchemeValue[3]}  ${tSchemeValue[2]}  ${tSchemeValue[4]}"
done


echo input the value y/n
read go
if [ "$go" != "y" ]
then
echo ============stop
exit 0
fi



echo input num

read -a SCHEME_NUM

echo start build

start_time=$(date +%s)


cd "$PROJECT_PATH"

for var in "${SCHEME_NUM[@]}";
do

temp=${dicScheme[$var]}
value=${temp//:/ }
value=($value)
#echo "$var  :  ${value[0]} 1 ${value[1]} 2 ${value[2]} 3 ${value[3]}"

SchemeName=${value[0]}
ProvisionName=${value[1]}
UUID=${value[5]}


echo $SchemeName
echo $ProvisionName


xcodebuild clean -project "${PROJECT_NAME}".xcodeproj -target "${SchemeName}" -configuration Release

xcodebuild archive -project "${PROJECT_NAME}".xcodeproj -scheme "${SchemeName}" -destination generic/platform=iOS -archivePath bin/"${PROJECT_NAME}".xcarchive PROVISIONING_PROFILE="${UUID}"

xcodebuild -exportArchive -archivePath bin/"${PROJECT_NAME}".xcarchive -exportPath bin/"${SchemeName}" -exportFormat ipa -exportProvisioningProfile "${ProvisionName}"

beforeName="${PROJECT_PATH}/bin/${SchemeName}.ipa"
afterName="${PROJECT_PATH}/bin/${value[2]}_${value[3]}_${value[4]}_${SchemeName}.ipa"

mv $beforeName $afterName

done


echo end build

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

