export REPO_LOCATION=/home/glassfish/sonatype-work/nexus/storage
export PROGRAM_LOCATION=/usr/local/java
# export WEB_LOCATION=/web/web/jbundle
export WEB_LOCATION=$REPO_LOCATION/repository
cd $REPO_LOCATION/snapshots
java -jar $PROGRAM_LOCATION/dev/bindex/bindex.jar -quiet -r snapshot-repository.xml -t http://snapshot.jbundle.org:8081/nexus/content/repositories/snapshots/%p/%f *
cp snapshot-repository.xml $WEB_LOCATION/
cd $REPO_LOCATION/releases
java -jar $PROGRAM_LOCATION/dev/bindex/bindex.jar -quiet -r release-repository.xml -t http://repository.jbundle.org:8081/nexus/content/repositories/releases/%p/%f *
cp release-repository.xml $WEB_LOCATION/
