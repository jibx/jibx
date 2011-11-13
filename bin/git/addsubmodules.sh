# git clone ssh://scm.jbundle.org/scm/git/workspace
# git submodules init
# git submodules update

for dir in jibx-parent \
../core \
../schema-library \
../web-services \
../sub-projects \
../plugins; do
echo $dir
git submodule add ssh://scm.jbundle.org/scm/git/workspace/$dir $dir
done

