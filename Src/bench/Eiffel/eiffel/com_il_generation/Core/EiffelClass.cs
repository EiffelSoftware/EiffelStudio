using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Diagnostics;
using System.Runtime.InteropServices;

#if BETA2
[ClassInterfaceAttribute (ClassInterfaceType.None)]
#endif
internal class EiffelClass : Globals
{
	public EiffelClass( ModuleBuilder ModuleB )
	{
		Interfaces = new System.Collections.ArrayList();
		BaseType = NoValue;
		Module = ModuleB;
		TypeBuilderCreated = false;
	}
	
	// Type ID
	public int TypeID;
	
	// Base type
	public int BaseType;
	
	// List of implemented Interfaces
	public System.Collections.ArrayList Interfaces;
	
	// Type Name
	public String Name;
	
	// Is class deferred?
	public bool IsDeferred;
	
	// Is class external?
	public bool IsExternal;
	
	// Is class expanded?
	public bool IsExpanded;
	
	// Is class interface?
	public bool IsInterface;

	// Is class an ARRAY class?
	public bool IsArray;

	// Does current class have a parent?
	public bool HasParent()
	{
		return( BaseType != NoValue );
	}
	
	// Type name of ARRAY Class
	public String ArrayElementName;

	// Invariant Routine
	public EiffelMethod InvariantRoutine;

	// Creation Routines
	public EiffelMethod[] CreationRoutines;

	// Set `FeatureID' of `FeatureIDTable' to be invariant
	// routine.
	public void SetInvariant (int FeatureID)
	{
		InvariantRoutine = (EiffelMethod) FeatureIDTable [FeatureID];
		InvariantRoutine.SetIsInvariant();
	}

	// Assign all routine with `FeatureIDs' to be creation routine
	// of Current class.
	public void SetCreationRoutines (int[] FeatureIDs)
	{
		CreationRoutines = new EiffelMethod [FeatureIDs.Length];
		int nb = FeatureIDs.Length;

		for (int i = 0; i < nb; i++) {
			CreationRoutines [i] = (EiffelMethod) FeatureIDTable [FeatureIDs [i]];
			CreationRoutines [i].SetIsCreationRoutine();
		}
	}


	// Type of elements of ARRAY
	public Type ArrayElementType ()
	{
		return Type.GetType (ArrayElementName);
	}

	// Associated type builder
	public Type Builder;
	
	// Associated ISymbolDocumentWriter
	public System.Diagnostics.SymbolStore.ISymbolDocumentWriter Document;
	
	// Methods
	// key: FeatureID
	// value: EiffelMethod
	public System.Collections.Hashtable FeatureIDTable;

	// Methods
	// key: RoutineID
	// value: EiffelMethod
	public System.Collections.Hashtable RoutIDTable;

	// Default Constructor for Eiffel objects
	public ConstructorInfo DefaultConstructor;

