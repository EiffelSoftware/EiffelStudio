----------------------------------------------------------
:Status: in progress
:Description: quick help to use the build.eant script
:Date: 2006-Oct-27
:Categories: ec,compilation,build,scripts
----------------------------------------------------------

The geant's script  $EIFFEL_SRC/scripts/build.eant can be used to compile "ec"
and other product from EiffelSoftware open source project.

1) First you need to checkout the source.
for instance
svn checkout https://eiffelsoftware.origo.ethz.ch/svn/es/branches/Eiffel_57 57dev

Note: the whole trunk or branches is checkouted into a single folder

2) go to your compilation directory
for instance
cd $HOME/compile

3) You must be sure to have valid environment variables: $ISE_EIFFEL, EIFFEL_SRC, and ISE_C_COMPILER (on windows only) 

4) using geant 
	geant -b $EIFFEL_SRC/scripts/build.eant
Will display the usage of this script
If you want to compile a finalized "ec"
You must do
		--| Compile the ISE runtime
	geant -b $EIFFEL_SRC/scripts/build.eant compile_runtime
		--| Compile the various clib (c code) of various ISE libraries
		--| And also third party c libraries (zip, png ...)
		--| Install ISE´s patched gobo library
	geant -b $EIFFEL_SRC/scripts/build.eant compile_library

And then
	geant -b $EIFFEL_SRC/scripts/build.eant finalize_ec
	geant -b $EIFFEL_SRC/scripts/build.eant finalize_estudio

Those scripts are in progress for now.
Please report any issue to es-develop@origo.ethz.ch (or jfiat@eiffel.com)

-------------------------------------------
 Web: http://eiffelsoftware.origo.ethz.ch/
-------------------------------------------
