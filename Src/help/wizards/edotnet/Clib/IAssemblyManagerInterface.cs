using System;
using System.Runtime.InteropServices;

[InterfaceTypeAttribute (ComInterfaceType.InterfaceIsIUnknown)]
public interface IAssemblyManagerInterface
{
	// Assemblies in the Eiffel assembly cache
	String [] ImportedAssemblies();

	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	String AssemblyLocation( String Name, String Version, String Culture, String PublicKey );

	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	String [] AssemblyDependencies( String Name, String Version, String Culture, String PublicKey );
}
