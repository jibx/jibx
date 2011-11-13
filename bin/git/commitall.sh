# git submodules init
#
# git pull
# git submodules update
for dir in jibx-parent \
../main \
../schema-library \
../web-services/jibxws-mvn \
../../web-services/xbis-jibx-mvn \
../../plugins/maven-plugin; do
echo $dir
cd $dir
git add .
git commit -m "$1" -a
git push
done

cd ../..
git add .
git commit -m "$1" -a
git push

