using System;
using System.Collections;
using System.Reflection;
using System.Reflection.Emit;
using System.IO;
//using ISE.Reflection.EiffelComponents;
//using ISE.Reflection.CodeGenerator;
//using ISE.Reflection.Support;
//using ISE.Reflection.ReflectionInterface;
//using ISE.Reflection.EiffelAssemblyCacheHandler;
//using ISE.Reflection.EiffelAssemblyCacheNotifier;
//using ISE.Reflection;
using System.Runtime.InteropServices;

[ClassInterfaceAttribute (ClassInterfaceType.AutoDual)]

public class EiffelClassGenerator: Globals
{
	// Initialize instance
	public EiffelClassGenerator()
	{
	}


/*
 * When the emitter is used as an executable file
 */
	// Generate Eiffel code an Xml files in `Pathname' corresponding to assembly in `Filename'.
	// Filename: Name of file to be analyzed
	// Pathname: Path to folder where Eiffel code should be generated
	virtual internal void Emit( String FileName, String PathName )
	{
		Assembly assembly;
		bool IsImported;
		String Path;
		
		assembly = Assembly.LoadFrom( FileName );
		IsImported = IsAssemblyImported( assembly );
		if( PathName == null )
		{
			Path = Environment.CurrentDirectory;
			EmitFromAssembly( assembly, Path, IsImported, false );
		}
		else
		{
			if( PathName.Length == 0 )
			{
				Path = Environment.CurrentDirectory;
				EmitFromAssembly( assembly, Path, IsImported, false );
			}
			else
				EmitFromAssembly( assembly, PathName, IsImported, false );
		}
		ImportAssemblyDependencies( assembly, PathName, NameFormatter.EiffelFormatting );
	}	
	
	
/*
 * When the emitter is used as a .NET assembly from ISE assembly manager
 */
 
	// Import `assembly' with its dependencies.
	virtual public void ImportAssemblyWithDependancies( Assembly assembly, String PathName, bool EiffelFormatting )
	{
		ImportAssemblyWithoutDependancies( assembly, PathName, EiffelFormatting, true, false );
		ImportAssemblyDependencies( assembly, PathName, EiffelFormatting );
	}
	
	// Generate Eiffel code from XML files corresponding to assemblies in `ImportedAssemblies'.
	// Pathname: Path to folder where Eiffel code should be generated	
	virtual public void GenerateEiffelClassesFromXml( Assembly assembly, String PathName )
	{	
		EmitEiffelClassesFromXml( assembly, PathName );
	}


/*
 * Implementation
 */ 	

	// Import `assembly' without any dependencies.
	virtual protected void ImportAssemblyWithoutDependancies( Assembly assembly, String PathName, bool EiffelFormatting, bool XmlGeneration, bool IsDependency )
	{
		Emitter emitter;
		String Path;
		bool Imported;
		
		Imported = IsAssemblyImported( assembly );
		if( !Imported ||( XmlGeneration && !IsDependency ) )
		{
			if( !Imported )
			{
				emitter = new Emitter();
				Emitter.NameFormatter.EiffelFormatting = EiffelFormatting;
				Emitter.NameFormatter.XmlGeneration = XmlGeneration;
				emitter.PrepareEmitFromAssembly( assembly );	
			}

			if( PathName == null )
			{
				Path = Environment.CurrentDirectory;
				EmitFromAssembly( assembly, Path, Imported, IsDependency );
			}
			else
			{
				if( PathName.Length == 0 )
				{
					Path = Environment.CurrentDirectory;
					EmitFromAssembly( assembly, Path, Imported, IsDependency );
				}
				else
					EmitFromAssembly( assembly, PathName, Imported, IsDependency );
			}
		}
	}
 	
	// Generate Eiffel code an Xml files for `assembly'.
	virtual protected void EmitFromAssembly( Assembly assembly, String PathName, bool IsImported, bool IsDependency )
	{	
		if( !IsImported )
		{
			if( NameFormatter.XmlGeneration )
				EmitXmlAndEiffelFiles( assembly, PathName );
			else
				EmitEiffelClasses( assembly, PathName );
		}
		else
		{
			if( !IsDependency )
				if( ( NameFormatter.XmlGeneration )&& !( assembly.GetName().Name.Equals( MscorlibAssemblyName ) ) )
					EmitEiffelClassesFromXml( assembly, null );
		}
	}		

	// Has `assembly' already been imported to the Eiffel assembly cache?
	virtual public bool IsAssemblyImported( Assembly assembly )
	{
		AssemblyName assemblyName;
		CONVERSION_SUPPORT convert;
		ASSEMBLY_DESCRIPTOR assemblyDescriptor;
		REFLECTION_INTERFACE reflectionInterface;
		
		assemblyName = assembly.GetName();
		convert = new Implementation.CONVERSION_SUPPORT();
		assemblyDescriptor = convert.assembly_descriptor_from_name( assemblyName );
		reflectionInterface = new Implementation.REFLECTION_INTERFACE();
		reflectionInterface.make_reflection_interface();
		reflectionInterface.search( assemblyDescriptor );
		if( reflectionInterface.found() )
			EiffelAssemblyFound = reflectionInterface.search_result();
		else
			EiffelAssemblyFound = null;
		return( reflectionInterface.found() );		
	}
	
	// Is path to Eiffel sources of assembly `EiffelAssemblyFound' valid?
	virtual protected bool IsEiffelPathValid()
	{
		if( EiffelAssemblyFound == null )
			return false;
		else
		{
			if( EiffelAssemblyFound.eiffel_cluster_path() == null )
				return false;
			else
				return( Directory.Exists( EmitterSupport.FromReflectionString (EiffelAssemblyFound.eiffel_cluster_path()) ) );
		}
	}
	
