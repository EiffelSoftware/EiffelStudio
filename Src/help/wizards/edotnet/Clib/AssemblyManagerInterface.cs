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
		Done = new ArrayList();
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
	
	// Dependencies of local assemblies with filename `Filename'
	public String [] LocalAssemblyDependencies( String Filename )
	{
		Assembly assembly, aDependency;
		ArrayList dependencies;
		int i, j;
		String [] localDependencies, assemblyDependencies;
		String aLocation, aFullName;
		
		assembly = Assembly.LoadFrom( Filename );
		if( assembly != null )
		{
			dependencies = InternLocalAssemblyDependencies( assembly );
			if( dependencies != null )
			{
				localDependencies = new String [dependencies.Count];
				for( i = 0; i < dependencies.Count; i++ )
					localDependencies [i] = ( ( Assembly )dependencies [i] ).Location;
			
				assemblyDependencies = new String [2 * localDependencies.Length];
				j = 0;
				for( i = 0; i < localDependencies.Length; i++ )
				{
					aLocation = ( String )localDependencies [i];
					aDependency = Assembly.LoadFrom( aLocation );
					aFullName = aDependency.FullName;
					aFullName = aFullName.Substring( 0, aFullName.IndexOf( "Version" ) );
					aFullName = aFullName.TrimEnd();
					aFullName = aFullName.Replace( ",", "" );
					assemblyDependencies [j] = aFullName;

					assemblyDependencies [j + 1] = aLocation;
					j = j + 2;
				}
				return assemblyDependencies;
			}
			else
				return null;
		}
		else
			return null;
	}
	
	// Dependencies of the assembly with `Name', `Version', `Culture' and `PublicKey'
	public String [] AssemblyDependencies( String Name, String Version, String Culture, String PublicKey )
	{
		AssemblyDescriptor Descriptor, ADescriptor;
		ISE.AssemblyManager.Support support;
		Object [] Dependencies;	
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
			AName = ( AssemblyName )Dependencies [i];
			ADescriptor = convert.AssemblyDescriptorFromName( AName );
			
			assemblyDependencies [j] = ADescriptor.Name;
			assemblyDependencies [j + 1] = ADescriptor.Version;
			assemblyDependencies [j + 2] = ADescriptor.Culture;
			assemblyDependencies [j + 3] = ADescriptor.PublicKey;	
			
			reflectionInterface.Search( ADescriptor );
			if( reflectionInterface.Found )
			{
				anEiffelAssembly = reflectionInterface.SearchResult;
				if( anEiffelAssembly != null )			
					assemblyDependencies [j + 4] = anEiffelAssembly.EiffelClusterPath;
			}
			j = j + 5;
		}
		return assemblyDependencies;
	}

	// Is assembly corresponding to `Filename' signed?
	public bool IsSigned( String Filename )
	{
		AssemblyName AName;
		Array Key;
		
		AName = AssemblyName.GetAssemblyName( Filename );
		Key = AName.GetPublicKey();
		if( Key != null )
			return( Key.Length > 0 );
		else
			return false;
	}

	// Remove locks from the Eiffel Assembly Cache.
	public void CleanAssemblies()
	{
		ReflectionSupport support;
		
		support = new ReflectionSupport();
		support.Make();
		support.CleanAssemblies();
		RInterface.SetLastError( null );
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

	protected ArrayList InternLocalAssemblyDependencies( Assembly assembly )
	{
		ArrayList dependencies;
		AssemblyName [] references;
		int i, Added;
		AssemblyName aDependency;
		Assembly newAssembly;
		
		dependencies = new ArrayList();
		references = assembly.GetReferencedAssemblies();
		if( references != null )
		{			
			for( i = 0; i < references.Length; i ++ )
			{
				aDependency = references [i];
				if( !( Done.Contains( aDependency.FullName ) )&& !( aDependency.FullName.Equals( "Microsoft.VisualC, Version=7.0.9249.59748, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" ) ) )
				{
					newAssembly = Assembly.Load( aDependency );
					Added = Done.Add( aDependency.FullName );
					dependencies.AddRange( InternLocalAssemblyDependencies( newAssembly ) );
					Added = dependencies.Add( newAssembly );
				}
			}
		}
		return dependencies;
	}
	
	// Was last importation successful?
	private bool PrivateLastImportationSuccessful;
	
	// Reflection interface	
	protected ReflectionInterface RInterface;
	
	// Loaded assemblies, used in `InternLocalAssemblyDependencies'
	protected ArrayList Done;
}

