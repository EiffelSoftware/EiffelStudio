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

	// Dependencies of local assemblies with filename `Filename'
	String [] LocalAssemblyDependencies( String Filename );

	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	String [] AssemblyDependencies( String Name, String Version, String Culture, String PublicKey );

	// Is assembly corresponding to `Filename' signed?
	bool IsSigned( String Filename );
	
	// Remove locks from the Eiffel Assembly Cache.
	void CleanAssemblies();
}
