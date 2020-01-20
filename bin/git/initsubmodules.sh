# git clone git@github.com:jibx/jibx.git
git submodule init
git submodule update

for dir in jibx-parent \
../core \
../web-services/jibxws \
../../web-services/xbis \
../../sub-projects \
../plugins/maven-plugin \
../../plugins/jibx-eclipse \
../../schema-library \
../artifacts; do
echo $dir
cd $dir
git checkout master
done

