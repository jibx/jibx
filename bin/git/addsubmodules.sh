# git clone ssh://scm.jbundle.org/scm/git/workspace
# git submodules init
# git submodules update

for dir in core \
../jibx-parent \
../jibx-install-current-jars \
../main \
../schema-library \
../plugins/maven-plugin; do
echo $dir
git submodule add ssh://scm.jbundle.org/scm/git/workspace/$dir $dir
done

