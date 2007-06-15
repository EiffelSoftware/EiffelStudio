Welcome to the distribution of Gobo from EiffelSoftware.

Here are some information on this distribution:

 * The Gobo binaries are located in spec/$ISE_PLATFORM/bin.

 * The documentation is available from http://www.gobosoft.com

 * The samples can be compiled using the gobo_sample.ecf file and replacing the
   THE_ROOT_CLASS_HERE by the actual name of the root class for the sample you chose.

   Some samples requires some additional generated files. To add them to your project follow theses
   instructions:

     If your sample is in svn/example/MY_EXAMPLE, simply add the following to your ecf file:
		<cluster name="sample_generated" location="$ISE_LIBRARY\library\gobo\example\MY_EXAMPLE"
			recursive="true"/>
	
Happy Eiffeling,
The EiffelSoftware Team	
