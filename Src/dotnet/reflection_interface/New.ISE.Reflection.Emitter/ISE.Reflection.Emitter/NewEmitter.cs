/*
 * Emitter generates pseudo Eiffel code from metadata.
 * In 4 passes:
 * Pass 1: Gather all classes, associate an id and build  IDTable
 * Pass 2: Gather information on each class and build ClassInfoTable
 * Pass 3: Resolve overloading problems from ClassInfoTable and build ProcessedTable
 * Pass 4: Generate each entry of ProcessedTable
 *
 */
using System;
using System.Reflection;
using System.Reflection.Emit;
using System.IO;
using System.Diagnostics;
#if CTW
	using ComComponent;
#endif
#if BASIC
#else
	//using ISE.Reflection.EiffelComponents;
	//using ISE.Reflection.CodeGenerator;
	//using ISE.Reflection.Support;
	//using ISE.Reflection.ReflectionInterface;
	//using ISE.Reflection.EiffelAssemblyCacheHandler;
	//using ISE.Reflection.EiffelAssemblyCacheNotifier;
	//using ISE.Reflection
#endif
public class Emitter:Globals
{
	// Initialize instance
	public Emitter()
	{
		ClassInfoTable = new System.Collections.Hashtable();
		MethodImplSource = new System.Collections.Hashtable();
		MethodImpls = new System.Collections.ArrayList();
		IDTable = new System.Collections.Hashtable();
		
		/*Add non generated methods here as follows:
			NonGeneratedMethods.Add( Type.GetType( "System.IO.FileStream" ).GetMethod( "AsyncFSCallback" ));
		*/
	}

	// Generate Eiffel code in `Pathname' corresponding to assembly in `Filename'.
	// Filename: Name of file to be analyzed
	// Pathname: Path where Eiffel code should be generated
	virtual internal void Emit( String FileName, String PathName, String Prefix )
	{
		
		EiffelClassGenerator Generator;
		NameFormatter.SetClassPrefix (Prefix);
		PrepareEmitFromFilename( FileName );
		Generator = new EiffelClassGenerator();
		#if CTW
			Generator.SetComComponent( comComponent );
		#endif
		Generator.Emit( FileName, PathName );
	}

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


	// Prepare code generation in `Pathname' corresponding to assembly in `Filename'.
	// Filename: Name of file to be analyzed
	virtual public void PrepareEmitFromFilename( String FileName )
	{
		AssemblyName assemblyName;
		Assembly assembly;
		
		try
		{
			assemblyName = AssemblyName.GetAssemblyName( FileName );
			assembly = Assembly.LoadFrom( FileName );
			NameFormatter.SetAssembly (assembly);
			PrepareEmitFromAssembly( assembly );
		}
		catch
		{
			throw new ApplicationException( "No Assembly Found in " + FileName );
		}
		
		//if ( assemblyName == null )
			

	}

