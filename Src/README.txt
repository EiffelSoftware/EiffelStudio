----------------------------------------------------------
:Status: in progress
:Description: quick help to use the build.eant script
:Date: 2008-Jan-31
:Categories: ec,compilation,build,scripts
----------------------------------------------------------

The geant's script  $EIFFEL_SRC/scripts/deliv.eant can be used to make a
developper delivery for "ec"
and other product from EiffelStudio open source project.

1) First you need to checkout the source.
for instance
svn checkout https://svn.eiffel.com/eiffelstudio/trunk ESdev

Note: the whole trunk or branches is checkouted into a single folder

2) go to your compilation directory
for instance
cd $HOME/compile

3) You must be sure to have valid environment variables: $ISE_EIFFEL, EIFFEL_SRC, (and for Windows ISE_C_COMPILER)

4) using geant 
* To check if your environment fulfills the requirement
	geant -b $EIFFEL_SRC/build.eant check_setup

* To prepare 'ec' compilation, you need to compile various C libraries 
	geant -b $EIFFEL_SRC/build.eant prepare

* To finalize 'ec' bench
	geant -b $EIFFEL_SRC/build.eant compile

* To compile (workbench) 'ec' bench
	geant -b $EIFFEL_SRC/build.eant compile_workbench

* To make a EiffelStudio delivery  (developper)
	geant -b $EIFFEL_SRC/build.eant make_delivery

Those scripts are in progress for now.
Please report any issue on the forum: http://eiffelstudio.origo.ethz.ch/

-------------------------------------------
 Web: http://dev.eiffel.com/
 Web: http://eiffelstudio.origo.ethz.ch/
-------------------------------------------
