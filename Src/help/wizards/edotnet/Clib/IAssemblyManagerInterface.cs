using System;
using System.Runtime.InteropServices;

[InterfaceTypeAttribute (ComInterfaceType.InterfaceIsIUnknown)]
public interface IAssemblyManagerInterface
{
	// Assemblies in the Eiffel assembly cache
	String [] ImportedAssemblies();

	// Was last importation successful?
	bool LastImportationSuccessful();

	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	String AssemblyLocation( String Name, String Version, String Culture, String PublicKey );

	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	String [] AssemblyDependencies( String Name, String Version, String Culture, String PublicKey );
	
	// Remove locks from the Eiffel Assembly Cache.
	void CleanAssemblies();
}