	// Prepare code generation in `Pathname' corresponding to assembly in `Filename'.
	// Filename: Name of file to be analyzed
	virtual public void PrepareEmitFromAssembly( Assembly assembly )
	{
		Type [] types, ParentInterfaces, Interfaces;
		String Suffix, ClassName;
		String [] IDTableKeys;
		int [] IDTableValues;
		Module [] modules;
		int i, j, k, l, m, max;
		System.Collections.ArrayList Parents;
		System.Collections.ArrayList InterfaceParents;
		Type CurrentType, ParentType;
		MethodInfo [] ParentMethods, CurrentMethods;
		ParameterInfo [] Parameters, OtherParameters;
		MethodInfo ParentMethod = null;
		System.Collections.Hashtable IDTable, ClassInfoTableTemp;
		System.Collections.ArrayList Methods, PolymorphMethods, ParentRoutines;
		Boolean Found;
		EiffelClassFactory NewClass;
		FieldInfo [] fields, ParentFields;
		EventInfo [] events;
		ConstructorInfo [] constructors;
		EiffelMethodFactory NewMethod;
		Object [] keys = null ;
		InterfaceMapping CurrentMap;
		#if BASIC
		#else
			REFLECTION_INTERFACE EACInterface = new Implementation.REFLECTION_INTERFACE();
			EACInterface.make_reflection_interface();
		#endif
		#if CTW
			int ModuleCount;
		#endif
		
		ClassIDTable = new System.Collections.Hashtable();		
		ClassTable = new System.Collections.Hashtable();
		PolymorphicIDTable = new System.Collections.Hashtable();
		//NonGeneratedMethods = new System.Collections.ArrayList();
		Done = new System.Collections.ArrayList();
		ClassId = 0;
		
		/********\
		* Pass 1 *
		\********/
		#if CTW
			comComponent = new ComComponentClass();
		#endif

		#if CTW 
			ModuleCount = 0;
			Assemblies = LoadExternalAssemblies( assembly );
			for( i = 0; i < Assemblies.Count; i++ )
				ModuleCount = ModuleCount +(( Assembly )Assemblies [i] ).GetModules().Length;
			if( !Assemblies.Contains( assembly ) )
			{
				Assemblies.Add( assembly );
				ModuleCount = ModuleCount + assembly.GetModules().Length;
			}
			modules = new Module [ModuleCount];
			j = 0;
			for( i = 0; i < Assemblies.Count; i++ )
			{
				(( Assembly )Assemblies [i] ).GetModules().CopyTo( modules, j );
				j += (( Assembly )Assemblies [i] ).GetModules().Length;
			}
        #else
			Assemblies = new System.Collections.ArrayList();
			Assemblies.Add( assembly );
			modules = new Module [assembly.GetModules().Length];
			assembly.GetModules().CopyTo( modules, 0 );
		#endif
		
		IDTable = new System.Collections.Hashtable();
		for( i = 0; i < modules.Length; i++ )
		{
			types = modules [i].GetTypes();
			for( j = 0; j < types.Length; j++ )
			{
				foreach( Type FamilyMember in Family( types [j] ))
				{
					if( IsGeneratedType( FamilyMember )&&( !IDTable.ContainsKey( FamilyMember.FullName )))
					{
						if( !Assemblies.Contains( FamilyMember.Assembly ))
							Assemblies.Add( FamilyMember.Assembly );
						IDTable.Add( FamilyMember.FullName, ClassId );
						ClassId++;
					}
				}
			}
		}
		// Add "System.Object" with ID = 0 if not in IDTable yet
		// Replace string at ID = 0 with "System.Object" otherwise
		
		IDTableKeys = new String [IDTable.Keys.Count];
		IDTable.Keys.CopyTo( IDTableKeys, 0 );
		IDTableValues = new int [IDTable.Values.Count];
		IDTable.Values.CopyTo( IDTableValues, 0 );
		if( !IDTable.ContainsKey( "System.Object" ))
		{
			ClassName =( String )IDTableKeys [Array.IndexOf( IDTableValues, 0 )];
			IDTable.Remove( ClassName );
			IDTable.Add( ClassName, ClassId );
			IDTable.Add( "System.Object", 0 );
			ClassId++;
		}
		else
		{
			if(( int )IDTable ["System.Object"]  != 0 )
			{
				i =( int )IDTable ["System.Object"] ;
				IDTable.Remove( "System.Object" );
				ClassName =( String )IDTableKeys [Array.IndexOf( IDTableValues, 0 )];
				IDTable.Remove( ClassName );
				IDTable.Add( ClassName, i );
				IDTable.Add( "System.Object", 0 );
			}
		}
				
		ClassCount = ClassId;
		#if CTW
			comComponent.Advance( 10 );
		#endif

		/********\
		* Pass 2 *
		\********/
		ClassInfoTableTemp = new System.Collections.Hashtable();
		for( i = 0; i < modules.Length; i++ )
		{
			types = modules [i].GetTypes();
			for( j = 0; j < types.Length; j++ )
			{
				foreach( Type FamilyMember in Family( types [j] ))
				{
					if( IsGeneratedType( FamilyMember )&&( !ClassInfoTableTemp.ContainsKey(( int )IDTable [FamilyMember.FullName] )))
						ClassInfoTableTemp.Add(( int )IDTable [FamilyMember.FullName], FamilyMember );
				}
			}
		}
		if( !ClassInfoTableTemp.ContainsKey( 0 ))
			ClassInfoTableTemp.Add( 0, ObjectType );
	
		// Topologic sort
		for( i = 0; i < ClassCount; i++ )
		{
			Parents = new System.Collections.ArrayList();
			InterfaceParents = new System.Collections.ArrayList();
			max = -1;
			CurrentType = (( Type )ClassInfoTableTemp [i] );

			if( CurrentType.BaseType != null )
				Parents.Add( CurrentType.BaseType );
			ParentInterfaces = CurrentType.GetInterfaces();
			for( j = 0; j < ParentInterfaces.Length; j++ )
			{
				if( IsGeneratedType( ParentInterfaces [j] )){
				
					// ensure that the classes are generated Implementation first then Interfaces
					if (CurrentType.IsInterface){
						InterfaceParents.Add( ParentInterfaces [j] );
					}else{
						Parents.Add( ParentInterfaces [j] );
					}
				}
			}
			Parents.AddRange (InterfaceParents);
			for( j = 0; j < Parents.Count; j++ )
			{
				if( IDTable.ContainsKey((( Type )( Parents [j] )).FullName ))
				{
					if(( int )IDTable [(( Type )( Parents [j] )).FullName]> max )
						max =( int )IDTable [(( Type )( Parents [j] )).FullName];
				}
			}

			if( max > i )
			{
				ClassInfoTableTemp.Add( ClassCount, ClassInfoTableTemp [i] );
				IDTable [(( Type )ClassInfoTableTemp [i] ).FullName] = ClassCount;
				ClassInfoTableTemp [i] = null;
				ClassCount ++;
			}
		}

		// Clean table
		j = 0;
		for( i = 0; i < ClassCount; i++ )
		{
			if(( ClassInfoTableTemp [i] != null )&&( IsGeneratedType(( Type )ClassInfoTableTemp [i] )))
			{
				ClassInfoTable.Add( j,(( Type )ClassInfoTableTemp [i] ));
				ClassIDTable.Add(( Type )ClassInfoTableTemp [i], j );
				j++;
			}
		}
		ClassInfoTableTemp = null;
		ClassCount = j;
		ObjectID = ( int )ClassIDTable [ObjectType] ;
		
		#if CTW
			comComponent.Advance( 10 );
		#endif

		/********\
		* Pass 3 *
		\********/
		#if CTW
			int advanceCalls = 0;
		#endif
		
		//
		// TEMP HACK - table to hold list of methods, to stop method duplication
		//
		//System.Collections.ArrayList GeneratedMethods;
		
		// For each type to be generated
		for( i = 0; i < ClassCount; i++ )
		{
			//
			// TEMP HACK - table to hold list of methods, to stop method duplication
			//
			//GeneratedMethods = new System.Collections.ArrayList();

			//MethodImpls = new System.Collections.ArrayList();
			CurrentType =( Type )ClassInfoTable [i];
			NewClass = new EiffelClassFactory(( int )ClassIDTable [CurrentType], CurrentType );
			if(( CurrentType.BaseType != null )&& IsGeneratedType( CurrentType.BaseType ))
				NewClass.AddParent(( int )ClassIDTable [CurrentType.BaseType] );
			Interfaces = CurrentType.GetInterfaces();
			for( j = 0; j < Interfaces.Length; j++ )
			{
				if( IsGeneratedType( Interfaces [j] ))
					NewClass.AddParent(( int )ClassIDTable [Interfaces [j]] );
			}
			NewClass.SetDeferred( CurrentType.IsAbstract || CurrentType.IsInterface );
			NewClass.SetExpanded( CurrentType.IsValueType && !NewClass.IsDeferred );
			NewClass.SetSealed( CurrentType.IsSealed );

			fields = CurrentType.GetFields();

			for( j = 0; j < fields.Length; j++ )
			{
				if( IsGeneratedField(( FieldInfo )fields [j] ))
					NewClass.AddAttribute( fields [j] );
			}

			// Must add parent type before interfaces because interfaces
			// include non-direct interfaces ( also include parent types
			// interfaces ). We want to redefine/rename functions from
			// parent type not from parent type interfaces.
			Methods = new System.Collections.ArrayList();
			Methods.AddRange( CurrentType.GetMethods(
					BindingFlags.Instance |
					BindingFlags.Static |
					BindingFlags.Public |
					BindingFlags.NonPublic ));

			// Need to add parent static fields/methods manually since they are not returned by GetFields()/GetMethods()
			ParentType = CurrentType.BaseType;
			Parents = new System.Collections.ArrayList();
			if( ParentType != null && IsGeneratedType( ParentType ))
				Parents.Add( ParentType );

			while( ParentType != null )
			{
				if( IsGeneratedType( ParentType ))
				{
					ParentFields = ParentType.GetFields();
					for( j = 0; j < ParentFields.Length; j++ )
					{
						if( ParentFields [j].IsStatic )
						{
							NewClass.AddAttribute( ParentFields [j] );
						}
					}
					ParentMethods = ParentType.GetMethods(  BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.Public );
					for( j = 0; j < ParentMethods.Length; j++ )
						Methods.Add( ParentMethods [j] );
				}
				ParentType = ParentType.BaseType;
			}

			events = CurrentType.GetEvents();
			for( j = 0; j < events.Length; j++ )
				if( IsGeneratedEvent(( EventInfo )events [j] ))
					NewClass.AddEvent( events [j] );

			constructors = CurrentType.GetConstructors();
			k = 0;
			for( j = 0; j < constructors.Length; j ++ )
			{
				if( IsGeneratedMethod(( ConstructorInfo )constructors [j] ))
				{
					if( k > 0 )
						Suffix = Underscore + k.ToString();
					else
						Suffix = String.Empty;
					if( CurrentType.BaseType == null || CurrentType.BaseType.Equals( ObjectType ))
						NewClass.AddCreationRoutine( CreationRoutineName + Suffix, constructors [j] );
					else
						NewClass.AddCreationRoutine( CreationRoutineName + Underscore + NameFormatter.FormatTypeName( CurrentType ).ToLower() + Suffix, constructors [j] );
					k++;
				}
			}

			ParentInterfaces = CurrentType.GetInterfaces();
			if( ParentInterfaces != null )
			{
				for( k = 0; k < ParentInterfaces.Length; k++ )
				{
					if( IsGeneratedType( ParentInterfaces [k] ))
						Parents.Add( ParentInterfaces [k] );
				}
			}

			if( CurrentType.IsInterface )
			{
				Methods.AddRange( ObjectType.GetMethods(
					BindingFlags.Instance |
					BindingFlags.Static |
					BindingFlags.Public |
					BindingFlags.NonPublic ));
				if( ParentInterfaces.Length == 0 )
				{
					NewClass.AddParent( ObjectID );
					Parents.Add( ObjectType );
				}
				else
				// GetMethod() on interfaces only returns the method of the interface not of its parents
				{
					for( k = 0; k < ParentInterfaces.Length; k++ )
					{
//						bool FromTableAnyAny = false;
//						if (CurrentType.Name.Equals("TABLE_ANY_ANY")){
//							FromTableAnyAny = true;
//						}
//						AddInterfaceMethods( CurrentType, ref Methods, FromTableAnyAny);
						//if (CurrentType.Name.Equals("TABLE_ANY_ANY")){
						//	System.Diagnostics.Debugger.Break();
						//}
						//Methods.AddRange (AddInterfaceMethods( ParentInterfaces [k] ));
						
						if( IsGeneratedType( ParentInterfaces [k] ))
							Methods.AddRange( ParentInterfaces [k].GetMethods(
								BindingFlags.Instance |
								BindingFlags.Static |
								BindingFlags.Public |
								BindingFlags.NonPublic ));
					}
					

				}
			}
			else
			{
				for( k = 0; k < ParentInterfaces.Length; k++ )
				{
					if( IsGeneratedType( ParentInterfaces [k] ))
					{
						CurrentMap = CurrentType.GetInterfaceMap( ParentInterfaces [k] );
						CurrentMethods = CurrentMap.TargetMethods;
						for( l = 0; l < CurrentMethods.Length; l++ )
						{
							// if the CurrentMethods [l] key in null, do not proceed!
							if (CurrentMethods [l] != null)
							{
								if( MethodImplSource.Contains( CurrentMethods [l] ))
								{
									(( System.Collections.ArrayList )MethodImplSource [CurrentMethods [l]]).Add( CurrentMap.InterfaceMethods [l] );
								}
								else
								{
									MethodImpls.Add( CurrentMethods [l] );
									System.Collections.ArrayList MISList = new System.Collections.ArrayList();
									MISList.Add( CurrentMap.InterfaceMethods [l] );
									MethodImplSource.Add( CurrentMethods [l], MISList );
								}
							}
						}
					}
				}
			}

			// Calculate ID for each method
			for( j = 0; j < Methods.Count; j++ )
			{
				if( (IsGeneratedMethod(( MethodInfo )Methods [j] ))) //||MethodImpls.Contains(( MethodInfo )Methods [j] ))
				{
					
					PolymorphMethods = new System.Collections.ArrayList();
					ParentMethod = null;
					MethodInfo CurrentMethod =( MethodInfo )Methods [j];

					// For static methods that were added manually
					Found = CurrentMethod.ReflectedType != CurrentType;
					if( Found )
					{
						PolymorphMethods.Add( CurrentMethod );
						if( !CurrentMethod.IsVirtual || CurrentMethod.IsFinal )
							ParentMethod = CurrentMethod;
					}
					else
					{
						// If Method is MethodImpl then force binding to corresponding interface method.
						if( MethodImpls.Contains( CurrentMethod ))
							PolymorphMethods.AddRange(( System.Collections.ArrayList )MethodImplSource [CurrentMethod]);
						k = 0;
						while( !Found && k < Parents.Count )
						{
							if( !(( Type)Parents [k]).IsInterface )
							{
								ParentRoutines =(( EiffelClassFactory )ClassTable [( int )ClassIDTable [(( Type )Parents [k] )]] ).Routines;
								keys = new Object [ParentRoutines.Count] ;

								foreach( EiffelMethodFactory ParentMethod2 in ParentRoutines )
								{
									// Is CurrentMethod the descendant of ParentMethod?
									// Must check manually because interfaces are not part of inheritance hierarchy
									ParentMethod = ParentMethod2.Info;
									if( ParentMethod.Name == CurrentMethod.Name )
									{
										Parameters = ParentMethod.GetParameters();
										OtherParameters = CurrentMethod.GetParameters();
										Found =( Parameters.Length == OtherParameters.Length )&&( ParentMethod.ReturnType == CurrentMethod.ReturnType );
										if( Found )
										{
											for( m = 0; m < Parameters.Length && Found; m++ )
												Found =( Parameters [m].ParameterType ==  OtherParameters [m].ParameterType );
										}
									}
									if( Found )
										break;
								}
							}
							k++;
						}
						if( Found )
						{
							if( CurrentType.IsInterface ||( ParentMethod.IsVirtual && !ParentMethod.IsFinal ))
							{
								PolymorphMethods.Add( ParentMethod );
								ParentMethod = null;
							}
						}
						else
							ParentMethod = null;
					}

					// Assert that if Found then ParentMethod has been set
					if( Found &&( PolymorphMethods.Count == 0 )&&( ParentMethod == null ))
						throw new ApplicationException( "Error: Found parent method of " + CurrentMethod + " but search result is null" );

					// ID of new method is ID of parent method if Found, new unique ID otherwise.
					if( Found || PolymorphMethods.Count > 0 )
					{
						if( ParentMethod != null )
						{
							NewMethod = new EiffelMethodFactory( NewPolymorphID());
				   			for( k = 0; k < PolymorphMethods.Count; k++ )
				   			// TEMP HACK
				   			if (PolymorphMethods [k] != null){
								NewMethod.AddPolymorphIDs(( System.Collections.ArrayList )PolymorphicIDTable [(( MethodInfo )PolymorphMethods [k])]);
							}
						}
						else
						{
							NewMethod = new EiffelMethodFactory(( System.Collections.ArrayList )PolymorphicIDTable [(( MethodInfo )PolymorphMethods [0])]);
							for( k = 1; k < PolymorphMethods.Count; k++ )
				   			// TEMP HACK
				   			if (PolymorphMethods [k] != null){
								NewMethod.AddPolymorphIDs(( System.Collections.ArrayList )PolymorphicIDTable [(( MethodInfo )PolymorphMethods [k])]);
							}
						}
					}
					else
						NewMethod = new EiffelMethodFactory ( NewPolymorphID());						
				
					if( !Found )
						NewMethod.SetNewSlot();
							
					NewMethod.SetMethodInfo( CurrentMethod );
					if( CurrentType.IsInterface &&( IsVirtualObjectMethod( NewMethod )))
						NewMethod.SetDeferred( true );
					else
						NewMethod.SetDeferred( CurrentMethod.IsAbstract );

					#if BASIC
					#else
						EIFFEL_CLASS CurrentClass = EACInterface.type( CurrentType );
						if( CurrentClass != null && CurrentClass.modified() )
						{	
							EIFFEL_FEATURE CurrentFeature  = CurrentClass.routine_from_info( CurrentMethod );
							if( CurrentFeature != null && CurrentFeature.modified() )
								NewMethod.SetName( EmitterSupport.FromReflectionString (CurrentFeature.eiffel_name()) );
						}
					#endif
					NewClass.AddRoutine( NewMethod );

					if( !PolymorphicIDTable.ContainsKey( CurrentMethod ))
						PolymorphicIDTable.Add( CurrentMethod, new System.Collections.ArrayList( NewMethod.PolymorphIDs));
				}
			}
			ClassTable.Add(( int )ClassIDTable [CurrentType], NewClass );
			
			#if CTW
				if( ClassCount >= 50 )
				{
					if(((( Double )i )/( ClassCount / 50 ))==( i /( ClassCount / 50 ))) 
					{
						if( advanceCalls < 50 )
						{
							comComponent.Advance( 1 );
							advanceCalls++;
						}
					}
					if(( i == ClassCount - 1 )&&( advanceCalls < 50 ))
						comComponent.Advance( 50 - advanceCalls );
				}
				else
					comComponent.Advance( 50 / ClassCount );
			#endif
		}

		/********\
		* Pass 4 *
		\********/
		keys = new Object [ClassInfoTable.Count] ;
		ClassInfoTable.Keys.CopyTo( keys, 0 );

		// Add children
		for( i = 0; i < keys.Length; i++ )
		{
			NewClass = ( EiffelClassFactory )ClassTable [( int )ClassIDTable [( Type )ClassInfoTable [i]]];
			for( j = 0; j < NewClass.Parents.Count; j++ )
			{
				(( EiffelClassFactory )ClassTable [( int )NewClass.Parents [j]] ).AddChild( NewClass.ID );
			}
		}
		foreach( EiffelClassFactory Class in ClassTable.Values )
			Class.ResolveOperators();
		for( i = 0; i < ClassCount; i++ )
		{
			CurrentType =( Type )ClassInfoTable [i];
			NewClass =( EiffelClassFactory )ClassTable [( int )ClassIDTable [CurrentType]];
			NewClass.PrepareGeneration();
		}
	}
	


#if CTW		
	// Com component managing progress bar
	private ComComponentClass comComponent;
#endif	

