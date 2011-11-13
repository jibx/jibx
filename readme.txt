JiBX is a tool for binding XML data to Java objects.

This is the top-level project. The sub-projects are:

- core - main jibx code
- jibx-parent - maven shared project settings
- plugins - Maven and eclipse plugins
- web-services jibx/ws
- schema-library - Pre-built JiBX bindings

To check out a sub-project, follow the github instructions.
To check out all the projects, check out this project and use the initsubmodules script:

git clone git@github.com:jibx/jibx.git
cd jibx
bin/git/initsubmodules.sh

-- If you make a change to a submodule there you must sync this master project by doing this from the main(jibx) directory:

bin/git/commitall.sh "Commiting a submodule"

To build all the project, do the following:

cd jibx-parent
mvn install
cd ../core/build
ant -f build-ivy.xml
ant
cd maven
mvn install

cd ../../../plugins/maven-plugin/
mvn install

Developers:

To deploy to maven central, you will need to sign up with nexus. Just follow these instructions:

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
        <jibx-root>/home/don/workspace-jibx/jibx</jibx-root>
        <sourceforge-user>doncorley</sourceforge-user>
      </properties>
    </profile>
  </profiles>

To deploy a snapshot, just enter your project directory and type:
mvn deploy

Your users should be able to change their jibx version number to your snapshot version x.x.x-SNAPSHOT
and it should work. (Although there have been some problems lately with snapshot compatibility
between maven 2 and maven 3)

Don
