# git clone ssh://jibx.git.sourceforge.net/gitroot/jibx/jibx 
git submodule init
git submodule update

for dir in jibx-parent \
../main \
../schema-library \
../web-services/jibxws-mvn \
../../web-services/xbis-jibx-mvn \
../../plugins/maven-plugin; do
echo $dir
cd $dir
git checkout master
done

