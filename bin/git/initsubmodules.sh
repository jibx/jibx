# git clone git@github.com:jibx/jibx.git
git submodule init
git submodule update

for dir in jibx-parent \
../core \
../schema-library \
../web-services \
../sub-projects \
../plugins; do
echo $dir
cd $dir
git checkout master
done

