using System;
using System.Collections;
using System.Reflection;
using ISE.Reflection;

using System.Runtime.InteropServices;

	[ClassInterfaceAttribute (ClassInterfaceType.None)]


public class AssemblyManagerInterface: IAssemblyManagerInterface
{
	// Initialize `RInterface'.
	public AssemblyManagerInterface()
	{
		RInterface = new ReflectionInterface();
		RInterface.MakeReflectionInterface();
	}
	
	// Assemblies in the Eiffel assembly cache
	public String [] ImportedAssemblies()
	{
		ArrayList ImportedAssemblies;

		ImportedAssemblies = RInterface.Assemblies();
		if( ImportedAssemblies != null )
		{	
			if( RInterface.LastError != null )
			{
				if( ( RInterface.LastError.Code == RInterface.HasReadLockCode() )|| ( RInterface.LastError.Code == RInterface.HasWriteLockCode() ) )
				{
					PrivateLastImportationSuccessful = false;
					return( new String [0] );
				}
				else
					return PrivateImportedAssemblies( ImportedAssemblies );				
			}
			else
				return PrivateImportedAssemblies( ImportedAssemblies );
		}			
		else
		{
			PrivateLastImportationSuccessful = false;
			return( new String [0] );
		}
	}

	// Was last importation successful?
	public bool LastImportationSuccessful()
	{
		return PrivateLastImportationSuccessful;
	}	
		
	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	public String AssemblyLocation( String Name, String Version, String Culture, String PublicKey )
	{
		AssemblyDescriptor Descriptor;
		ConversionSupport Support;
		AssemblyName AName;
		Assembly assembly;
		String Location;
		
		Descriptor = new AssemblyDescriptor();
		Descriptor.Make( Name, Version, Culture, PublicKey );
		if( !( ( Descriptor.Name.Equals( "Microsoft.VisualC" ) )&&( Descriptor.Version.Equals( "7.0.9249.59748" ) ) ) )
		{
			Support = new ConversionSupport();
			AName = Support.AssemblyNameFromDescriptor( Descriptor );
			if( AName != null )
			{
				assembly = Assembly.Load( AName );
				Location = assembly.Location;
				if( Location != null )
					return Location;
				else
					return "";
			}
			else
				return "";	
		}
		else
			return "";
	}
	
	// Location of the assembly with `Name', `Version', `Culture' and `PublicKey'
	public String [] AssemblyDependencies( String Name, String Version, String Culture, String PublicKey )
	{
		AssemblyDescriptor Descriptor, ADescriptor;
		ISE.AssemblyManager.Support support;
		AssemblyName [] Dependencies;	
		AssemblyName AName;
		ConversionSupport convert;
		int i, j;
		String [] assemblyDependencies;	
		EiffelAssembly anEiffelAssembly;
		ReflectionInterface reflectionInterface;
		
		Descriptor = new AssemblyDescriptor();
		Descriptor.Make( Name, Version, Culture, PublicKey );
		support = new ISE.AssemblyManager.Support();
		support.Make();
		Dependencies = support.DependanciesFromInfo( Descriptor );
		
		assemblyDependencies = new String [Dependencies.Length * 5];
		convert = new ConversionSupport();
		reflectionInterface = new ReflectionInterface();
		reflectionInterface.MakeReflectionInterface();
		
		j = 0;
		for( i = 0; i < Dependencies.Length; i++ )
		{
			AName = Dependencies [i];
			ADescriptor = convert.AssemblyDescriptorFromName( AName );
			reflectionInterface.Search( ADescriptor );
			if( reflectionInterface.Found )
			{
				anEiffelAssembly = reflectionInterface.SearchResult;
				if( anEiffelAssembly != null )
				{
					assemblyDependencies [j] = ADescriptor.Name;
					assemblyDependencies [j + 1] = ADescriptor.Version;
					assemblyDependencies [j + 2] = ADescriptor.Culture;
					assemblyDependencies [j + 3] = ADescriptor.PublicKey;				
					assemblyDependencies [j + 4] = anEiffelAssembly.EiffelClusterPath;
					j = j + 5;
				}
			}
		}
		return assemblyDependencies;
	}

	// Remove locks from the Eiffel Assembly Cache.
	public void CleanAssemblies()
	{
		ReflectionSupport support;
		
		support = new ReflectionSupport();
		support.Make();
		support.CleanAssemblies();
	}
	
	protected String [] PrivateImportedAssemblies( ArrayList ImportedAssemblies )
	{
		int i, j;
		String [] Assemblies;
		EiffelAssembly AnAssembly;
		
		Assemblies = new String [ImportedAssemblies.Count * 5];			
		j = 0;
		for( i = 0; i < ImportedAssemblies.Count; i++ )
		{
			AnAssembly = ( EiffelAssembly )ImportedAssemblies [i];
			if( AnAssembly != null )
			{
				Assemblies [j] = AnAssembly.AssemblyDescriptor.Name;
				Assemblies [j + 1] = AnAssembly.AssemblyDescriptor.Version;
				Assemblies [j + 2] = AnAssembly.AssemblyDescriptor.Culture;
				Assemblies [j + 3] = AnAssembly.AssemblyDescriptor.PublicKey;
				Assemblies [j + 4] = AnAssembly.EiffelClusterPath;
				j = j + 5;
			}
		}
		PrivateLastImportationSuccessful = true;
		return Assemblies;
	}

	// Was last importation successful?
	private bool PrivateLastImportationSuccessful;
	
	// Reflection interface	
	protected ReflectionInterface RInterface;
}