	// Set `IsDeferred' with `true'
	public void SetDeferred()
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetDeferred: Type Builder already created" );
		if( IsExpanded )
			throw new ApplicationException( "SetDeferred: Type cannot be both expanded and an interface or deferred (" + Name + ")" );
		IsDeferred = true;
	}
	
	// Set `IsExternal' with `true'
	public void SetExternal()
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetDeferred: Type Builder already created" );
		IsExternal = true;
	}
	
	// Set `IsExpanded' with `true'
	public void SetExpanded()
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetExpanded: Type Builder already created" );
		if( IsInterface )
			throw new ApplicationException( "SetExpanded: Type cannot be both expanded and an interface" );
		// Might be deferred, c.f. System.ValueType
		IsExpanded = true;
	}
	
	// Set `IsInterface' with `true'
	public void SetInterface()
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "IsInterface: Type Builder already created" );
		if( IsExpanded )
			throw new ApplicationException( "IsInterface: Type cannot be both expanded and an interface or deferred" );
		IsInterface = true;
	}

	// Set `IsInterface' with `true'
	public void SetTypeID( int ID )
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetTypeID: Type Builder already created" );
		TypeID = ID;
	}

	// Set `IsArray' with `true'
	public void SetIsArray ()
	{
		IsArray = true;
	}

	// Set `SetArrayElementName' with `a_name'
	public void SetArrayElementName ( String a_name )
	{
		ArrayElementName = a_name;
	}
	
	// Set `Document' with `Doc'
	public void SetDocument( System.Diagnostics.SymbolStore.ISymbolDocumentWriter Doc )
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetDocument: Type Builder already created" );
		Document = Doc;
	}
	
	// Set `IsInterface' with `true'
	public void SetName( String ClassName )
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "SetName: Type Builder already created" );
		Name = ClassName;
	}
	
	// Add Class with TypeID `ID' to list of parents
	public void AddParent( int ID )
	{
		if( TypeBuilderCreated )
			throw new ApplicationException( "AddParent: Type Builder already created" );
		if((( EiffelClass )ClassTable [ID]).IsInterface )
			Interfaces.Add( ID );
		else
		{
			if( BaseType != NoValue )
				throw new ApplicationException( "AddParent: Class " + Name + " already has a base type (" + ClassTable [BaseType].Builder +")");
			if( IsInterface )
				throw new ApplicationException( "AddParent: Class " + Name + " is an interface." );
			BaseType = ID;
		}
	}
	
	// Set feature id table
	public void SetFeatureIDTable( System.Collections.Hashtable Table )
	{
		if( FeatureIDTable != null )
			throw new ApplicationException( "SetFeatureIDTable: Feature ID table already exists" );
		FeatureIDTable = Table;
	}
	
	// Set method table
	public void SetRoutIDTable( System.Collections.Hashtable Table )
	{
		if( RoutIDTable != null )
			throw new ApplicationException( "SetRoutIDTable: Routine ID table already exists" );
		RoutIDTable = Table;
	}
	
	// Set `Builder' with `TypeBuilder'.
	// Used for external classes
	public void SetTypeBuilder( Type TypeBuilder )
	{
		Builder = TypeBuilder;
		TypeBuilderCreated = true;
	}
	
	// Set `DefaultConstructor' with `Cons'.
	public void SetDefaultConstructor( ConstructorInfo Cons )
	{
		DefaultConstructor = Cons;
	}
	
	// Create Type Builder
	// Warning: The interface array passed as argument to DefineType might be empty....
	public void CreateTypeBuilder()
	{
		Type[] LocalInterfaces;
		Type ParentType;
		int i;
		LocalInterfaces = new Type[ Interfaces.Count ];
		for( i = 0; i < Interfaces.Count; i++ )
			LocalInterfaces [i] = ClassTable [( int )Interfaces [i]].Builder;
		if( BaseType != NoValue )
			ParentType = ClassTable [BaseType].Builder;
		else
			ParentType = ObjectType;
		if( IsDeferred && !IsInterface )
		{
			Builder = Module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Abstract, ParentType, LocalInterfaces );
			DefineDefaultConstructor();
		}
		else
		{
			if( IsInterface )
					Builder = Module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Interface | TypeAttributes.Abstract, null,  LocalInterfaces );
			else
				{
					if( IsExpanded )
						Builder = Module.DefineType( Name, TypeAttributes.Public, ParentType, LocalInterfaces );
					else
					{
						Builder = Module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Class, ParentType, LocalInterfaces );
						DefineDefaultConstructor();
					}
				}
		}
		TypeBuilderCreated = true;
	}
	
	// Build constructor that calls parent constructor
	protected void DefineDefaultConstructor()
	{
		ConstructorBuilder constructor;
		ILGenerator generator;
		EiffelClass parent_class;

		if (BaseType != NoValue)
			parent_class = ClassTable [BaseType];
		else
			parent_class = null;

		if
			((BaseType == NoValue) ||
			((parent_class.IsExternal) && (parent_class.DefaultConstructor != null)))
		{
				// There is no parent, or there is an external parent that defines
				// a default constructor, we can define our default constructor
				// that calls the parent one.
			DefaultConstructor =(( TypeBuilder )Builder )
				.DefineDefaultConstructor( MethodAttributes.Public );
		} else {
			constructor =(( TypeBuilder )Builder )
				.DefineConstructor( MethodAttributes.Public, CallingConventions.Standard, EmptyArrayTypes );
			generator = constructor.GetILGenerator ();
				// If parent does not define a default constructor,
				// we generate a non-verifiable constructor.
				// Too bad, but we do not have the choice.
			if (parent_class.DefaultConstructor != null) {
				generator.Emit( OpCodes.Ldarg_0 );
				generator.Emit( OpCodes.Call, parent_class.DefaultConstructor);
			}
			generator.Emit( OpCodes.Ret );
			DefaultConstructor = constructor;
		}
	}

	// Module that contains type
	protected ModuleBuilder Module;
	
	// Was `CreateTypeBuilder' called?
	protected bool TypeBuilderCreated;

}
