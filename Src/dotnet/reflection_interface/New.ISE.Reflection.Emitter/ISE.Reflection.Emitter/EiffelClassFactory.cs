/*
 * Include all the information needed to produce the Eiffel code
 *
 */
using System;
using System.Reflection;
using System.Reflection.Emit;
using System.IO;

public class EiffelClassFactory : Globals
{
	// Set `Name' with `name'
	// `name' should be the full name of the type
	public EiffelClassFactory( int ClassID, Type aType )
	{
		Routines = new System.Collections.ArrayList();
		Attributes = new System.Collections.Hashtable();
		ImplementationFeatures = new System.Collections.Hashtable();
		ElementChangeFeatures = new System.Collections.Hashtable();
		AccessFeatures = new System.Collections.Hashtable();
		BasicOperations = new System.Collections.Hashtable();
		UnaryOperatorsFeatures = new System.Collections.Hashtable();
		BinaryOperatorsFeatures = new System.Collections.Hashtable();
		SpecialFeatures = new System.Collections.Hashtable();
		CreationRoutines =  new System.Collections.Hashtable();
		events = new System.Collections.ArrayList();
		Renames = new RenameClauses();
		Redefines = new RedefineClauses();
		Undefines = new UndefineClauses();
		Selects = new SelectClauses();
		Parents = new System.Collections.ArrayList();
		Children = new System.Collections.ArrayList();
		MethodNames = new System.Collections.ArrayList();
		AttributesNames =  new System.Collections.Hashtable();
		ID = ClassID;
		TypeName = aType.FullName;
		Name = NameFormatter.FormatTypeName( aType );
		UnderlyingType = aType;
		UsedClassFeatures = new System.Collections.ArrayList();
		
		if( aType.Assembly.GetName() != null )
		{
			AssemblyName = aType.Assembly.GetName().Name;
			AssemblyVersion = aType.Assembly.GetName().Version.ToString();
			AssemblyCulture = aType.Assembly.GetName().CultureInfo.ToString();
			if( AssemblyCulture == "" )
				AssemblyCulture = "neutral";
			byte[] AKey = aType.Assembly.GetName().GetPublicKeyToken();
			if (AKey != null)
				AssemblyKey = DecodeKey (AKey);
		}
	}

	static EiffelClassFactory () {
			// Special classes for which no creation routine should be generated
		SpecialClasses = new System.Collections.Hashtable (10);
		SpecialClasses.Add ("INTEGER", "INTEGER");
		SpecialClasses.Add ("INTEGER_16", "INTEGER_16");
		SpecialClasses.Add ("INTEGER_64", "INTEGER_64");
		SpecialClasses.Add ("INTEGER_8", "INTEGER_8");
		SpecialClasses.Add ("DOUBLE", "DOUBLE");
		SpecialClasses.Add ("REAL", "REAL");
		SpecialClasses.Add ("BOOLEAN", "BOOLEAN");
		SpecialClasses.Add ("CHARACTER", "CHARACTER");
	}

