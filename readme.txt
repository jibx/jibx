JiBX is a tool for binding XML data to Java objects.

This is the top-level project. The sub-projects are:

- core - main jibx code
- jibx-parent - maven shared project settings
- plugins - Maven and eclipse plugins
- web-services jibx/ws
- schema-library - Pre-built JiBX bindings

To check out a sub-project, follow the github instructions.
To check out all the projects, check out this project and use the initsubmodules script:

git clone https://github.com/jibx/jibx
cd jibx
bin/git/initsubmodules.sh

NOTE: If you want readonly access, replace line 1 with this: git clone -b readonly git://github.com/jibx/jibx.git

-- If you make a change to a submodule, use this script to sync the main(jibx) directory:

bin/git/commitpush.sh "Commiting a submodule"

To build all the projects, do the following:

cd jibx-parent
mvn install
cd ../core/build
ant -f build-ivy.xml
ant
cd ..
mv jibx_*.zip lib/
mvn install

cd ../plugins/maven-plugin/
mvn install

cd ../../schema-library
mvn install

Developers:

To release to maven central, you will need to sign up with nexus. Just follow these instructions:

https://docs.sonatype.org/display/Repository/Sonatype+OSS+Maven+Repository+Usage+Guide

For jibx, you will need to make some changes to your ~/.m2/settings.xml file:

  1. Your sourceforge vcs user name (You should probably also set your o/s for auto-ssh sign in): 
    <servers> 
    ...
        <server>
            <id>jibx.git.sourceforge.net</id>
            <username>doncorley</username>
            <password>***enter-your-password-here***</password>
        </server>
        <server>
            <id>jibx.svn.sourceforge.net</id>
            <username>doncorley</username>
            <password>***enter-your-password-here***</password>
        </server>
        <server>
            <id>jibx.cvs.sourceforge.net</id>
            <username>doncorley</username>
            <password>***enter-your-password-here***</password>
        </server>
    </servers> 
  2. Your nexus account information:
    <server>
      <id>sonatype-nexus-snapshots</id>
      <username>doncorley</username>
      <password>***enter-your-password-here***</password>
    </server>
    <server>
      <id>sonatype-nexus-staging</id>
      <username>doncorley</username>
      <password>***enter-your-password-here***</password>
    </server>
  3. Your sourceforge user and password for documentation uploads
    <server>
      <id>sourceforge.net</id>
      <username>doncorley</username>
      <password>***enter-your-password-here***</password>
      <filePermissions>775</filePermissions>
      <directoryPermissions>775</directoryPermissions>
    </server>
  4. Your root directory and gpg passphrase:
  <profiles>
    <profile>
      <id>global-properties</id>
      <activation>
        <activeByDefault>true</activeByDefault>
      </activation>
      <properties>
        <gpg.passphrase>**Your passphrase**</gpg.passphrase>
        <workspace>/home/don/workspace-jibx/jibx</workspace>
        <jibx-root>/home/don/workspace-jibx/jibx</jibx-root>
        <sourceforge-user>doncorley</sourceforge-user>
      </properties>
    </profile>
  </profiles>
  
----------------------------------------------------------------------
# A release is similar to a install, follow these steps:
# Make sure all dependencies are up-to-date
cd ../core
rm lib/*.jar
rm lib/*.zip
cd build
# Edit the build.xml and set the correct release version
ant -f build-ivy.xml
ant
cd ..
rm lib/*.jar
rm lib/*.zip
cd build
# Edit the build.xml and set the correct release version
ant -f build-ivy.xml
ant
cd ..
mv jibx*.zip lib/
# Edit build.xml and set the next snapshot version
############## Upload core/lib/jibx_x_x_x.zip to sourceforge.
cd ..
# --NOTE---- Fix the obr location(s) ------------------
# Edit the jibx-parent file and change any <jibx-xxx> properties to point to the next release version
# Change any external parent references to the release version
# Push all changes to the git repository
cd jibx-parent
mvn release:prepare
mvn release:perform
# Edit the jibx-parent file and change any <jibx-xxx> properties to point to the next snapshot version
cd ../core
mvn versions:update-parent
mvn versions:commit
git commit -am "Preparing for release"
git push
mvn release:prepare
mvn release:perform
# Now you should remove the fake source directories that were added so maven could upload jibx source
rm -fr build/maven/jibx-run/src
rm -fr build/maven/jibx-tools/src
rm -fr build/maven/jibx-bind/src
rm -fr build/maven/jibx-schema/src
rm -fr build/maven/jibx-extras/src
# Wait for release to sync
# Now for the plugin
cd ../plugins/maven-plugin
mvn versions:update-parent
mvn versions:use-releases
mvn versions:commit
git commit -am "Preparing for release"
git push
mvn release:prepare
mvn release:perform
cd target/checkout/jibx-maven-plugin
#ssh -t doncorley,jibx@shell.sourceforge.net create
mvn site site:deploy
#-----
#ssh doncorley,jibx@shell.sourceforge.net
#ssh -t doncorley,jibx@shell.sourceforge.net create
#cd /home/project-web/jibx/htdocs/
#rm -fr jibx-maven-plugin
#cp -r jibx-maven-plugin jibx-maven-plugin
#---- Note: Add Externals here
cd ../../../../../../external
mvn versions:update-parent
mvn versions:use-releases
mvn versions:commit
git commit -am "Preparing for release"
git push
mvn release:prepare
mvn release:perform
#----
cd ../schema-library
# Edit archetype pom file to reflect the release version
mvn versions:update-parent
mvn versions:commit
git commit -am "Preparing for release"
git push
mvn release:prepare
mvn release:perform
cd target/checkout/schema-utilities/site
mvn site site:deploy
rm org.opentravel/_2010B/opentravel-schema/schema/src/main/schema/ota-schema/*.xsd
rm org.opentravel/_2011B/opentravel-schema/schema/src/main/schema/ota-schema/*.xsd
rm org.opentravel/_2011A/opentravel-schema/schema/src/main/schema/ota-schema/*.xsd
#---- Note: Add Artifacts here
cd ../artifacts
mvn versions:update-parent
mvn versions:use-releases
mvn versions:commit
git commit -am "Preparing for release"
git push
mvn release:prepare
mvn release:perform

----------------------------------------------------------------------

To deploy a snapshot, just enter your project directory and type:
mvn deploy

Don
