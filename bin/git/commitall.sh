# git submodules init
#
# git pull
# git submodules update
for dir in jibx-parent \
../core \
../web-services/jibxws \
../../web-services/xbis \
../../sub-projects \
../plugins/maven-plugin \
../../plugins/jibx-eclipse \
../../schema-library \
../../artifacts; do
echo $dir
cd $dir
git add .
git commit -m "$1" -a
git push
done

cd ..
git add .
git commit -m "$1" -a
git push

