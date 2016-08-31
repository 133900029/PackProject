#! /bin/bash


TYPE=$1
echo $TYPE

valueAll=${TYPE//=/ }
valueAll=($valueAll)

num=${#valueAll[@]}

path=2
((pathIndex= ${num}-${path}))

project=1
((projectIndex= ${num}-${project}))

declare -a dicScheme

for index in ${!valueAll[*]};
do
if [[ "$index" != "$pathIndex" && "$index" != "$projectIndex" ]];then
    dicScheme["$index"]=${valueAll[$index]}
fi
done

PROJECT_NAME="Unity-Iphone" 
PROJECT_PATH=${valueAll[$pathIndex]}


PROJECT_IPA=${valueAll[$projectIndex]}


echo "PROJECT_PATH : $PROJECT_PATH"
echo "PROJECT_IPA : $PROJECT_IPA"

for index in ${!dicScheme[*]}
do
 echo "Need To Export : ${dicScheme[$index]}"
done
 


echo =============start build=============

start_time=$(date +%s)

cd "$PROJECT_PATH"




for index in ${!dicScheme[*]}
do

temp=${dicScheme[$index]}
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
datemk=`date +%Y.%m.%d_%H.%M.%S`
afterName="${PROJECT_PATH}/bin/${value[2]}_${value[3]}_${value[4]}_${SchemeName}_${datemk}.ipa"

echo "beforeName : ${beforeName}"
echo "afterName : ${afterName}"

mv $beforeName $afterName

afterIpaPath="/Users/luozhuocheng/IOS/PackProject/GetIpa/${PROJECT_IPA}/${value[2]}_${value[3]}_${value[4]}_${SchemeName}_${datemk}.ipa"  

echo "afterName : ${afterName}"
echo "afterIpaPath : ${afterIpaPath}"  

cp $afterName  $afterIpaPath
  
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