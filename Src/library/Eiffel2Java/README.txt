Eiffel2Java interface library.

This library needs the include files for JNI and the JVM library to be found by the compiler.
On UNIX this can normally be done by doing something like

export JAVA_HOME="/usr/lib/j2sdk1.5-sun"
export CPATH=$CPATH:"$JAVA_HOME/include;$JAVA_HOME/include/linux"
export LIBRARY_PATH=$LIBRARY_PATH:"$JAVA_HOME/jre/lib/amd64/server"
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"$JAVA_HOME/jre/lib/amd64/server"

JAVA_HOME and the path to the libjvm.so library may have to be changed to fit the local installation.

On windows with Microsoft C compiler this can be done by adding the paths to environment variables, e.g.:

INCLUDE: C:\Program Files\Java\jdk1.5.0_06\include;C:\Program Files\Java\jdk1.5.0_06\include\win32 (directories where the jni.h and jni_md.h are)
LIB: C:\Program Files\Java\jdk1.5.0_06\lib (directory where the jvm.lib is)
PATH: C:\Program Files\Java\jre1.5.0_06\bin\client (directory where the jvm.dll is, needed to run the compiled program)
