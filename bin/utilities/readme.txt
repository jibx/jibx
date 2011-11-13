NOTE: You MUST run jibx-move-temp before you can use this project.
(jibx-move-temp moves the current source code into this project)

Issues that need resolving before moving to maven:

0. I need to figure out how to replace the version in the source code (@distrib@)
   (or have Dennis get the version from the manifest)
1. Make sure optimize/debug works for release/SNAPSHOT
2. How should jdom/dom4j support be done?
3. Need to use/move package.html files to documentation or pom desc.
4. Optimize and document dependencies and scope
5. Can implementation packages be removed from (osgi) visibility?
6. Where does org.jibx.v2 go?
7. jibx-run: Should joda-time and xpp be runtime dependencies?
8. jibx-extras: Should jdom and dom4j be compile (optional) dependencies?
9. jibx-bind: Should bcel and qdox be compile and log4j be runtime dependencies?
10. osgi includes need to be optimized (not critical)
11. jibx.plugin.version must be the previous version due to bootstrapping concerns