	// TEMP HACK - hold the list of 'put' methods from TABEL_ANY_ANY
	//private System.Collections.ArrayList ShortMethods = new System.Collections.ArrayList();
	
	// Loaded assemblies, used in `LoadExternalAssemblies'
	private static System.Collections.ArrayList Done;
	
	// Id of currently processed class
	private int ClassId;

	// Class count
	private int ClassCount;

	// Table associating class names and ids
	// Key: Class full name
	// Value: Class UID ( Unique ID )
	private System.Collections.Hashtable IDTable;

	// Table associating ids with class information
	// Key: Class UID
	// Value: Instance of Type
	internal System.Collections.Hashtable ClassInfoTable;

	// Eiffel default creation routine name
	static private String CreationRoutineName = "make";

	// Underscore
	static private String Underscore = "_";
	
	// Name of `Equals' Method from System.Object.
	internal static String EqualsMethodName = "Equals";
	
	// Name of `ToString' Method from System.Object.
	internal static String ToStringMethodName = "ToString";
	
	// Name of `GetHashCode' Method from System.Object.
	internal static String HashCodeMethodName = "GetHashCode";
	
	// Name of `Finalize' Method from System.Object.
	internal static String FinalizeMethodName = "Finalize";
	
	// Table of MethodImpls
	// Key: MethodImpl body
	// Value: MethodImpl declaration (interface definition)
	private System.Collections.Hashtable MethodImplSource;
}