	// Generate Xml files for assemblies in `Dependancies' and set `EiffelClusterPath' of EiffelAssembly generated with `PathName'.
	// PathName: Path to folder where Eiffel code will be generated.
	virtual protected void EmitXmlFiles( Assembly assembly, String PathName )
	{	
		Module [] Modules;
		Type [] types;
		int  i, j, typesLength;
		EIFFEL_CLASS GeneratedEiffelClass;
		EIFFEL_ASSEMBLY AssemblyFactory = null;
		XML_CODE_GENERATOR XmlGenerator = null;
		EiffelClassFactory ClassFactory;
		bool EiffelAssemblyGenerated = false;
		ASSEMBLY_DESCRIPTOR Descriptor = null;
		
		XmlGenerator = new Implementation.XML_CODE_GENERATOR();
		XmlGenerator.make_xml_code_generator();
		Descriptor = new Implementation.ASSEMBLY_DESCRIPTOR();
	
		Modules = assembly.GetModules();
		EiffelAssemblyGenerated = false;

		for( i = 0; i < Modules.Length; i++ )
		{
			types = Modules [i].GetTypes();
			typesLength = types.Length;

			for( j = 0; j < typesLength; j++ )
			{				
				if( ClassIDTable [types [j]] != null )
				{	
					if( !EiffelAssemblyGenerated )
					{
						AssemblyFactory = GeneratedAssemblyFactory( types [j], EiffelPath( assembly, PathName ) );
						Descriptor = AssemblyFactory.assembly_descriptor();
						XmlGenerator.start_assembly_generation( AssemblyFactory );
						EiffelAssemblyGenerated = true;
					}
					ClassFactory = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]];
					GeneratedEiffelClass = GeneratedClass( ClassFactory );
					GeneratedEiffelClass.set_assembly_descriptor( Descriptor );
					XmlGenerator.generate_type( GeneratedEiffelClass );	
				}						
			}
		}
		if( EiffelAssemblyGenerated )
			XmlGenerator.end_assembly_generation();
	}
	
	// Generate Eiffel code in `Pathname' corresponding to assemblies in `Dependancies'.
	// Pathname: Path to folder where Eiffel code should be generated	
	virtual protected void EmitEiffelClasses( Assembly assembly, String PathName )
	{	
		Module [] Modules;
		Type [] types;
		int  i, j, typesLength;
		EIFFEL_CLASS GeneratedEiffelClass;
		EIFFEL_ASSEMBLY AssemblyFactory = null;
		EIFFEL_ASSEMBLY GeneratedAssembly = null;
		EIFFEL_CODE_GENERATOR EiffelGenerator = null;
		EiffelClassFactory ClassFactory;
		bool EiffelAssemblyGenerated = false;
		ASSEMBLY_DESCRIPTOR Descriptor = null;
		
		EiffelGenerator = new Implementation.EIFFEL_CODE_GENERATOR();
		Descriptor = new Implementation.ASSEMBLY_DESCRIPTOR();

		Modules = assembly.GetModules();
		EiffelAssemblyGenerated = false;
		for( i = 0; i < Modules.Length; i++ )
		{
			types = Modules [i].GetTypes();
			typesLength = types.Length;

			for( j = 0; j < typesLength; j++ )
			{				
				if( ClassIDTable [types [j]] != null )
				{	
					if( !EiffelAssemblyGenerated )
					{
						AssemblyFactory = GeneratedAssemblyFactory( types [j], EiffelPath( assembly, PathName ) );
						Descriptor = AssemblyFactory.assembly_descriptor();
						GeneratedAssembly = new Implementation.EIFFEL_ASSEMBLY();
						GeneratedAssembly.make( Descriptor, AssemblyFactory.eiffel_cluster_path(), AssemblyFactory.emitter_version_number() );
						EiffelGenerator.make_from_info( GeneratedAssembly );
						EiffelAssemblyGenerated = true;
					}
					ClassFactory = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]];
					GeneratedEiffelClass = GeneratedClass( ClassFactory );	
					GeneratedEiffelClass.set_assembly_descriptor( Descriptor );
					EiffelGenerator.generate_eiffel_class( GeneratedEiffelClass );
				}
			}
		}
	}

	// Generate Xml and Eiffel files for assemblies in `Dependancies' and set `EiffelClusterPath' of EiffelAssembly generated with `PathName'.
	// PathName: Path to folder where Eiffel code will be generated.
	virtual protected void EmitXmlAndEiffelFiles( Assembly assembly, String PathName )
	{	
		Module [] Modules;
		Type [] types;
		int  i, j, typesLength;
		EIFFEL_CLASS GeneratedEiffelClass;
		EIFFEL_ASSEMBLY AssemblyFactory = null;
		XML_CODE_GENERATOR XmlGenerator = null;
		EiffelClassFactory ClassFactory;
		bool EiffelAssemblyGenerated = false;
		ASSEMBLY_DESCRIPTOR Descriptor = null;
		EIFFEL_ASSEMBLY GeneratedAssembly = null;
		EIFFEL_CODE_GENERATOR EiffelGenerator = null;
	
		XmlGenerator = new Implementation.XML_CODE_GENERATOR();
		XmlGenerator.make_xml_code_generator();
		EiffelGenerator = new Implementation.EIFFEL_CODE_GENERATOR();
		Descriptor = new Implementation.ASSEMBLY_DESCRIPTOR();
	
		Modules = assembly.GetModules();
		EiffelAssemblyGenerated = false;
		for( i = 0; i < Modules.Length; i++ )
		{
			types = Modules [i].GetTypes();
			typesLength = types.Length;

			for( j = 0; j < typesLength; j++ )
			{				
				if( ClassIDTable [types [j]] != null )
				{	
					if( !EiffelAssemblyGenerated )
					{
						AssemblyFactory = GeneratedAssemblyFactory( types [j], EiffelPath( assembly, PathName ) );
						Descriptor = AssemblyFactory.assembly_descriptor();
						XmlGenerator.start_assembly_generation( AssemblyFactory );
						GeneratedAssembly = new Implementation.EIFFEL_ASSEMBLY();
						GeneratedAssembly.make( Descriptor, AssemblyFactory.eiffel_cluster_path(), AssemblyFactory.emitter_version_number() );
						EiffelGenerator.make_from_info( GeneratedAssembly );
						EiffelAssemblyGenerated = true;
					}
					ClassFactory = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [types [j]]];
					GeneratedEiffelClass = GeneratedClass( ClassFactory );
					GeneratedEiffelClass.set_assembly_descriptor( Descriptor );
					XmlGenerator.generate_type( GeneratedEiffelClass );
					EiffelGenerator.generate_eiffel_class( GeneratedEiffelClass );
				}						
			}
		}
		if( EiffelAssemblyGenerated )
			XmlGenerator.end_assembly_generation();
	}
	
	// `EiffelPath' from `assembly' and `PathName'.
	virtual protected String EiffelPath( Assembly assembly, String PathName )
	{
		String Path, aPath, FolderPath;
		REFLECTION_SUPPORT reflectionSupport;
		CONVERSION_SUPPORT conversionSupport;
		ASSEMBLY_DESCRIPTOR aDescriptor;
		
		reflectionSupport = new Implementation.REFLECTION_SUPPORT();
		reflectionSupport.make();
		conversionSupport = new Implementation.CONVERSION_SUPPORT();

		if( PathName.EndsWith( "\\" ) )
			Path = String.Concat( PathName, assembly.GetName().Name.Replace (".", "\\") ).ToLower();
			
		else
			Path = String.Concat( PathName, "\\", assembly.GetName().Name.Replace (".", "\\") ).ToLower();
		if( !Directory.Exists( Path ) )
		{
			if( Path.IndexOf( String.Concat( EmitterSupport.FromReflectionString (reflectionSupport.eiffel_delivery_path()).ToLower(), "\\", DotnetLibraryFolderName ) ) > -1 )
				Path = Path.Replace( EmitterSupport.FromReflectionString (reflectionSupport.eiffel_delivery_path()).ToLower(), EmitterSupport.FromReflectionString(reflectionSupport.eiffel_key()) );
			return( Path );
		}
		else
		{
			aDescriptor = conversionSupport.assembly_descriptor_from_name( assembly.GetName() );
			FolderPath = EmitterSupport.FromReflectionString (reflectionSupport.assembly_folder_path_from_info( aDescriptor ));
			FolderPath = FolderPath.Replace( EmitterSupport.FromReflectionString (reflectionSupport.assemblies_folder_path()), "" );
			if( PathName.EndsWith( "\\" ) || FolderPath.StartsWith( "\\" ) )
				aPath = String.Concat( PathName, FolderPath ).ToLower();
			else
				aPath = String.Concat( PathName, "\\", FolderPath ).ToLower();
			if( aPath.IndexOf( String.Concat( EmitterSupport.FromReflectionString (reflectionSupport.eiffel_delivery_path()).ToLower(), "\\", DotnetLibraryFolderName ) ) > -1 )
				aPath = aPath.Replace( EmitterSupport.FromReflectionString (reflectionSupport.eiffel_delivery_path()).ToLower(), EmitterSupport.FromReflectionString (reflectionSupport.eiffel_key()) );
			return( aPath );
		}
	}
	
	// Generate Eiffel code from XML files corresponding to assemblies in `ImportedAssemblies'.
	// Pathname: Path to folder where Eiffel code should be generated	
	virtual protected void EmitEiffelClassesFromXml( Assembly assembly, String PathName )
	{			
		REFLECTION_SUPPORT support;
		CONVERSION_SUPPORT convert;
		AssemblyName AName;
		ASSEMBLY_DESCRIPTOR Descriptor;
		String AssemblyFilename;
		CODE_GENERATION_SUPPORT generationSupport;
		EIFFEL_ASSEMBLY_IMP EAssembly;
		String EiffelClusterPath;
		EIFFEL_CODE_GENERATOR_FROM_XML generator;
		ArrayList AssemblyTypes;
		int i;
		EIFFEL_CLASS AType;
		String TypeFilename;

		support = new Implementation.REFLECTION_SUPPORT();
		support.make();
		convert = new Implementation.CONVERSION_SUPPORT();
		AName = assembly.GetName();
		Descriptor = convert.assembly_descriptor_from_name( AName );
		AssemblyFilename = EmitterSupport.FromReflectionString (support.xml_assembly_filename( Descriptor ));
		if( AssemblyFilename != null )
		{
			AssemblyFilename = AssemblyFilename.Replace( EmitterSupport.FromReflectionString (support.eiffel_key()), EmitterSupport.FromReflectionString( support.eiffel_delivery_path()) );
			if( AssemblyFilename.Length > 0 )
			{
				generationSupport = new Implementation.CODE_GENERATION_SUPPORT();
				generationSupport.make();
				EAssembly = new Implementation.EIFFEL_ASSEMBLY_IMP();
				EAssembly.make_from_interface (generationSupport.eiffel_assembly_from_xml( EmitterSupport.ToReflectionString ( AssemblyFilename )));
				EiffelClusterPath = EAssembly.eiffel_cluster_path();

				generator = new Implementation.EIFFEL_CODE_GENERATOR_FROM_XML();
				if( EAssembly != null )
				{
					AssemblyTypes = EAssembly.types();
					if( PathName == null )
					{
						generator.make_from_info( EmitterSupport.ToReflectionString (AssemblyFilename) );
						for( i = 0; i < AssemblyTypes.Count; i ++ )
						{
							AType = ( EIFFEL_CLASS )AssemblyTypes [i];
							if( AType != null )
							{
								TypeFilename = EmitterSupport.FromReflectionString (support.xml_type_filename( Descriptor, AType.full_external_name() ));
								TypeFilename = TypeFilename.Replace( EmitterSupport.FromReflectionString (support.eiffel_key()), EmitterSupport.FromReflectionString(support.eiffel_delivery_path()) );
								generator.generate_eiffel_code_from_xml( EmitterSupport.ToReflectionString (TypeFilename) );
							}
						}
					}
					else
					{
						generator.make_from_info_and_path( EmitterSupport.ToReflectionString (AssemblyFilename), EmitterSupport.ToReflectionString (PathName) );
						for( i = 0; i < AssemblyTypes.Count; i ++ )
						{
							AType = ( EIFFEL_CLASS )AssemblyTypes [i];
							if( AType != null )
							{
								TypeFilename = EmitterSupport.FromReflectionString (support.xml_type_filename( Descriptor, AType.full_external_name() ));
								generator.generate_eiffel_code_from_xml_and_path( EmitterSupport.ToReflectionString (TypeFilename), EmitterSupport.ToReflectionString (PathName) );
							}
						}
					}
				}
			}
		}
	}



