# git clone ssh://scm.jbundle.org/scm/git/workspace
# git submodules init
# git submodules update
BINDIR=`dirname $0`
ROOTDIR=`pwd`

git init starter
cd starter
echo -e "\
target \r\n\
.settings \r\n\
.project \r\n\
.classpath \r\n\
raw_test_data* \r\n\
scratch_test_data* \r\n\
skeleton_test_data* \r\n\
*_backup_data* \r\n\
*~ \r\n\
.metadata \r\n\
*.releaseBackup \r\n\
release.properties" \
> .gitignore
git add .
git commit -m "Set up initial repository with .gitignore"
cd ..

mkdir workspace
cd workspace
git --bare init
git update-server-info
cd ../starter
git push ../workspace master

for dir in tourapp \
other \
jbundle/jbundle-parent \
jbundle/jbundle \
jbundle/app/contact \
jbundle/app/picture \
jbundle/app/dance \
jbundle/misc \
jbundle/util/biorhythm \
jbundle/util/calendarpanel \
jbundle/util/jcalendarbutton \
jbundle/util/other \
jbundle/util/util \
jbundle/util/webapp \
jbundle/util/wsdl; do
echo $dir
cd $ROOTDIR/workspace
mkdir -p $dir
cd $dir
git --bare init
mv hooks/post-update.sample hooks/post-update
git update-server-info # Being careful
echo $dir project > description
cd $ROOTDIR/starter
git push $ROOTDIR/workspace/$dir master
done

cd $ROOTDIR
rm -fr starter