	// Add a parent to the class
	// name: parent name
	virtual internal void AddParent( int ParentID )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		Parents.Add( ParentID );
	}

	// Add a child to the class
	// name: child name
	virtual internal void AddChild( int ChildID )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		Children.Add( ChildID );
	}

	// TEMP HACK
	private System.Collections.ArrayList UsedClassFeatures;

	// Add a routine to the class
	// Method: EiffelMethodFactory describing routine
	// MethodID: routine PolymorphID
	virtual internal void AddRoutine( EiffelMethodFactory Method )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		Routines.Add( Method );
	}

	// Add an attribute to the class
	// info: attribute name and type
	virtual internal void AddAttribute( FieldInfo info )
	{
		String AttributeName;
		System.Collections.ArrayList NewList;
		
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		
		if( IsGeneratedField( info ))
		{
			AttributeName = NameFormatter.FormatVariableName( info.Name );
			// Fields can be overloaded via inheritance
			if( Attributes.ContainsKey( AttributeName ))
				(( System.Collections.ArrayList )Attributes [AttributeName]).Add( info );
			else
			{
				NewList = new System.Collections.ArrayList();
				NewList.Add( info );
				Attributes.Add( AttributeName, NewList );
			}
		}
	}

	// Add a creation routine to the class
	// name: creation routine name
	// info: creation routine signature
	virtual internal void AddCreationRoutine( String name, ConstructorInfo info )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
			
		if( IsGeneratedMethod( info ))
			CreationRoutines.Add( name, new EiffelCreationRoutine( info ));
	}

	// Add an event to the class
	// info: event to be added
	virtual internal void AddEvent( EventInfo info )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		if( IsGeneratedEvent( info ))
			events.Add( info );
	}

	// Set `IsDeferred' with `Deferred'.
	virtual internal void SetDeferred( Boolean Deferred )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		IsDeferred = Deferred;
	}

	// Set `IsExpanded' with `Expanded'.
	virtual internal void SetExpanded( Boolean Expanded )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		IsExpanded = Expanded;
	}

	// Set `IsSealed' with `Sealed'.
	virtual internal void SetSealed( Boolean Sealed )
	{
		if( GenerationPrepared )
			throw new ApplicationException( "Error: Cannot call " + MethodInfo.GetCurrentMethod().Name + " after PrepareGeneration()" );
		IsSealed = Sealed;
	}
	
	// Does `ArgumentName' conflict with existing feature names?
	// Case insensitive.
	virtual internal Boolean NameClash( String ArgumentName )
	{
		Boolean Found = MethodNames.Contains( ArgumentName.ToLower())||
				AttributesNames.ContainsValue( ArgumentName.ToLower())||
				CreationRoutines.Contains( ArgumentName.ToLower());

		for( int i = 0;( i < Parents.Count )&& !Found; i++ )
			Found =(( EiffelClassFactory )ClassTable[ Parents [i] ]).NameClash( ArgumentName.ToLower());

		return Found;
	}

	//Check binary operators and put them in class that defines the type fo the first argument
	virtual internal void ResolveOperators()
	{
		EiffelClassFactory Other;
		System.Collections.ArrayList RemovedIndexes;
		RemovedIndexes = new System.Collections.ArrayList();
		foreach( EiffelMethodFactory CurrentMethod in Routines )
		{
			if( BinaryOperators().ContainsKey( CurrentMethod.Info.Name ))
			{
				Type PType = CurrentMethod.Info.GetParameters()[0].ParameterType;
				if( !PType.IsAssignableFrom( UnderlyingType ))
				{
					if( ClassIDTable.ContainsKey( PType ))
					{
						Other =( EiffelClassFactory )ClassTable [( int )ClassIDTable [PType]];
						Other.Routines.Add( CurrentMethod );
						foreach( int ChildrenID in Other.Children )
							(( EiffelClassFactory )ClassTable [ChildrenID]).Routines.Add( CurrentMethod );
					}
					RemovedIndexes.Add( Routines.IndexOf( CurrentMethod ));
				}			
			}
		}
		if( RemovedIndexes.Count > 0 )
		{
			System.Collections.ArrayList NewRoutines = new System.Collections.ArrayList();
			for( int i = 0; i < Routines.Count; i ++ )
			{
				if( !RemovedIndexes.Contains( i ))
					NewRoutines.Add( Routines [i]);
			}
			Routines = NewRoutines;
		}
	}

	// Calculate inheritance clauses and feature names.
	// Set `BasicOperations', `ElementChangeFeatures', `AccessFeatures', `UnaryOperatorsFeatures', `BinaryOperatorsFeatures', `SpecialFeatures' and `ImplementationFeatures' according to `Routines'.
	virtual internal void PrepareGeneration()
	{
		int j, k;
		MethodInfo Info;
		FieldInfo CurrentAttribute;
		String MethodName, NewName;
		bool GeneratedInCurrent, IsSmallest;
		System.Collections.ArrayList CurrentList;

		if( !GenerationPrepared )
		{
			// Resolve inheritance and overloading for methods
			ResolveInheritanceAndOverloading();

			// Resolve inheritance and overloading for attributes( Parent and Child can have a static field with same name )
			foreach( String CurrentName in Attributes.Keys )
			{
				NewName = CurrentName;
				CurrentList =( System.Collections.ArrayList )Attributes [CurrentName];
				
				GeneratedInCurrent = false;
				for( j = 0; j < CurrentList.Count & !GeneratedInCurrent; j++ )
				{
					CurrentAttribute =( FieldInfo )CurrentList [j];
					GeneratedInCurrent = CurrentAttribute.ReflectedType.FullName == TypeName;
				}
				for( j = 0; j < CurrentList.Count; j++ )
				{
					CurrentAttribute =( FieldInfo )CurrentList [j];
					if( CurrentAttribute.ReflectedType.FullName != TypeName && GeneratedInCurrent )
					{
						IsSmallest = true;
						if( CurrentList.Count == 2 )
						{
							NewName = CurrentName + ClassIDTable [CurrentAttribute.ReflectedType];
							Renames.Add((( EiffelClassFactory )ClassTable[( int )ClassIDTable[CurrentAttribute.ReflectedType]]).Name, CurrentName, NewName );
						}
						else
						{
							for( k = 0; k < CurrentList.Count && IsSmallest; k++ )
								IsSmallest =( !(( FieldInfo )CurrentList [k]).Equals( CurrentAttribute ))&&(( int )ClassIDTable [CurrentAttribute.ReflectedType] <( int )ClassIDTable [(( FieldInfo )CurrentList [k]).ReflectedType ]);
							if( IsSmallest )
							{
								NewName = CurrentName + ClassIDTable[CurrentAttribute.ReflectedType];
								Renames.Add((( EiffelClassFactory )ClassTable[( int )ClassIDTable[CurrentAttribute.ReflectedType]]).Name, CurrentName, NewName );
							}
						}
					}
					if( CurrentAttribute.DeclaringType.FullName == TypeName )
					{
						if( CurrentAttribute.IsPublic )
							// FIXME: InitOnly attributes
							AccessFeatures.Add( NewName, CurrentAttribute );
						else
							ImplementationFeatures.Add( NewName, CurrentAttribute );
					}

					if( !( AttributesNames.ContainsValue( NewName.ToLower())))
						AttributesNames.Add( CurrentAttribute, NewName.ToLower());
				}
			}

			foreach( EiffelMethodFactory CurrentMethod in Routines )
			{
				Info = CurrentMethod.Info;
				MethodName = NameFormatter.FormatVariableName( CurrentMethod.Name());

				// Add to features to be generated only if implemented/redefined in current type
				if( IsGeneratedInCurrent( CurrentMethod ))
				{
					if( Info.IsPublic )
					{
						if( Info.IsSpecialName )
						{
							if( MethodName.StartsWith( PropertyGetPrefix ))
							{
								if( !AccessFeatures.ContainsKey( MethodName ))
									AccessFeatures.Add( MethodName, CurrentMethod );
							}
							else
							{
								if( MethodName.StartsWith( PropertySetPrefix ))
								{
									if( !ElementChangeFeatures.ContainsKey( MethodName ))
										ElementChangeFeatures.Add( MethodName, CurrentMethod );
								}
								else
								{
									if( MethodName.StartsWith( EventAddPrefix ))
									{
										if( !ElementChangeFeatures.ContainsKey( MethodName ))
											ElementChangeFeatures.Add( MethodName, CurrentMethod );
									}
									else
									{
										if( MethodName.StartsWith( EventRemovePrefix ))
										{
											if( !ElementChangeFeatures.ContainsKey( MethodName ))
												ElementChangeFeatures.Add( MethodName, CurrentMethod );
										}
										else
										{
											if( UnaryOperators().ContainsKey( Info.Name ))
											{
												if( !UnaryOperatorsFeatures.ContainsKey( MethodName ))
													UnaryOperatorsFeatures.Add( MethodName, CurrentMethod );
											}
											else
											{
												if( BinaryOperators().ContainsKey( Info.Name ))
												{
													if( !BinaryOperatorsFeatures.ContainsKey( MethodName ))
														BinaryOperatorsFeatures.Add( MethodName, CurrentMethod );
												}
												else
												{
													if( !SpecialFeatures.ContainsKey( MethodName ))
														SpecialFeatures.Add( MethodName, CurrentMethod );
												}
											}
										}
									}
								}
							}								
						}
						else
						{
							if( !BasicOperations.ContainsKey( MethodName ))
								BasicOperations.Add( MethodName, CurrentMethod );
						}
					}
					else
					{
						if( !ImplementationFeatures.ContainsKey( MethodName ))
							ImplementationFeatures.Add( MethodName, CurrentMethod );
					}
				}
				MethodNames.Add( MethodName.ToLower());
			}
			GenerateRoutinesArgumentsNames();

			// Resolve name clash between creation routines and features
			ResolveCreationRoutineNameClash();
			
			GenerationPrepared = true;
		}
	}

	// Generate routines arguments names.
	virtual protected void GenerateRoutinesArgumentsNames()
	{
		if(( CreationRoutines.Count > 0 )&&( !IsDeferred )&&( !SpecialClasses.ContainsKey( Name )))
		{
			foreach( String CreationRoutine in CreationRoutines.Keys )
				GenerateCreationRoutineArgumentsNames( CreationRoutine, CreationRoutines );
		}
	
		if( AccessFeatures.Count > 0 )
		{
			foreach( String AccessFeature in AccessFeatures.Keys )
				GenerateArgumentsNames( AccessFeature, AccessFeatures );
		}

		if( ElementChangeFeatures.Count > 0 )
		{
			foreach( String ElementChangeFeature in ElementChangeFeatures.Keys )
				GenerateArgumentsNames( ElementChangeFeature, ElementChangeFeatures );
		}

		if( BasicOperations.Count > 0 )
		{
			foreach( String BasicOperation in BasicOperations.Keys )
				GenerateArgumentsNames( BasicOperation, BasicOperations );
		}

		if( BinaryOperatorsFeatures.Count > 0 )
		{
			foreach( String BinaryOperatorsFeature in BinaryOperatorsFeatures.Keys )
				GenerateBinaryOperatorsArgumentsNames( BinaryOperatorsFeature, BinaryOperatorsFeatures );
		}

		if( SpecialFeatures.Count > 0 )
		{
			foreach( String SpecialFeature in SpecialFeatures.Keys )
				GenerateArgumentsNames( SpecialFeature, SpecialFeatures );
		}

		if( ImplementationFeatures.Count > 0 )
		{
			foreach( String ImplementationFeature in ImplementationFeatures.Keys )
				GenerateArgumentsNames( ImplementationFeature, ImplementationFeatures );
		}
	}

	// Generated Code
	virtual internal String Code()
	{
		String GeneratedCode;
		int i, j;
		String Parent;

		if( !GenerationPrepared )
			throw new ApplicationException( "Error: PrepareGeneration()must be called before Code()" );
		if( Name == null )
			throw new ApplicationException( "Error: SetName( String name )must be called before Code()" );

		GeneratedCode = "indexing\r\n\tgenerator: \"Eiffel Emitter " + VersionNumber + "\"\r\n";
		GeneratedCode += "\texternal_name: \"" + NameFormatter.FormatStrongName( TypeName )+ "\"\r\n";

		if( AssemblyName != null )
			GeneratedCode += "\tassembly: \"" + AssemblyName + "\", \"" + AssemblyVersion + "\", \"" + AssemblyCulture + "\", \"" + AssemblyKey + "\"\r\n";
		 
		if( UnderlyingType.IsEnum ) {
			GeneratedCode += "\tenum_type: \"" + NameFormatter.FormatArgumentTypeName( Enum.GetUnderlyingType( UnderlyingType ))+ "\"\r\n\r\n";
				/* Remove non-needed feature for enum types */
			AccessFeatures.Remove (EnumValueName);
		} else
			GeneratedCode += "\r\n";

		if( IsSealed )
			GeneratedCode += "frozen ";
		if( IsExpanded )
			GeneratedCode += "expanded ";
		if( IsDeferred )
			GeneratedCode += "deferred ";
		GeneratedCode += "external class\r\n\t";
		GeneratedCode += Name;
		GeneratedCode += "\r\n\r\n";

		if( Parents.Count > 1 || Renames.HasClause( "OBJECT" )|| Redefines.HasClause( "OBJECT" )|| Undefines.HasClause( "OBJECT" )||(( Parents.Count == 1 )&&( !(( EiffelClassFactory )ClassTable [Parents [0]]).Name.Equals( "OBJECT" ))))
		{
			GeneratedCode += "inherit";
			for( i = 0; i < Parents.Count; i++ )
			{
				Parent =(( EiffelClassFactory )ClassTable [Parents [ i ]]).Name;
				if( !Parent.Equals( "OBJECT" )|| Renames.HasClause( "OBJECT" )|| Redefines.HasClause( "OBJECT" )|| Undefines.HasClause( "OBJECT" ))
					GeneratedCode += "\r\n\t" + Parent;

				if( Renames.HasClause( Parent ))
				{
					GeneratedCode += "\r\n\t\trename";
					for( j = 0; j < Renames.Count( Parent ); j++ )
					{
						GeneratedCode += "\r\n\t\t\t" + Renames.RenameClauseSource( Parent, j )+ " as " + Renames.RenameClauseTarget( Parent, j );
						if( j < Renames.Count( Parent )- 1 )
							GeneratedCode += ",";
					}
				}

				if( Undefines.HasClause( Parent ))
				{
					GeneratedCode += "\r\n\t\tundefine";
					for( j = 0; j < Undefines.Count( Parent ); j++ )
					{
						GeneratedCode += "\r\n\t\t\t" + Undefines.UndefineFeature( Parent, j );
						if( j < Undefines.Count( Parent )- 1 )
							GeneratedCode += ",";
					}
				}

				if( Redefines.HasClause( Parent ))
				{
					GeneratedCode += "\r\n\t\tredefine";
					for( j = 0; j < Redefines.Count( Parent ); j++ )
					{
						GeneratedCode += "\r\n\t\t\t" + Redefines.RedefineFeature( Parent, j );
						if( j < Redefines.Count( Parent )- 1 )
							GeneratedCode += ",";
					}
				}

				if( Selects.HasClause( Parent ))
				{
					GeneratedCode += "\r\n\t\tselect";
					for( j = 0; j < Selects.Count( Parent ); j++ )
					{
						GeneratedCode += "\r\n\t\t\t" + Selects.SelectFeature( Parent, j );
						if( j < Selects.Count( Parent )- 1 )
							GeneratedCode += ",";
					}
				}

				if(( Renames.HasClause( Parent ))|| Redefines.HasClause( Parent )|| Undefines.HasClause( Parent )|| Selects.HasClause( Parent ))
					GeneratedCode += "\r\n\t\tend";
			}
			GeneratedCode += "\r\n\r\n";
		}

			// Do not generate creation clause for deferred classes or expanded classes.
		if(( CreationRoutines.Count > 0 )&&( !IsDeferred )&&( !SpecialClasses.ContainsKey( Name )))
		{
			if( !IsExpanded ){
				GeneratedCode += "create";
				i = 0;
				foreach( String CreationRoutine in CreationRoutines.Keys )
				{
					GeneratedCode += "\r\n\t" + CreationRoutine;
					if( i <( CreationRoutines.Count - 1 ))
						GeneratedCode += ",";
					i++;
				}
				GeneratedCode += "\r\n\r\nfeature {NONE} -- Initialization\r\n\r\n";
			} else {
				GeneratedCode += "feature -- Initialization\r\n\r\n";
			}
			foreach( String CreationRoutine in CreationRoutines.Keys )
				GeneratedCode += GeneratedRoutine( CreationRoutine, CreationRoutines );
		}
		else
			if(( CreationRoutines.Count == 0 )&& !IsDeferred && !IsExpanded )
				GeneratedCode += "create {NONE}\r\n\r\n";
		if( AccessFeatures.Count > 0 )
		{
			GeneratedCode += "feature -- Access\r\n\r\n";
			foreach( String AccessFeature in AccessFeatures.Keys )
				GeneratedCode += GeneratedRoutine( AccessFeature, AccessFeatures );
		}

		if( ElementChangeFeatures.Count > 0 )
		{
			GeneratedCode += "feature -- Element Change\r\n\r\n";
			foreach( String ElementChangeFeature in ElementChangeFeatures.Keys )
					GeneratedCode += GeneratedRoutine( ElementChangeFeature, ElementChangeFeatures );
		}

		if( BasicOperations.Count > 0 )
		{
			GeneratedCode += "feature -- Basic Operations\r\n\r\n";
			foreach( String BasicOperation in BasicOperations.Keys )
				GeneratedCode += GeneratedRoutine( BasicOperation, BasicOperations );
		}
		else
		{
			if ((UnderlyingType.IsEnum))
			{
				GeneratedCode += "feature -- Basic Operations\r\n\r\n";
				GeneratedCode += "\tinfix \"|\" (infix_arg: like Current): like Current is";
				GeneratedCode += "\r\n\t\tdo\r\n\t\t\t--Built-in\r\n\t\tend\r\n\r\n";
				GeneratedCode += "\tfrom_integer (value: like INTEGER) is";
				GeneratedCode += "\r\n\t\tdo\r\n\t\t\t--Built-in\r\n\t\tend\r\n\r\n";
				GeneratedCode += "\tto_integer: INTEGER is";
				GeneratedCode += "\r\n\t\tdo\r\n\t\t\t--Built-in\r\n\t\tend\r\n\r\n";
			}
		}

		if( UnaryOperatorsFeatures.Count > 0 )
		{
			GeneratedCode += "feature -- Unary Operators\r\n\r\n";
			foreach( String UnaryOperatorsFeature in UnaryOperatorsFeatures.Keys )
				GeneratedCode += GeneratedRoutine( UnaryOperatorsFeature, UnaryOperatorsFeatures );
		}

		if( BinaryOperatorsFeatures.Count > 0 )
		{
			GeneratedCode += "feature -- Binary Operators\r\n\r\n";
			foreach( String BinaryOperatorsFeature in BinaryOperatorsFeatures.Keys )
				GeneratedCode += GeneratedRoutine( BinaryOperatorsFeature, BinaryOperatorsFeatures );
		}

		if( SpecialFeatures.Count > 0 )
		{
			GeneratedCode += "feature -- Specials\r\n\r\n";
			foreach( String SpecialFeature in SpecialFeatures.Keys )
				GeneratedCode += GeneratedRoutine( SpecialFeature, SpecialFeatures );
		}

		if( ImplementationFeatures.Count > 0 )
		{
			GeneratedCode += "feature {NONE} -- Implementation\r\n\r\n";
			foreach( String ImplementationFeature in ImplementationFeatures.Keys )
				GeneratedCode += GeneratedRoutine( ImplementationFeature, ImplementationFeatures );
		}

		GeneratedCode += "end -- class " + Name;
		GeneratedCode += "\r\n";

		return GeneratedCode;
	}

	// Gives name to creation routines that do no conflict with features
	// of the class.
	virtual protected void ResolveCreationRoutineNameClash()
	{
		int k;
		Boolean Clash;
		String UniqueName;
		System.Collections.Hashtable OtherCreationRoutines;
		
		OtherCreationRoutines =( System.Collections.Hashtable )CreationRoutines.Clone();
		foreach( String CRName in OtherCreationRoutines.Keys )
		{
			k = 1;
			UniqueName = CRName;
			Clash = MethodNames.Contains( UniqueName )|| AttributesNames.ContainsValue( UniqueName );
			while( Clash )
			{
				UniqueName = UniqueName.TrimEnd( Digits );
				UniqueName += k;
				k++;
				Clash = MethodNames.Contains( UniqueName )||
						AttributesNames.ContainsValue( UniqueName )||
						OtherCreationRoutines.Contains( UniqueName );
			}
			if( CRName != UniqueName )
			{
				CreationRoutines.Add( UniqueName, OtherCreationRoutines [CRName]);
				CreationRoutines.Remove( CRName );
			}
		}
	}

	// Add Rename and Redefine clauses as needed
	// Solve overloading
	// Set the following data:
	// 		- RenameClauses: Renames clauses of inherit clause.
	// 		- RedefineClauses: Redefine clauses of inherit clause.
	// 		- All EiffelMethodFactory.Name, non-overloaded names of methods.
	virtual protected void ResolveInheritanceAndOverloading()
	{
		System.Collections.Hashtable Methods;
		System.Collections.ArrayList MethodList, LocalMethodList, ParentMethodList;
		String UniqueName;
		Boolean Unique;
		int j, k;
		Type CurrentType;
		MethodInfo CurrentMethodInfo;
		EiffelClassFactory CurrentParent, OtherParent;

		// Build table of list of methods with same name
		Methods = new System.Collections.Hashtable();
		foreach( EiffelMethodFactory CurrentMethod in Routines )
		{
			UniqueName = NameFormatter.FormatVariableName( CurrentMethod.Name());
			if( Methods.ContainsKey( UniqueName ))
				(( System.Collections.ArrayList )Methods [UniqueName]).Add( CurrentMethod );
			else
			{
				MethodList = new System.Collections.ArrayList();
				MethodList.Add( CurrentMethod );
				Methods.Add( UniqueName, MethodList );
			}
		}
		
		// stop the debugger
		//if ((Name.Equals("ISE_REFLECTION_EIFFEL_COMPONENTS_IMPLEMENTATION_TABLE_ANY_ANY")) ||
		//	(Name.Equals("ISE_REFLECTION_EIFFEL_COMPONENTS_TABLE_ANY_ANY"))){
		//		//System.Diagnostics.Debugger.Break();
		//	}
		
		
		String[] ConflictingMethodNames = new String [Methods.Count];
		Methods.Keys.CopyTo( ConflictingMethodNames, 0 );
		// Resolve name clash for each entry in list
		foreach( System.Collections.ArrayList MethodList2 in Methods.Values )
		{
			if( MethodList2.Count > 1 )
			{
				ParentMethodList = new System.Collections.ArrayList();
				LocalMethodList = new System.Collections.ArrayList();
				foreach( EiffelMethodFactory CurrentMethod in MethodList2 )
				{
					if( CurrentMethod.Info.DeclaringType == UnderlyingType )
						LocalMethodList.Add( CurrentMethod );
					else
						ParentMethodList.Add( CurrentMethod );
				}

				// Rename parent methods if needed
				if( ParentMethodList.Count > 1 )
				{
					ParentMethodList.Sort();
					ParentMethodList.RemoveAt( 0 );
					foreach( EiffelMethodFactory CurrentMethod in ParentMethodList )
					{
						UniqueName = NameFormatter.FormatVariableName( CurrentMethod.Name());
						if( CurrentMethod.Info.GetParameters().Length == 0 )
							UniqueName += "_" + NameFormatter.FormatVariableName( CurrentMethod.Info.ReturnType.Name );
						else
						{
							Unique = false;
							k = 0;
							while(( k < CurrentMethod.Info.GetParameters().Length )&& !Unique )
							{
								Unique = true;
								CurrentType =( Type )( CurrentMethod.Info.GetParameters()[k].ParameterType );
								j = 0;
								while(( j < MethodList2.Count )&& Unique )
								{
									CurrentMethodInfo =(( EiffelMethodFactory )MethodList2 [j]).Info;
									// CurrentMethodInfo can be null in case MethodList2 [j] corresponds to DummyMethod.
									if( !CurrentMethod.Info.Equals( CurrentMethodInfo )&&( CurrentMethodInfo != null )&&( CurrentMethodInfo.GetParameters().Length  > k ))
										Unique = !( CurrentMethodInfo.GetParameters()[k].ParameterType.Equals( CurrentType ));
									j++;
								}
								UniqueName += "_" + NameFormatter.FormatVariableName( CurrentMethod.Info.GetParameters()[k].ParameterType.Name );
								k++;
							}
						}
						// The resulting name might already exist in a parent class
						k = 2;
						while( Array.IndexOf( ConflictingMethodNames, UniqueName, 0 )!= -1 )
						{
							UniqueName.TrimEnd( Digits );
							UniqueName += k.ToString();
							k++;
						}
						if( Array.IndexOf( ConflictingMethodNames, UniqueName, 0 )== -1 )
						{
							String[] NewConflictingMethodNames = new String [ConflictingMethodNames.Length + 1];
							Array.Copy( ConflictingMethodNames, NewConflictingMethodNames, ConflictingMethodNames.Length );
							NewConflictingMethodNames [ConflictingMethodNames.Length] = UniqueName;
							ConflictingMethodNames = NewConflictingMethodNames;
						}
						RenameChildren( CurrentMethod, UniqueName );
						CurrentMethod.SetName( UniqueName );
					}
				}


				// Rename Local methods
				LocalMethodList.Sort();
				
				// No need to rename all features if there is no conflict with parent features.
				if( ParentMethodList.Count == 0 )
					LocalMethodList.RemoveAt( 0 );
				foreach( EiffelMethodFactory CurrentMethod in LocalMethodList )
				{
					UniqueName = NameFormatter.FormatVariableName( CurrentMethod.Name());
					if( CurrentMethod.Info.GetParameters().Length == 0 )
						UniqueName += "_" + NameFormatter.FormatVariableName( CurrentMethod.Info.ReturnType.Name );
					else
					{
						Unique = false;
						k = 0;
						while(( k < CurrentMethod.Info.GetParameters().Length )&& !Unique )
						{
							Unique = true;
							CurrentType =( Type )( CurrentMethod.Info.GetParameters()[k].ParameterType );
							j = 0;
							while(( j < MethodList2.Count )&& Unique )
							{
								CurrentMethodInfo =(( EiffelMethodFactory )MethodList2 [j]).Info;
								if( !CurrentMethod.Info.Equals( CurrentMethodInfo )&&( CurrentMethodInfo.GetParameters().Length  > k ))
									Unique = !( CurrentMethodInfo.GetParameters()[k].ParameterType.Equals( CurrentType ));
								j++;
							}
							UniqueName += "_" + NameFormatter.FormatVariableName( CurrentMethod.Info.GetParameters()[k].ParameterType.Name );
							k++;
						}
					}
					// The resulting name might already exist in a parent class
					k = 2;
					while( Array.IndexOf( ConflictingMethodNames, UniqueName, 0 )!= -1 )
					{
						UniqueName.TrimEnd( Digits );
						UniqueName += k.ToString();
						k++;
					}
					if( Array.IndexOf( ConflictingMethodNames, UniqueName, 0 )== -1 )
					{
						String[] NewConflictingMethodNames = new String [ConflictingMethodNames.Length + 1];
						Array.Copy( ConflictingMethodNames, NewConflictingMethodNames, ConflictingMethodNames.Length );
						NewConflictingMethodNames [ConflictingMethodNames.Length] = UniqueName;
						ConflictingMethodNames = NewConflictingMethodNames;
					}
					RenameChildren( CurrentMethod, UniqueName );
					CurrentMethod.SetName( UniqueName );
				}
			}
		}
		// Now checks for MethodImpls( force rename if one is found )and redefines/undefines
		System.Collections.Hashtable DeletedRoutines = new System.Collections.Hashtable();
		foreach( EiffelMethodFactory CurrentMethod in Routines )
		{
			for( j = 0; j < Parents.Count; j++ )
			{
				CurrentParent =(( EiffelClassFactory )ClassTable [( int )Parents [j]]);
				foreach( EiffelMethodFactory ParentMethod in CurrentParent.Routines )
				{
					if( ParentMethod.HasPolymorphID( CurrentMethod ))
					{
						if( ParentMethod.IsPolymorphic )
						{
							// Check names for MethodImpls
							if( CurrentMethod.Name()!= ParentMethod.Name())
							{
								RenameFeature( CurrentParent, ParentMethod, CurrentMethod.Name());
								// Rename the corresponding inherited method in current class
								// Set polymorphic status to source polymorphic status so that
								// there will be no redefine on frozen features.
								// Merge the two features
								foreach( EiffelMethodFactory OtherMethod in Routines )
								{
									if(( OtherMethod != CurrentMethod )&&( OtherMethod.Name()== ParentMethod.Name())&&OtherMethod.HasPolymorphID( ParentMethod ))
									{
										if( OtherMethod.Info.DeclaringType == UnderlyingType )
											OtherMethod.SetName( NameFormatter.FormatVariableName( CurrentMethod.Name()));
										else
										{
											if( DeletedRoutines.Contains( ID ))
												(( System.Collections.ArrayList )DeletedRoutines [ID]).Add( OtherMethod );
											else
											{
												System.Collections.ArrayList NewList = new System.Collections.ArrayList();
												NewList.Add( OtherMethod );
												DeletedRoutines.Add( ID, NewList );
												
												// Propagate to children
												for( k = 0; k < Children.Count; k++ )
												{
													EiffelClassFactory CurrentChild =( EiffelClassFactory )ClassTable[( int )Children [k]];
													foreach( EiffelMethodFactory ChildMethod in CurrentChild.Routines )
													{
														if(( ChildMethod.Name()== NameFormatter.FormatVariableName( CurrentMethod.Name()))&&( ChildMethod.Info.DeclaringType != UnderlyingType )&&( ChildMethod.Info.DeclaringType != CurrentChild.UnderlyingType )&&ChildMethod.HasPolymorphID( ParentMethod ))
														{
															if( DeletedRoutines.Contains( Children [k]))
																(( System.Collections.ArrayList )DeletedRoutines [Children [k]]).Add( ChildMethod );
															else
															{
																NewList = new System.Collections.ArrayList();
																NewList.Add( ChildMethod );
																DeletedRoutines.Add( Children [k], NewList );
															}
														}
													}
												}
											}
										}
									}
								}
							}
							if( !CurrentMethod.IsDeferred && !ParentMethod.IsDeferred && IsGeneratedInCurrent( CurrentMethod ))
								Redefines.Add( CurrentParent.Name, NameFormatter.FormatVariableName( CurrentMethod.Name()));
							if( CurrentMethod.IsDeferred && !ParentMethod.IsDeferred )
								Undefines.Add( CurrentParent.Name, NameFormatter.FormatVariableName( CurrentMethod.Name()));
						}
						// Same PolymorphID but different bodies -> select
						else
						{
							if( CurrentMethod.Info.DeclaringType == UnderlyingType )
							{
								bool Done = false;
								for( k = 0; k < Parents.Count && !Done; k++ )
								{
									OtherParent =(( EiffelClassFactory )ClassTable [( int )Parents [k]]);
									foreach( EiffelMethodFactory OtherMethod in OtherParent.Routines )
									{
										if( OtherMethod.HasPolymorphID( CurrentMethod )&& OtherMethod.IsPolymorphic )
										{
											Selects.Add( OtherParent.Name, NameFormatter.FormatVariableName( CurrentMethod.Name()));
											Done = true;
											break;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		foreach( int key in DeletedRoutines.Keys )
			foreach( EiffelMethodFactory OtherMethod in( System.Collections.ArrayList )DeletedRoutines [key])
				(( EiffelClassFactory )ClassTable [key]).Routines.Remove( OtherMethod );
	}

	// Rename `Method' to avoid clash in current class.
	// ParentName: Name of parent from which `Method' is inherited.
	// NewName: Name of parent from which `Method' is inherited.
	virtual protected void RenameFeature( EiffelClassFactory Parent, EiffelMethodFactory Method, String NewName )
	{
		EiffelClassFactory CurrentParent;
		String UniqueName = NameFormatter.FormatVariableName( NewName );
		String OldName;
		Renames.Add( Parent.Name, NameFormatter.FormatVariableName( Method.Name()), UniqueName );
		for( int i = 0; i < Parents.Count; i++ )
		{
			CurrentParent =( EiffelClassFactory )ClassTable [( int )Parents [i]];
			foreach( EiffelMethodFactory CurrentMethod in CurrentParent.Routines )
			if( CurrentMethod.HasPolymorphID( Method )&& CurrentMethod.IsPolymorphic )
			{
				OldName = NameFormatter.FormatVariableName( CurrentMethod.Name());
				if( !Renames.Has( CurrentParent.Name, OldName, UniqueName ))
					Renames.Add( CurrentParent.Name, OldName, UniqueName );
			}
		}
		RenameChildren( Method, UniqueName );
	}
	
	// Rename method `Method' in all the children to `NewName'
	virtual protected void RenameChildren( EiffelMethodFactory Method, String NewName )
	{
		for( int i = 0; i < Children.Count; i++ )
		{
			foreach( EiffelMethodFactory CurrentMethod in(( EiffelClassFactory )ClassTable[( int )Children [i]]).Routines )
			{
				if( CurrentMethod.HasPolymorphID( Method ))
				{
					CurrentMethod.SetName( NewName );
					(( EiffelClassFactory )ClassTable[( int )Children [i]]).RenameChildren( Method, NewName );
				}
			}
		}
	}

	// Generate the Routines with name `name' in table `RoutineTable'.
	// name: Name of routine whose code is to be generated
	// RoutineTable: Table of Routines, the key if the name of the routine,
	// the value can be any of the following:
	// 		- ConstructorInfo, in this case the feature is considered non-frozen,
	// 		  non-static, non deferred with no return type.
	// 		  Only used for creation features.
	//		- MethodInfo
	//		- FieldInfo, will generate a setter or a getter according to
	//		  the feature name( setter if name begins with `PropertySetPrefix',
	//		  getter otherwise ).

	virtual protected String GeneratedRoutine( String RoutineName, System.Collections.Hashtable RoutineTable )
	{
		// stops the $$name entering the class
		if ((RoutineName.IndexOf("____") > -1) || (RoutineName.IndexOf("#") > -1)) return "";
		
		String GeneratedCode;
		String ArgumentType;
		String Signature = null;
		String returnName;
		String ArgumentName;
		String Temp;
		Type returnType;
		ConstructorInfo ConstructorDescriptor = null;
		MethodInfo MethodDescriptor = null;
		FieldInfo FieldDescriptor  = null;
		ParameterInfo[] Arguments = new ParameterInfo[] {};
		bool IsField, IsMethod, IsCreationRoutine;
		bool IsUnaryOperator = false;
		bool IsBinaryOperator = false;
		bool IsEnumLiteral = false;
		bool IsLiteral = false;
		int i;
		EiffelMethodFactory MethodFactory;
		EiffelCreationRoutine CreationRoutine;
		
		// TEMP HACK - Applicable to add, determines if the feature should be added or not
		for (i = 0; i < UsedClassFeatures.Count; i++){
			if ( RoutineName.Equals ((string)UsedClassFeatures[i]) )
			{
				return "";
			}
			
		}
		// TEMP HACK - Add the name of the method to the list of class features
		UsedClassFeatures.Add(RoutineName);
		
		IsMethod = typeof( EiffelMethodFactory ).IsInstanceOfType( RoutineTable [RoutineName]);
		if( IsMethod )
		{
			IsBinaryOperator = BinaryOperators().ContainsKey((( EiffelMethodFactory )RoutineTable [RoutineName]).Info.Name );
			IsUnaryOperator = UnaryOperators().ContainsKey((( EiffelMethodFactory )RoutineTable [RoutineName]).Info.Name );
			MethodDescriptor =(( MethodInfo )((( EiffelMethodFactory )RoutineTable [RoutineName]).Info ));
			Arguments = MethodDescriptor.GetParameters();
			if( !IsUnaryOperator ||( Arguments.Length > 0 ))
			{
				Signature = " signature (";
				for( i = 0; i < Arguments.Length; i++ )
				{
					if( IsBinaryOperator )
						i = 1;
					Signature += NameFormatter.FormatStrongName( Arguments [i].ParameterType.FullName );
					if( i < Arguments.Length - 1 )
						Signature += ", ";
				}
				Signature += "): ";
				Temp = "";
			}
			else
				Temp = " signature : ";
			if( MethodDescriptor.ReturnType != VoidType )
				Signature += Temp + NameFormatter.FormatStrongName( MethodDescriptor.ReturnType.FullName );
			Signature += " ";			
		}
		IsField = FieldInfoType.IsInstanceOfType( RoutineTable [RoutineName]);
		if( IsField ){
			FieldDescriptor =(( FieldInfo )RoutineTable [RoutineName]);
				/* Finds out if we are handling a Literal value from an enum type
				 * or if it is a constant. In the last case, we should not generate
				 * a body, just an Eiffel constant value.
				 */
			IsLiteral = FieldDescriptor.IsLiteral;
			IsEnumLiteral = IsLiteral  && UnderlyingType.IsEnum;
		}
		if( !IsMethod && !IsField )
		{
			CreationRoutine =(( EiffelCreationRoutine )RoutineTable [RoutineName]);
			ConstructorDescriptor =( ConstructorInfo )CreationRoutine.Info;
			Arguments = ConstructorDescriptor.GetParameters();
			if( Arguments == null )
				throw new ApplicationException( "Not a valid name for a routine: " + RoutineName + " in type " + Name );
			if( Arguments.Length > 0 )
			{
				Signature = " signature (";
				for( i = 0; i < Arguments.Length; i++ )
				{
					Signature += NameFormatter.FormatStrongName( Arguments [i].ParameterType.FullName );
					if( i < Arguments.Length - 1 )
						Signature += ", ";
				}
				Signature += ")";
			}
			Signature += " ";			
		}
		GeneratedCode = "\t";
		if( 
			( IsMethod &&( MethodDescriptor.IsFinal || !MethodDescriptor.IsVirtual || MethodDescriptor.IsStatic ))||
			( IsField )|| 
			( !IsMethod && !IsField ))
				// Frozen Eiffel features correspond to:
				// 1 - a feature which is final or not virtual
				// 2 - a static feature
				// 3 - an attribute
				// 4 - a constructor
			GeneratedCode += "frozen ";
		if( IsUnaryOperator &&(( EiffelMethodFactory )RoutineTable [RoutineName]).Name()== MethodDescriptor.Name )
		{
			GeneratedCode += UnaryOperators()[MethodDescriptor.Name];
		}
		else
			if( IsBinaryOperator &&(( EiffelMethodFactory )RoutineTable [RoutineName]).Name()== MethodDescriptor.Name )
			{
				GeneratedCode += BinaryOperators()[MethodDescriptor.Name];
			}
			else
			{
				// TEMP HACK - changes all thos occurances of "_in_infix" to infix "+"
				if (RoutineName.IndexOf("_in_infix") > -1) 
					GeneratedCode += "infix \"+\"";
				else
					GeneratedCode += RoutineName;
			}

		if( !IsUnaryOperator &&( Arguments.Length > 0 ))
		{
			GeneratedCode += " (";
			{
				for( i = 0; i < Arguments.Length; i++ )
				{
					if( IsBinaryOperator )
						i = 1;
					ArgumentType = NameFormatter.FormatArgumentTypeName( Arguments[i].ParameterType );

					if( IsMethod )
					{
						MethodFactory =( EiffelMethodFactory )RoutineTable [RoutineName];
						ArgumentName =( String )( MethodFactory.ArgumentsNames [i]);
					}
					else
					{
					 	ArgumentName = "";
						if( !IsField && !IsMethod )
						{
							IsCreationRoutine = typeof( EiffelCreationRoutine ).IsInstanceOfType( RoutineTable [RoutineName]);
							if( IsCreationRoutine )
							{
								CreationRoutine =( EiffelCreationRoutine )RoutineTable [RoutineName];
								ArgumentName =( String )( CreationRoutine.ArgumentsNames [i]);
							}
							else
							{
								ArgumentName = "";
								throw new ApplicationException( "Not a valid feature( neither a method, nor a field nor a creation routine ): " + RoutineName + " in type " + Name );
							}
						}
					
					}
					
					GeneratedCode += ArgumentName + ": " + ArgumentType;
					if( i <( Arguments.Length - 1 ))
						GeneratedCode += "; ";
				}
				GeneratedCode += ")";
			}
		}

		if( IsMethod )
		{
			returnType =( Type )MethodDescriptor.ReturnType;
			if( !returnType.Name.ToLower().Equals( "void" ))
			{
				returnName = NameFormatter.FormatArgumentTypeName( returnType );
				GeneratedCode += ": " + returnName;
			}
		}
		if( IsField&& !FieldDescriptor.Name.StartsWith( PropertySetPrefix ))
				GeneratedCode += ": " + NameFormatter.FormatArgumentTypeName( FieldDescriptor.FieldType );
		GeneratedCode += " is";

		if (IsEnumLiteral || !IsLiteral)
			GeneratedCode += "\r\n\t\texternal\r\n\t\t\t";

		if( IsMethod )
		{
			if( IsUnaryOperator || IsBinaryOperator )
			{
				GeneratedCode += "\"IL operator" + Signature + "use " + NameFormatter.FormatStrongName( TypeName )+ "\"";
			}
			else
			{
				if( MethodDescriptor.IsStatic )
				{
					GeneratedCode += "\"IL static" + Signature + "use " + NameFormatter.FormatStrongName( TypeName )+ "\"";
				}
				else
				{
					if( MethodDescriptor.IsAbstract )
					{
						GeneratedCode += "\"IL deferred" + Signature + "use " + NameFormatter.FormatStrongName( TypeName )+ "\"";
					}
					else
					{
						GeneratedCode += "\"IL" + Signature + "use " + NameFormatter.FormatStrongName( TypeName )+ "\"";
					}
				}
			}
		}
		else
		{
			if( IsField )
			{
				if( FieldDescriptor.IsStatic ){
					if (!IsEnumLiteral && IsLiteral) {
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
						value = FieldDescriptor.GetValue (UnderlyingType);
						if (value is double) {
							double d = (double) value;
							if (double.IsInfinity (d) || double.IsNaN (d))
								GeneratedCode = "";
							else
								GeneratedCode += " " + value;
						} else if (value is float) {
							float s = (float) value;
							if (float.IsInfinity (s) || float.IsNaN (s))
								GeneratedCode = "";
							else
								GeneratedCode += " " + value;
						} else if (value is char) {
							char c = (char) value;
							if ((c == char.MaxValue) || (c == char.MinValue))
								GeneratedCode = "";
							else
								GeneratedCode += " '" + value + "'";
						} else if (value is int) {
							int a_i = (int) value;
							GeneratedCode += " 0x" + a_i.ToString ("x");
						} else if (value is byte) {
							byte b = (byte) value;
							GeneratedCode += " 0x" + b.ToString ("x");
						} else if (value is short) {
							short s = (short) value;
							GeneratedCode += " 0x" + s.ToString ("x");
						} else if (value is long) {
							long l = (long) value;
							GeneratedCode += " 0x" + l.ToString ("x");
						} else if (value is string) {
							GeneratedCode += " \"" + (string) value + "\"";
							GeneratedCode = String.Concat ("--", GeneratedCode);
						} else
							GeneratedCode += " " + value;
					} else {
						if( IsEnumLiteral )
							GeneratedCode += "\"IL enum ";
						else
							GeneratedCode += "\"IL static_field ";
						
						GeneratedCode += "signature :" + NameFormatter.FormatStrongName
							( FieldDescriptor.FieldType.FullName )+ " use " +
							NameFormatter.FormatStrongName( TypeName )+ "\"";
					}
				} else
					GeneratedCode += "\"IL field signature :" + NameFormatter.FormatStrongName(
						FieldDescriptor.FieldType.FullName )+ " use " +
						NameFormatter.FormatStrongName( TypeName )+ "\"";
			}
			else
				GeneratedCode += "\"IL creator" + Signature + "use " +
					NameFormatter.FormatStrongName( TypeName )+ "\"";
		}
		if (IsEnumLiteral || !IsLiteral) {
			if (IsMethod || IsField)
			{
				GeneratedCode += "\r\n\t\talias";
				if( IsMethod )
					GeneratedCode += "\r\n\t\t\t\"" + MethodDescriptor.Name.Replace("\"", "%\"") +"\"";
				else
					if( IsEnumLiteral ){
						GeneratedCode += "\r\n\t\t\t\"";
						GeneratedCode += Convert.ToInt64 (FieldDescriptor.GetValue( UnderlyingType )) + "\"";
					} else
						GeneratedCode += "\r\n\t\t\t\"" + FieldDescriptor.Name +"\"";
			}
			GeneratedCode += "\r\n\t\tend\r\n\r\n";
		} else {
			if (GeneratedCode.Length > 0)
				GeneratedCode += "\r\n\r\n";
		}

		return GeneratedCode;
	}

	// Should `Method' be generated in code of current class?
	virtual internal bool IsGeneratedInCurrent( EiffelMethodFactory Method )
	{
		bool InterfacesParents = true;
		int i;
		
		if( Method.Info.DeclaringType.FullName == TypeName )
			return true;
		if( Parents.Count <= 1 )
			return false;
		// Cannot just check for parents containing Object because of interfaces.
		for( i = 0; i < Parents.Count && InterfacesParents; i++ )
			InterfacesParents =(( EiffelClassFactory )ClassTable[( int )Parents [i]]).UnderlyingType.IsInterface ||(( int )Parents [i] == ObjectID );
		return InterfacesParents &&( IsVirtualObjectMethod( Method ))&& !UnderlyingType.IsInterface;
	}

	// Generate arguments names for routine with name `RoutineName' in table `RoutineTable'.
	virtual protected void GenerateCreationRoutineArgumentsNames( String RoutineName, System.Collections.Hashtable RoutineTable )
	{
		EiffelCreationRoutine CreationRoutine;
		ConstructorInfo ConstructorDescriptor = null;
		ParameterInfo[] Arguments = new ParameterInfo[] {};
		String [] ArgumentsNames;		
		
		CreationRoutine =( EiffelCreationRoutine )RoutineTable [RoutineName];
		ConstructorDescriptor =( ConstructorInfo )CreationRoutine.Info;
		Arguments = ConstructorDescriptor.GetParameters();
		if( Arguments.Length > 0 )
		{
			ArgumentsNames = InternGenerateArgumentsNames( Arguments, false );
			if( ArgumentsNames.Length == Arguments.Length )
				CreationRoutine.SetArgumentsNames( ArgumentsNames );
			else
				throw new ApplicationException( "not the same number of arguments names and types" );
		}
	}

	// Generate arguments names for routine with name `RoutineName' in table `RoutineTable'.
	virtual protected void GenerateBinaryOperatorsArgumentsNames( String RoutineName, System.Collections.Hashtable RoutineTable )
	{
		EiffelMethodFactory MethodFactory;
		MethodInfo MethodDescriptor = null;
		ParameterInfo[] Arguments = new ParameterInfo[] {};
		String [] ArgumentsNames;		
		
		MethodFactory =( EiffelMethodFactory )RoutineTable [RoutineName];
		MethodDescriptor =( MethodInfo )MethodFactory.Info;
		Arguments = MethodDescriptor.GetParameters();
		if( Arguments.Length > 0 )
		{
			ArgumentsNames = InternGenerateArgumentsNames( Arguments, true );
			if( ArgumentsNames.Length == Arguments.Length )
				MethodFactory.SetArgumentsNames( ArgumentsNames );
			else
				throw new ApplicationException( "not the same number of arguments names and types" );
		}
	}

	// Generate arguments names for routine with name `RoutineName' in table `RoutineTable'.
	virtual protected void GenerateArgumentsNames( String RoutineName, System.Collections.Hashtable RoutineTable )
	{
		EiffelMethodFactory MethodFactory;
		MethodInfo MethodDescriptor = null;
		ParameterInfo[] Arguments = new ParameterInfo[] {};
		Boolean IsMethod;
		String [] ArgumentsNames;		
		
		IsMethod = typeof( EiffelMethodFactory ).IsInstanceOfType( RoutineTable [RoutineName]);	
		if( IsMethod )
		{
			MethodFactory =( EiffelMethodFactory )RoutineTable [RoutineName];
			MethodDescriptor =( MethodInfo )MethodFactory.Info;
			Arguments = MethodDescriptor.GetParameters();
			if( Arguments.Length > 0 )
			{
				ArgumentsNames = InternGenerateArgumentsNames( Arguments, false );
				if( ArgumentsNames.Length == Arguments.Length )
					MethodFactory.SetArgumentsNames( ArgumentsNames );
				else
					throw new ApplicationException( "not the same number of arguments names and types" );
			}
		}
	}
	
	// Generate arguments names from info `Arguments' accordingly feature `IsBinaryOperator' or not.
	virtual protected String [] InternGenerateArgumentsNames( ParameterInfo [] Arguments, bool IsBinaryOperator )
	{
		String ArgumentName;
		String [] ArgumentsNames;
		int i,j;
		
		ArgumentsNames = new String [Arguments.Length];
		for( i = 0; i < Arguments.Length; i++ )
		{
			if( IsBinaryOperator )
				i = 1;
				
				// Some argument names are empty!!
			if( Arguments[i].Name == null )
				ArgumentName = "arg_" + i;
			else
				ArgumentName = NameFormatter.FormatVariableName( Arguments[i].Name );
				
			j = 2;
			while( NameClash( ArgumentName ))
			{
				ArgumentName = ArgumentName.TrimEnd( Digits );
				ArgumentName += j;
				j++;
			}			
			ArgumentsNames [i] = ArgumentName;
		}			
		return ArgumentsNames;
	}

	// Convert a double value into a hexadecimal string representation
	private static string ToHexa (double d) {
		byte[] bytes = BitConverter.GetBytes(d);
		string result = null;
		foreach(byte b in bytes)
			result += b.ToString("x");
		return result;
	}
	
	// Decode 128 bit key into string
	protected string DecodeKey( byte[] Key )
	{
		string Result = "";
		string Hex;
		for( int i = 0; i < Key.Length; i++ )
		{
			Hex = Key [i].ToString( "X" ).ToLower();
			if( Hex.Length < 2 )
			//	Hex = "0" + Hex;
				Hex = Hex.PadLeft( 1, '0' );
			Result += Hex;
			//Result = String.Concat( Result, Hex );
		}
		return Result;
	}
	
	// Class ID
	internal int ID;
	
	// Class name
	internal String Name;
	
	// Underlying Type
	internal Type UnderlyingType;

	// Is class deferred?
	internal Boolean IsDeferred;

	// Is class sealed?
	internal Boolean IsSealed;

	// Is class expanded?
	internal Boolean IsExpanded;

	// Features of the class (includes all features)
	// Value: EiffelMethodFactory
	internal System.Collections.ArrayList Routines;
	
	// Attributes of the class (includes all attributes)
	// Value: FieldInfo
	internal System.Collections.Hashtable Attributes;
	
	// Routines of the class in Basic Operations feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable BasicOperations;

	// Routines of the class in Unary Operators feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable UnaryOperatorsFeatures;

	// Routines of the class in Binary Operators feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable BinaryOperatorsFeatures;

	// Routines of the class in Special feature clause (marked with IsSpecialName and not infix or prefix or creation routine)
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable SpecialFeatures;

	// Routines of the class in Implementation feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable ImplementationFeatures;

	// Routines of the class in Access feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable AccessFeatures;

	// Routines of the class in Element change feature clause
	// Key: Routine Name
	// Value: EiffelMethodFactory
	internal System.Collections.Hashtable ElementChangeFeatures;

	// Creation Routines
	// value: EiffelCreationRoutine
	// key: Creation routine name
	internal System.Collections.Hashtable CreationRoutines;

	// List of final routine names 
	// Value: Method final names
	internal System.Collections.ArrayList MethodNames;

	// Table associating FieldInfo with attributes final names
	// Key: FieldInfo
	// Value: Attribute final name
	internal System.Collections.Hashtable AttributesNames;
	
	// Events
	// Item: EventInfo
	private System.Collections.IList events;

	// Parents
	// Item: Class ID
	internal System.Collections.IList Parents;

	// Children
	// Item: Class ID
	private System.Collections.IList Children;

	// Rename clauses
	internal RenameClauses Renames;

	// Redefine clauses
	internal RedefineClauses Redefines;

	// Undefine clauses
	internal UndefineClauses Undefines;

	// Select clauses
	internal SelectClauses Selects;

	// Associated assembly display name
	internal string AssemblyName;
	
	// Associated assembly display name
	internal string AssemblyVersion;
	
	// Associated assembly display name
	internal string AssemblyCulture;
	
	// Associated assembly display name
	internal string AssemblyKey;
	
	// Classes without creation Routines
	static internal System.Collections.Hashtable SpecialClasses;

	// Original type name
	internal String TypeName;

	// Can Code()be called?
	internal Boolean GenerationPrepared;

	// Prefix for property set method
	static internal String PropertySetPrefix = "set_";

	// Prefix for property get method
	static private String PropertyGetPrefix = "get_";
	
	// Prefix for event add method
	static internal String EventAddPrefix = "add_";

	// Prefix for event removal method
	static private String EventRemovePrefix = "remove_";

	// Name of field `value__' used in enum types.
	static internal String EnumValueName = "value__";
}
