JiBX developers.

We have a new project setup.

Since we often must access files from another sub-repository, we need a standardized top-level
directory structure. Here is our initial project structure. If you would like to change something,
please feel free:

jibx (root) (git)
- core (main jibx code - Dennis) (cvs)
- main (core shadow project - This can be merged into core when Dennis moves from cvs) (git)
- jibx-parent (maven shared project settings) (git)
- plugins (All plugins will go here)
-- maven-plugin (maven-jibx-plugin directory - Don) (git)
- web-services (All web-services projects)
-- jibxws (jibx/ws - Nigel) (svn)
-- jibxws-mvn (jibxws shadow project - will be merged into jibxws) (git)
- schema-library (new project - Don) (git)

The main project is checked into git. I'm still trying to figure out how to get sub-modules
working correctly under git/sourceforge. You may have to manually checkout your sub-project
in the correct location in the directory tree:

Try this:
git clone ssh://sfusername@jibx.git.sourceforge.net/gitroot/jibx/jibx
cd jibx
bin/git/initsubmodules.sh
(if this doesn't work, load the submodules manually:
cat .gitmodules
git clone ssh://sfusername@jibx.git.sourceforge.net/gitroot/jibx/jibxws-mvn web-services/jibxws-mvn
...etc.

Manually add the non-git repos to your project:
cvs -z3 -d:ext:sfusername@jibx.cvs.sourceforge.net:/cvsroot/jibx checkout core

cvs -z3 -d:pserver:anonymous@xbis.cvs.sourceforge.net:/cvsroot/xbis co -P web-services/xbis

svn co https://jibx.svn.sourceforge.net/svnroot/jibx/jibxws/trunk web-services/jibxws

Next, you will need to sign up with nexus so you can deploy to maven central. Just follow these instructions:

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
