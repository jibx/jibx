#!/bin/bash

export BINDEX=/opt/osgi/bindex/bindex.jar
export REPOSITORY=~/.m2/repository

export JBUNDLE_VERSION=0.8.0
export TOURGEEK_VERSION=0.8.0
export JBUNDLE_SNAPSHOT_VERSION=0.8.0-SNAPSHOT
export TOURGEEK_SNAPSHOT_VERSION=0.8.0-SNAPSHOT
export REPO_VERSION=1.3.2
cd ~/temp

# ---------------- external -----------------
rm -fr repository maven2
mkdir repository
cd repository

PACKAGE='A'
VERSION='B'

sync_package () {
  echo "Inside function: var1: $PACKAGE, var2: $VERSION"
  mkdir -p $PACKAGE
  rsync -r $REPOSITORY/$PACKAGE/$VERSION $PACKAGE
}

#PACKAGE=javax/xml/soap/javax.xml.soap-api
#VERSION=1.4.0
#sync_package

PACKAGE=joda-time/joda-time
VERSION=2.10.5
sync_package

PACKAGE=org/apache/servicemix/bundles/org.apache.servicemix.bundles.jdom
VERSION=1.1_4
sync_package

PACKAGE=org/apache/servicemix/bundles/org.apache.servicemix.bundles.dom4j
VERSION=1.6.1_5
sync_package

PACKAGE=org/apache/servicemix/bundles/org.apache.servicemix.bundles.xpp3
VERSION=1.1.4c_6
sync_package

#PACKAGE=org/apache/servicemix/bundles/org.apache.servicemix.bundles.saaj-impl
#VERSION=1.5.1_1
#VERSION=1.3.20_1
#sync_package

#PACKAGE=com/sun/activation/jakarta.activation
#VERSION=1.2.1
#sync_package
#
#PACKAGE=org/jvnet/staxex/stax-ex
#VERSION=1.7.4
#sync_package
#
#PACKAGE=javax/xml/stream/stax-api
#VERSION=1.0-2
#sync_package

PACKAGE=
VERSION=
# sync_package

cd ..
java -jar $BINDEX -quiet -r ~/.m2/jibx-external-repository.xml -t file:/home/don/.m2/%p/%f ~/temp/repository
mv repository maven2
java -jar $BINDEX -quiet -r ~/workspace-jibx/jibx/bin/obr/repository/jibx-external-repository-$REPO_VERSION.xml -t https://repo.maven.apache.org/%p/%f  ~/temp/maven2
# rm -fr maven2
