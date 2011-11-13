# git submodules init
#
# git pull
# git submodules update
for dir in jibx-parent \
../core \
../schema-library \
../web-services \
../sub-projects \
../plugins; do
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