/*
 * Generation of `EiffelClass' and `EiffelAssembly' from `ClassFactory'
 */
 
	// Generate instance of `EiffelClass' from `ClassFactory'.
	virtual protected EIFFEL_CLASS GeneratedClass( EiffelClassFactory ClassFactory )
	{
		EIFFEL_CLASS GeneratedEiffelClass;
		String Parent;
		RENAME_CLAUSE Rename;
		UNDEFINE_CLAUSE Undefine;
		REDEFINE_CLAUSE Redefine;
		SELECT_CLAUSE Select;
		System.Collections.ArrayList NewRenameClauses, NewUndefineClauses, NewRedefineClauses, NewSelectClauses;
		int i, j, ClauseAdded;
		PARENT_IMP ClassParent;
				
		GeneratedEiffelClass = new Implementation.EIFFEL_CLASS();
		GeneratedEiffelClass.make();
		GeneratedEiffelClass.set_frozen( ClassFactory.IsSealed );
		GeneratedEiffelClass.set_expanded( ClassFactory.IsExpanded );
		GeneratedEiffelClass.set_deferred( ClassFactory.IsDeferred );
		GeneratedEiffelClass.set_eiffel_name( EmitterSupport.ToReflectionString (ClassFactory.Name) );
		GeneratedEiffelClass.set_external_names( EmitterSupport.ToReflectionString (ClassFactory.TypeName) );
		if( ClassFactory.UnderlyingType.IsEnum )
		{
			GeneratedEiffelClass.set_enum_type( EmitterSupport.ToReflectionString (NameFormatter.FormatArgumentTypeName( Enum.GetUnderlyingType( ClassFactory.UnderlyingType) )) );
				// Remove non-needed feature for enum types 
			ClassFactory.AccessFeatures.Remove( EiffelClassFactory.EnumValueName );	
		}
			// Add parents
		if( ClassFactory.Parents.Count > 1 || ClassFactory.Renames.HasClause( "ANY" ) || ClassFactory.Redefines.HasClause( "ANY" ) || ClassFactory.Undefines.HasClause( "ANY") || (( ClassFactory.Parents.Count == 1 )&&( !(( EiffelClassFactory )ClassTable [ClassFactory.Parents [0]]).Name.Equals( "ANY" ))))
		{
			for( i = 0; i < ClassFactory.Parents.Count; i++ )
			{
				Parent = (( EiffelClassFactory )ClassTable [ClassFactory.Parents [ i ]]).Name;

				if( ClassFactory.Renames.HasClause( Parent ))
				{
					NewRenameClauses = new System.Collections.ArrayList();
					for( j = 0; j < ClassFactory.Renames.Count( Parent ); j++ )
					{
						Rename = new Implementation.RENAME_CLAUSE();
						Rename.set_source_name( EmitterSupport.ToReflectionString (ClassFactory.Renames.RenameClauseSource( Parent, j )) );
						Rename.set_target_name( EmitterSupport.ToReflectionString (ClassFactory.Renames.RenameClauseTarget( Parent, j )) );
						ClauseAdded = NewRenameClauses.Add( Rename );						
						if( ClauseAdded != ( NewRenameClauses.Count - 1 ) )
							throw new ApplicationException( "rename clause not added" );
					}
					if( NewRenameClauses.Count != ClassFactory.Renames.Count( Parent ) ) 
						throw new ApplicationException("invalid rename clauses");
				}
				else
					NewRenameClauses = new System.Collections.ArrayList();

				if( ClassFactory.Undefines.HasClause( Parent ))
				{
					NewUndefineClauses = new System.Collections.ArrayList();
					for( j = 0; j < ClassFactory.Undefines.Count( Parent ); j++ )
					{
						Undefine = new Implementation.UNDEFINE_CLAUSE();
						Undefine.set_source_name( EmitterSupport.ToReflectionString (ClassFactory.Undefines.UndefineFeature( Parent, j )) );
						ClauseAdded = NewUndefineClauses.Add( Undefine );
						if( ClauseAdded != ( NewUndefineClauses.Count - 1 ) )
							throw new ApplicationException( "undefine clause not added" );
					}
					if( NewUndefineClauses.Count != ClassFactory.Undefines.Count( Parent ) ) 
						throw new ApplicationException("invalid rename clauses");
				}
				else
					NewUndefineClauses = new System.Collections.ArrayList();

				if( ClassFactory.Redefines.HasClause( Parent ))
				{
					NewRedefineClauses = new System.Collections.ArrayList();
					for( j = 0; j < ClassFactory.Redefines.Count( Parent ); j++ )
					{
						Redefine = new Implementation.REDEFINE_CLAUSE();
						Redefine.set_source_name( EmitterSupport.ToReflectionString (ClassFactory.Redefines.RedefineFeature( Parent, j )) );
						ClauseAdded = NewRedefineClauses.Add( Redefine );
						if( ClauseAdded != ( NewRedefineClauses.Count - 1 ) )
							throw new ApplicationException( "redefine clause not added" );
					}
					if( NewRedefineClauses.Count != ClassFactory.Redefines.Count( Parent ) ) 
						throw new ApplicationException("invalid rename clauses");
				}
				else
					NewRedefineClauses = new System.Collections.ArrayList();

				if( ClassFactory.Selects.HasClause( Parent ))
				{
					NewSelectClauses = new System.Collections.ArrayList();
					for( j = 0; j < ClassFactory.Selects.Count( Parent ); j++ )
					{
						Select = new Implementation.SELECT_CLAUSE();
						Select.set_source_name( EmitterSupport.ToReflectionString (ClassFactory.Selects.SelectFeature( Parent, j )) );
						ClauseAdded = NewSelectClauses.Add( Select );
						if( ClauseAdded != ( NewSelectClauses.Count - 1 ) )
							throw new ApplicationException( "select clause not added" );
					}
					if( NewSelectClauses.Count != ClassFactory.Selects.Count( Parent ) ) 
						throw new ApplicationException("invalid select clauses");
				}
				else
					NewSelectClauses = new System.Collections.ArrayList();

				if( !Parent.Equals( "ANY" ) || ClassFactory.Renames.HasClause( "ANY" ) || ClassFactory.Redefines.HasClause( "ANY" ) || ClassFactory.Undefines.HasClause( "ANY"))
				{
					ClassParent = new Implementation.PARENT_IMP();
					ClassParent.make(Parent);
					ClassParent.set_rename_clauses( NewRenameClauses );
					ClassParent.set_undefine_clauses( NewUndefineClauses );
					ClassParent.set_redefine_clauses( NewRedefineClauses );
					ClassParent.set_select_clauses( NewSelectClauses );
					ClassParent.set_export_clauses( new System.Collections.ArrayList() );
					GeneratedEiffelClass.add_parent( ClassParent.class_interface() );
				}
			}
		}

		
			// Do not generate creation clause for deferred classes or expanded classes.
		if(( ClassFactory.CreationRoutines.Count > 0 )&&( !ClassFactory.IsDeferred )&&( !EiffelClassFactory.SpecialClasses.ContainsKey( ClassFactory.Name ) ) )
		{
			/*if (!ClassFactory.IsExpanded) 
			{
				foreach( String CreationRoutine in ClassFactory.CreationRoutines.Keys )
					GeneratedEiffelClass.AddCreationRoutine( CreationRoutine );				
			}*/
			foreach( String CreationRoutine in ClassFactory.CreationRoutines.Keys )
				GeneratedEiffelClass.add_initialization_feature( GeneratedFeature( ClassFactory, CreationRoutine, ClassFactory.CreationRoutines ) );
			
			GeneratedEiffelClass.set_create_none( false );
		}
		else
		{		
			if(( ClassFactory.CreationRoutines.Count == 0 )&&( !ClassFactory.IsDeferred ))
				GeneratedEiffelClass.set_create_none( true );
			else
				GeneratedEiffelClass.set_create_none( false );
		}
				
			// Set class features
		if( ClassFactory.AccessFeatures.Count > 0 )
		{
			foreach( String AccessFeature in ClassFactory.AccessFeatures.Keys )
				GeneratedEiffelClass.add_access_feature( GeneratedFeature( ClassFactory, AccessFeature, ClassFactory.AccessFeatures ) );
		}

		if( ClassFactory.ElementChangeFeatures.Count > 0 )
		{
			foreach( String ElementChangeFeature in ClassFactory.ElementChangeFeatures.Keys )
					GeneratedEiffelClass.add_element_change_feature( GeneratedFeature( ClassFactory, ElementChangeFeature, ClassFactory.ElementChangeFeatures ) );
		}

		if( ClassFactory.BasicOperations.Count > 0 )
		{
			foreach( String BasicOperation in ClassFactory.BasicOperations.Keys )
				GeneratedEiffelClass.add_basic_operation( GeneratedFeature( ClassFactory, BasicOperation, ClassFactory.BasicOperations ) );
		}
		else
		{
			GeneratedEiffelClass.set_bit_or_infix
			( 
				( ClassFactory.UnderlyingType.IsEnum )&&
				( ClassFactory.UnderlyingType.GetCustomAttributes( typeof( FlagsAttribute ), false ).Length > 0 )
			);			
		}

		if( ClassFactory.UnaryOperatorsFeatures.Count > 0 )
		{
			foreach( String UnaryOperatorsFeature in ClassFactory.UnaryOperatorsFeatures.Keys )
				GeneratedEiffelClass.add_unary_operator( GeneratedFeature( ClassFactory, UnaryOperatorsFeature, ClassFactory.UnaryOperatorsFeatures ) );
		}

		if( ClassFactory.BinaryOperatorsFeatures.Count > 0 )
		{
			foreach( String BinaryOperatorsFeature in ClassFactory.BinaryOperatorsFeatures.Keys )
				GeneratedEiffelClass.add_binary_operator( GeneratedFeature( ClassFactory, BinaryOperatorsFeature, ClassFactory.BinaryOperatorsFeatures ) );
		}

		if( ClassFactory.SpecialFeatures.Count > 0 )
		{
			foreach( String SpecialFeature in ClassFactory.SpecialFeatures.Keys )
				GeneratedEiffelClass.add_special_feature( GeneratedFeature( ClassFactory, SpecialFeature, ClassFactory.SpecialFeatures ) );
		}

		if( ClassFactory.ImplementationFeatures.Count > 0 )
		{
			foreach( String ImplementationFeature in ClassFactory.ImplementationFeatures.Keys )
				GeneratedEiffelClass.add_implementation_feature( GeneratedFeature( ClassFactory, ImplementationFeature, ClassFactory.ImplementationFeatures ) );
		}
		
			// Should set class invariant if any.	
		
		return GeneratedEiffelClass;
	}	
	
	// Generate instance of EiffelFeature corresponding to `FeatureName' in table `FeatureTable'.
	virtual protected EIFFEL_FEATURE GeneratedFeature( EiffelClassFactory ClassFactory, String FeatureName, System.Collections.Hashtable FeatureTable )
	{
		EIFFEL_FEATURE GeneratedEiffelFeature;
		EiffelMethodFactory MethodFactory;
		EiffelCreationRoutine CreationRoutine;
		String ArgumentType, ArgumentTypeFullName;
		String returnName;
		SIGNATURE_TYPE ReturnType;
		String ArgumentName, ArgumentExternalName;
		NAMED_SIGNATURE_TYPE Argument;
		Type returnType;
		ConstructorInfo ConstructorDescriptor = null;
		MethodInfo MethodDescriptor = null;
		FieldInfo FieldDescriptor  = null;
		ParameterInfo[] Arguments = new ParameterInfo[] {};
		Boolean IsField, IsMethod, IsCreationRoutine;
		bool IsUnaryOperator = false;
		bool IsBinaryOperator = false;
		bool IsEnumLiteral = false;
		bool IsLiteral = false;
		String PrefixName, Prefix, InfixName, Infix;
		int PrefixIndex, InfixIndex;
		int i;

		GeneratedEiffelFeature = new Implementation.EIFFEL_FEATURE();
		GeneratedEiffelFeature.make();
		
		IsMethod = typeof( EiffelMethodFactory ).IsInstanceOfType( FeatureTable [FeatureName]);
		GeneratedEiffelFeature.set_method( IsMethod );
		
		if( IsMethod )
		{
			IsBinaryOperator = BinaryOperators().ContainsKey((( EiffelMethodFactory )FeatureTable [FeatureName]).Info.Name );
			IsUnaryOperator = UnaryOperators().ContainsKey((( EiffelMethodFactory )FeatureTable [FeatureName]).Info.Name );
			MethodFactory = ( EiffelMethodFactory )FeatureTable [FeatureName];
			GeneratedEiffelFeature.set_new_slot( MethodFactory.NewSlot );
			
			MethodDescriptor =( MethodInfo )(MethodFactory.Info);
			GeneratedEiffelFeature.set_static( MethodDescriptor.IsStatic );
			GeneratedEiffelFeature.set_abstract( MethodDescriptor.IsAbstract );
			Arguments = MethodDescriptor.GetParameters();
		}
		IsField = FieldInfoType.IsInstanceOfType( FeatureTable [FeatureName]);
		GeneratedEiffelFeature.set_field( IsField );
		if( IsField )
		{
			FieldDescriptor =(( FieldInfo )FeatureTable [FeatureName]);
			IsLiteral = FieldDescriptor.IsLiteral;
			GeneratedEiffelFeature.set_literal( IsLiteral );

			IsEnumLiteral = IsLiteral  && ClassFactory.UnderlyingType.IsEnum;
			GeneratedEiffelFeature.set_enum_literal( IsEnumLiteral );
			GeneratedEiffelFeature.set_new_slot( FieldDescriptor.DeclaringType.AssemblyQualifiedName.ToLower().Equals( ClassFactory.UnderlyingType.AssemblyQualifiedName.ToLower() ) );
			GeneratedEiffelFeature.set_static( FieldDescriptor.IsStatic );
			
			//ReturnType = new SignatureType();
			//ReturnType.SetTypeFullExternalName( NameFormatter.FormatStrongName( FieldDescriptor.FieldType.FullName ) );
			//GeneratedEiffelFeature.SetReturnType( ReturnType );
		}
		if( !IsMethod && !IsField )
		{
			GeneratedEiffelFeature.set_creation_routine( true );
			CreationRoutine = (( EiffelCreationRoutine )FeatureTable [FeatureName]);
			ConstructorDescriptor = ( ConstructorInfo )CreationRoutine.Info;
			Arguments = ConstructorDescriptor.GetParameters();
			if( Arguments == null )
				throw new ApplicationException( "Not a valid name for a routine: " + FeatureName + " in type " + ClassFactory.Name );
		}

		if(
			( IsMethod &&( MethodDescriptor.IsFinal || !MethodDescriptor.IsVirtual || MethodDescriptor.IsStatic )) ||
			( IsField ) || 
			( !IsMethod && !IsField )
        	)
				// Frozen Eiffel features correspond to:
				// 1 - a feature which is final or not virtual
				// 2 - a static feature
				// 3 - an attribute
				// 4 - a constructor
			GeneratedEiffelFeature.set_frozen( true );
		else
			GeneratedEiffelFeature.set_frozen( false );

		if( IsUnaryOperator && (( EiffelMethodFactory )FeatureTable [FeatureName]).Name() == MethodDescriptor.Name )
		{
			PrefixName = ( ( String )UnaryOperators() [MethodDescriptor.Name] ).Trim();
			Prefix = "prefix";
			PrefixIndex = PrefixName.IndexOf( Prefix );
			if( PrefixIndex > -1 )
			{
				GeneratedEiffelFeature.set_prefix( true );
				PrefixName = PrefixName.Substring( PrefixIndex + Prefix.Length );
				GeneratedEiffelFeature.set_eiffel_name( EmitterSupport.ToReflectionString (PrefixName) );
			}
			else
				throw new ApplicationException( "invalid prefix name" );
		}
		else
		{
			if( IsBinaryOperator && (( EiffelMethodFactory )FeatureTable [FeatureName]).Name() == MethodDescriptor.Name )
			{
				InfixName = ( ( String )BinaryOperators() [MethodDescriptor.Name] ).Trim();
				Infix = "infix";
				InfixIndex = InfixName.IndexOf( Infix );
				if( InfixIndex > -1 )
				{
					GeneratedEiffelFeature.set_infix( true );
					InfixName = InfixName.Substring( InfixIndex + Infix.Length );
					GeneratedEiffelFeature.set_eiffel_name( EmitterSupport.ToReflectionString (InfixName) );
				}				
			}
			else
				GeneratedEiffelFeature.set_eiffel_name( EmitterSupport.ToReflectionString (FeatureName) );	
		}

		if( !IsUnaryOperator &&( Arguments.Length > 0 ))
		{
			for( i = 0; i < Arguments.Length; i++ )
			{
				if( IsBinaryOperator )
					i = 1;
				
				ArgumentType = NameFormatter.FormatArgumentTypeName( Arguments[i].ParameterType );
				ArgumentTypeFullName = NameFormatter.FormatStrongName( Arguments [i].ParameterType.FullName );
				if( IsMethod )
				{
					MethodFactory = ( EiffelMethodFactory )FeatureTable [FeatureName];
					ArgumentName = ( String )( MethodFactory.ArgumentsNames [i] );
					ArgumentExternalName = Arguments [i].Name;
				}
				else
				{
				 	ArgumentName = "";
				 	ArgumentExternalName = "";
					if( !IsField && !IsMethod)
					{
						IsCreationRoutine = typeof( EiffelCreationRoutine ).IsInstanceOfType( FeatureTable [FeatureName] );
						GeneratedEiffelFeature.set_creation_routine( IsCreationRoutine );
						if( IsCreationRoutine )
						{
							CreationRoutine = ( EiffelCreationRoutine )FeatureTable [FeatureName];
							ArgumentName = ( String )( CreationRoutine.ArgumentsNames [i] );
							ArgumentExternalName = Arguments [i].Name;
						}
						else
						{
							ArgumentName = "";
							throw new ApplicationException( "Not a valid feature (neither a method, nor a field nor a creation routine): " + FeatureName + " in type " + ClassFactory.Name );
						}
					}
				
				}
					
				Argument = new Implementation.NAMED_SIGNATURE_TYPE();
				Argument.set_eiffel_name( EmitterSupport.ToReflectionString (ArgumentName) );
				Argument.set_external_name( EmitterSupport.ToReflectionString (ArgumentExternalName) );
				Argument.set_type_eiffel_name( EmitterSupport.ToReflectionString (ArgumentType) );
				Argument.set_type_full_external_name( EmitterSupport.ToReflectionString (ArgumentTypeFullName) );
				GeneratedEiffelFeature.add_argument( Argument );
			}
		}
		else
		{
			if( IsUnaryOperator &&( Arguments.Length > 0 ) )
			{
				for( i = 0; i < Arguments.Length; i++ )
				{	
					Argument = new Implementation.NAMED_SIGNATURE_TYPE();
					Argument.set_type_full_external_name( EmitterSupport.ToReflectionString (NameFormatter.FormatStrongName( Arguments [i].ParameterType.FullName )) );
					GeneratedEiffelFeature.add_argument( Argument );
				}
			}			
		}

		if( IsMethod )
		{
			returnType =( Type )MethodDescriptor.ReturnType;
			if( !returnType.Name.ToLower().Equals( "void" ))
			{
				returnName = NameFormatter.FormatArgumentTypeName( returnType );
				ReturnType = new Implementation.SIGNATURE_TYPE();
				ReturnType.set_type_eiffel_name( EmitterSupport.ToReflectionString (returnName) );
				ReturnType.set_type_full_external_name( EmitterSupport.ToReflectionString (NameFormatter.FormatStrongName( returnType.FullName )) ); 
				GeneratedEiffelFeature.set_return_type( ReturnType );
			}
			else
			{
				ReturnType = new Implementation.SIGNATURE_TYPE();
				ReturnType.set_type_full_external_name( EmitterSupport.ToReflectionString ("System.Void") );
				GeneratedEiffelFeature.set_return_type( ReturnType );
			}
		}

		if( IsField&& !FieldDescriptor.Name.StartsWith( EiffelClassFactory.PropertySetPrefix ))
		{
			ReturnType = new Implementation.SIGNATURE_TYPE();
			ReturnType.set_type_eiffel_name( EmitterSupport.ToReflectionString (NameFormatter.FormatArgumentTypeName( FieldDescriptor.FieldType )) );
			ReturnType.set_type_full_external_name( EmitterSupport.ToReflectionString (NameFormatter.FormatStrongName( FieldDescriptor.FieldType.FullName )) );
			GeneratedEiffelFeature.set_return_type( ReturnType ); 
		}

		if( IsMethod || IsField )
		{
			if( IsMethod )
				GeneratedEiffelFeature.set_external_name( EmitterSupport.ToReflectionString (MethodDescriptor.Name) );
			else
			{
				if( IsEnumLiteral ) 
					GeneratedEiffelFeature.set_external_name( EmitterSupport.ToReflectionString (System.Convert.ToInt32( FieldDescriptor.GetValue( ClassFactory.UnderlyingType ) ).ToString()) );
				else
					GeneratedEiffelFeature.set_external_name( EmitterSupport.ToReflectionString (FieldDescriptor.Name) );
			}
		}

		if( IsField )
		{
			if( FieldDescriptor.IsStatic )
			{
				if( !IsEnumLiteral && IsLiteral ) 
				{
					Object value;
						/* We cannot just simply print out the value
						 * of the literal constants for System.Double
						 * and System.Single because of the Infinity(s)
						 * and NaN(s) values which do not express themselves
						 * as constants. Instead we don't generate them
						 *
						 * For character constants, we have to generate
						 * an escape sequence, but we cannot print the
						 * `MaxValue' and `MinValue' constants.
						 */
					value = FieldDescriptor.GetValue( ClassFactory.UnderlyingType );
					if( value is double ) 
					{
						double d = ( double )value;
						if( double.IsInfinity (d) || double.IsNaN (d) )
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString ("") );
						else
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" " + value) );
					} 
					else if( value is float ) 
					{
						float s = ( float )value;
						if( float.IsInfinity (s) || float.IsNaN (s) )
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString ("") );
						else
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" " + value) );
					} 
					else if( value is char ) 
					{
						char c = ( char )value;
						if( ( c == char.MaxValue )||( c == char.MinValue ) )
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString ("") );
						else
							GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" '" + value + "'") );
					} 
					else if( value is int ) 
					{
						int a_i = ( int )value;
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" 0x" + a_i.ToString ("x")) );
					} 
					else if( value is byte ) 
					{
						byte b = ( byte )value;
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" 0x" + b.ToString ("x")) );
					} 
					else if( value is short ) 
					{
						short s = ( short )value;
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" 0x" + s.ToString ("x")) );
					} 
					else if( value is long ) 
					{
						long l = ( long )value;
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" 0x" + l.ToString ("x")) );
					} 
					else if( value is string ) 
					{
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString ("") );
					}
					else
						GeneratedEiffelFeature.set_literal_value( EmitterSupport.ToReflectionString (" " + value) );
				}
			}
		}
							
		return GeneratedEiffelFeature;	
	}

	// Generate EiffelAssembly. 
	// Does not set `EiffelClusterPath'.
	virtual protected EIFFEL_ASSEMBLY GeneratedAssemblyFactory( Type AssemblyType, String EiffelClusterPath )
	{
		EIFFEL_ASSEMBLY AssemblyFactory;
		ASSEMBLY_DESCRIPTOR Descriptor;
		String DotNetStrongName, Version, Culture;
		String assemblyName, assemblyVersion, assemblyCulture, assemblyPublicKey;
		int CommaIndex, EqualsIndex;
		
		DotNetStrongName = AssemblyType.AssemblyQualifiedName.Trim();
		
		// Set `assembly_name'.
		CommaIndex = DotNetStrongName.IndexOf( ',' );
		DotNetStrongName = DotNetStrongName.Substring( CommaIndex + 1 ).Trim();
		CommaIndex = DotNetStrongName.IndexOf( ',' );
		assemblyName = DotNetStrongName.Substring( 0, CommaIndex );
		
		// Set `assembly_version'.
		DotNetStrongName = DotNetStrongName.Substring( CommaIndex + 1 ).Trim();
		CommaIndex = DotNetStrongName.IndexOf( ',' );
		Version = DotNetStrongName.Substring( 0, CommaIndex );
		EqualsIndex = Version.IndexOf( '=' );
		assemblyVersion = Version.Substring( EqualsIndex + 1 );

		// Set `assembly_culture'.
		DotNetStrongName = DotNetStrongName.Substring( CommaIndex + 1 ).Trim();
		CommaIndex = DotNetStrongName.IndexOf( ',' );
		Culture = DotNetStrongName.Substring( 0, CommaIndex );
		EqualsIndex = Culture.IndexOf( '=' );
		assemblyCulture = Culture.Substring( EqualsIndex + 1);

		// Set `assembly_public_key'.
		DotNetStrongName = DotNetStrongName.Substring( CommaIndex + 1 ).Trim();
		EqualsIndex = DotNetStrongName.IndexOf( '=' );
		assemblyPublicKey = DotNetStrongName.Substring( EqualsIndex + 1 );
		
		// Set `assembly_descriptor'.
		Descriptor = new Implementation.ASSEMBLY_DESCRIPTOR();
		Descriptor.make( EmitterSupport.ToReflectionString (assemblyName), EmitterSupport.ToReflectionString (assemblyVersion), EmitterSupport.ToReflectionString (assemblyCulture), EmitterSupport.ToReflectionString (assemblyPublicKey) );

		AssemblyFactory = new Implementation.EIFFEL_ASSEMBLY();
		AssemblyFactory.make( Descriptor, EmitterSupport.ToReflectionString (EiffelClusterPath), EmitterSupport.ToReflectionString (VersionNumber) );
		
		return AssemblyFactory;
	}

	// Load dependencies of `assembly'.
	virtual protected System.Collections.ArrayList LoadExternalAssemblies( Assembly assembly )
	{
		AssemblyName [] assemblyNames;
		Assembly newAssembly;
		System.Collections.ArrayList assemblies;
		int i;

		assemblyNames = assembly.GetReferencedAssemblies();
		assemblies = new System.Collections.ArrayList();
		for( i = 0; i < assemblyNames.Length; i++ )
		{
			if( !Done.Contains( assemblyNames [i].FullName ) && !assemblyNames [i].FullName.Equals( "Microsoft.VisualC, Version=7.0.9249.59748, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a" ) )
			{
				newAssembly = Assembly.Load( assemblyNames [i] );
				Done.Add( assemblyNames [i].FullName );
				assemblies.AddRange( LoadExternalAssemblies( newAssembly ));
				assemblies.Add( newAssembly );
			}
		}
		return assemblies;
	}
	
	// Is `assembly' signed?
	virtual protected bool IsSigned( Assembly assembly )
	{
		AssemblyName AName;
		Array Key;
		
		AName = assembly.GetName();
		Key = AName.GetPublicKey();
		if( Key != null )
			return( Key.Length > 0 );
		else
			return false;		
	}
	
	// Import `assembly' dependencies.
	virtual protected void ImportAssemblyDependencies( Assembly assembly, String PathName, bool EiffelFormatting )
	{
		ArrayList Dependencies;
		Assembly Dependency;
		bool IsSignedAssembly = false;
		int i;
		String assemblyFullName;
		
		assemblyFullName = assembly.FullName.ToLower();
		Done = new ArrayList();
		Dependencies = LoadExternalAssemblies( assembly );
		for( i = 0; i < Dependencies.Count; i ++ )
		{
			Dependency = ( Assembly )Dependencies [i];
			if( Dependency != null )
			{
				if( !Dependency.FullName.ToLower().Equals( assemblyFullName ) )
				{
					IsSignedAssembly = IsSigned( Dependency );
					NameFormatter.XmlGeneration = IsSignedAssembly;
					ImportAssemblyWithoutDependancies( Dependency, PathName, EiffelFormatting, IsSignedAssembly, true );
				}
			}
		}
	}
	
	// Loaded assemblies, used in `LoadExternalAssemblies'
	private static System.Collections.ArrayList Done;
	
	// Eiffel assembly found (result of `IsAssemblyImported')
	protected EIFFEL_ASSEMBLY EiffelAssemblyFound;
	
	// Name of `mscorlib.dll'
	protected static String MscorlibAssemblyName = "mscorlib";
	
	// `library.net' folder name
	protected static String DotnetLibraryFolderName = "library.net";
}
