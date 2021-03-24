#!/bin/bash

read -p "请输入版本号 例如 1.0.0, 输入你的版本号: " MGVERSION
read -p "请输入本次更新描述: " MGDESCRIBE

echo 你输入的版本号:"$MGVERSION", 本次更新描述:"$MGDESCRIBE"

pod lib lint --verbose --use-libraries --allow-warnings --no-clean

git add .
git commit -m "$MGDESCRIBE"
git push origin main


version=$MGVERSION

git tag -d "${version}"
git push origin :$version
git tag "${version}"
git push --tags


pod trunk push MGDataBinder.podspec

# pod repo push MGSpecs MGNetwork.podspec --allow-warnings  --verbose





# 