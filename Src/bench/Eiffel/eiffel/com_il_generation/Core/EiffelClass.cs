/*
indexing
	description: "Abstract representation of a class or interface being generated
		or being reused (i.e. already generated)"
	date: "$Date $"
	revision: "$Revision$"
*/

using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Diagnostics;
using System.Runtime.InteropServices;

internal class EiffelClass
{
	public EiffelClass ()
	{
		Interfaces = new System.Collections.ArrayList();
		BaseType = EiffelReflectionEmit.NoValue;
		#if ASSERTIONS
			TypeBuilderCreated = false;
		#endif
	}
	
	// Associated ModuleBuilder
	protected ModuleBuilder module;
	
	// Type ID
	public int TypeID, InterfaceID;

	// ExportedTypeID for generic conformance.
	public int ExportedTypeID;
	
	// Base type
	public int BaseType;
	
	// List of implemented Interfaces
	public System.Collections.ArrayList Interfaces;
	
	// Type Name
	public String Name;
	
	// Is class deferred?
	public bool IsDeferred;
	
	// Is class frozen?
	public bool IsFrozen;
		
	// Is class external?
	public bool IsExternal;
	
	// Is class expanded?
	public bool IsExpanded;
	
	// Is class interface?
	public bool IsInterface;

	// Is class implementation?
	public bool IsImplementation;

	// Is class an ARRAY class?
	public bool IsArray;

	// Does current class have a parent?
	public bool HasParent()
	{
		return( BaseType != EiffelReflectionEmit.NoValue );
	}
	
	// Type name of ARRAY Class
	public String ArrayElementName;

	// Invariant Routine
	public EiffelMethod InvariantRoutine;

	// Creation Routines
	public EiffelMethod[] CreationRoutines;

	// SetTypeID routine
	public MethodBuilder set_type_id;

	private string source_file_name = null;
			// Location of Eiffel source file defining Current.

	// Set `FeatureID' of `FeatureIDTable' to be invariant
	// routine.
	public void SetInvariant (int FeatureID)
	{
		InvariantRoutine = (EiffelMethod) FeatureIDTable [FeatureID];
		InvariantRoutine.SetIsInvariant(true);
	}

	// Assign all routine with `FeatureIDs' to be creation routine
	// of Current class.
	public void SetCreationRoutines (int[] FeatureIDs)
	{
		CreationRoutines = new EiffelMethod [FeatureIDs.Length];
		int nb = FeatureIDs.Length;

		for (int i = 0; i < nb; i++) {
			CreationRoutines [i] = (EiffelMethod) FeatureIDTable [FeatureIDs [i]];
			CreationRoutines [i].SetIsCreationRoutine(true);
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
	public System.Collections.Hashtable StaticFeatureIDTable;

	// Default Constructor for Eiffel objects
	protected ConstructorInfo InternalDefaultConstructor;
	public ConstructorInfo DefaultConstructor {
		get {
			if
				((InternalDefaultConstructor == null) &&
				EiffelReflectionEmit.Classes [TypeID].IsExternal &&
				!EiffelReflectionEmit.Classes [TypeID].IsArray)
			{
				EiffelReflectionEmit.Classes [TypeID].SetDefaultConstructor (
					EiffelReflectionEmit.Classes [TypeID].Builder.GetConstructor (
						BindingFlags.NonPublic | BindingFlags.Public | BindingFlags.Instance,
						null, Type.EmptyTypes, null));
			}
			return InternalDefaultConstructor;
		}
	}

	public void set_module (ModuleBuilder a_module)
		// Assign `a_module' to `module'.
	{
		module = a_module;
	}

	public void set_source_file_name (string a_file_name)
		// Assign `a_file_name' to `source_file_name'.
	{
		source_file_name = a_file_name;
	}

	public void create_document ()
		// When debugging is enabled associated `source_file_name' to module to
		// create `Document' used for generating debug information.
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetDocument: Type Builder already created" );
		#endif

			// Create Document associated to current class.
		Document = module.DefineDocument (source_file_name, new Guid ("6805C61E-8195-490c-87EE-A713301A670C"),
			new Guid ("B68AF30E-9424-485f-8264-D4A726C162E7"),
			System.Guid.Empty);

			// Not needed anymore.
		source_file_name = null;
	}

	// Set `IsDeferred' with `val'
	public void SetIsDeferred(bool val)
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetIsDeferred: Type Builder already created" );
			if( IsExpanded )
				throw new ApplicationException( "SetIsDeferred: Type cannot be both expanded " +
					"and an interface or deferred (" + Name + ")" );
		#endif
		IsDeferred = val;
	}

	// Set `IsFrozen' with `val'
	public void SetIsFrozen(bool val)
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetIsFrozen: Type Builder already created" );
		#endif
		IsFrozen = val;
	}
		
	// Set `IsExternal' with `val'
	public void SetIsExternal(bool val)
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetIsExternal: Type Builder already created" );
		#endif
		IsExternal = val;
	}
	
	// Set `IsExpanded' with `val'
	public void SetIsExpanded(bool val)
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetIsExpanded: Type Builder already created" );
			if( IsInterface )
				throw new ApplicationException( "SetIsExpanded: Type cannot be both expanded and an interface" );
		#endif
		IsExpanded = val;
	}
	
	// Set `IsInterface' with `val'
	public void SetIsInterface(bool val)
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetIsInterface: Type Builder already created" );
			if( IsExpanded )
				throw new ApplicationException( "SetIsInterface: Type cannot be both expanded " +
					"and an interface or deferred" );
		#endif
		IsInterface = val;
	}

	// Set `TypeID' with `ID'
	public void SetTypeID( int ID )
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetTypeID: Type Builder already created" );
		#endif
		TypeID = ID;
	}

	// Set `InterfaceID' with `ID'
	public void SetInterfaceID( int ID )
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetTypeID: Type Builder already created" );
		#endif
		InterfaceID = ID;
	}


	// Set `IsArray' with `true'
	public void SetIsArray (bool val)
	{
		IsArray = val;
	}

	// Set `SetArrayElementName' with `a_name'
	public void SetArrayElementName ( String a_name )
	{
		ArrayElementName = a_name;
	}
	
	// Set `IsInterface' with `true'
	public void SetName( String ClassName )
	{
	  	#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "SetName: Type Builder already created" );
		#endif
		Name = ClassName;
	}
	
	// Add Class with TypeID `ID' to list of parents
	public void AddParent( int ID )
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "AddParent: Type Builder already created" );
		#endif
		if (EiffelReflectionEmit.Classes [ID].IsInterface) {
			Interfaces.Add (ID);
		} else {
			#if ASSERTIONS
				if( BaseType != EiffelReflectionEmit.NoValue )
					throw new ApplicationException( "AddParent: Class " + Name +
						" already has a base type (" + EiffelReflectionEmit.Classes [BaseType].Builder +")");
				if( IsInterface )
					throw new ApplicationException( "AddParent: Class " + Name + " is an interface." );
			#endif
			BaseType = ID;
		}
	}

	// Add _EIFFEL_TYPE_INFO interface to implementation class
	public void AddEiffelInterface (int ID) {
		ExportedTypeID = ID;
		IsImplementation = true;
	}
	
	// Set feature id table
	public void SetFeatureIDTable( System.Collections.Hashtable Table )
	{
		#if ASSERTIONS
			if( FeatureIDTable != null )
				throw new ApplicationException( "SetFeatureIDTable: Feature ID table already exists" );
		#endif
		FeatureIDTable = Table;
	}
	
	// Set method table
	public void SetStaticFeatureIDTable( System.Collections.Hashtable Table )
	{
		#if ASSERTIONS
			if( StaticFeatureIDTable != null )
				throw new ApplicationException (
					"SetStaticFeatureIDTable: Routine ID table already exists");
		#endif
		StaticFeatureIDTable = Table;
	}
	
	// Set `Builder' with `TypeBuilder'.
	// Used for external classes
	public void SetTypeBuilder( Type TypeBuilder )
	{
		Builder = TypeBuilder;
		#if ASSERTIONS
			TypeBuilderCreated = true;
		#endif
	}
	
	// Set `DefaultConstructor' with `Cons'.
	public void SetDefaultConstructor( ConstructorInfo Cons )
	{
		InternalDefaultConstructor = Cons;
	}
	
	// Create Type Builder
	// Warning: The interface array passed as argument to DefineType might be empty....
	public void CreateTypeBuilder()
	{
		Type[] LocalInterfaces;
		Type ParentType;
		int i;
		if (IsImplementation) {
			LocalInterfaces = new Type [Interfaces.Count + 1];
			LocalInterfaces [Interfaces.Count] = EiffelReflectionEmit.ISE_EiffelInterface;
		} else {
			LocalInterfaces = new Type [Interfaces.Count];
		}
		for( i = 0; i < Interfaces.Count; i++ )
			LocalInterfaces [i] = EiffelReflectionEmit.Classes [( int )Interfaces [i]].Builder;
		if( BaseType != EiffelReflectionEmit.NoValue )
			ParentType = EiffelReflectionEmit.Classes [BaseType].Builder;
		else
			ParentType = EiffelReflectionEmit.ObjectType;
		if( IsDeferred && !IsInterface )
		{
			Builder = module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Abstract, ParentType, LocalInterfaces );
			DefineDefaultConstructor();
		}
		else
		{
			if( IsInterface )
					Builder = module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Interface | TypeAttributes.Abstract, null,  LocalInterfaces );
			else
				{
					if( IsExpanded )
						Builder = module.DefineType( Name, TypeAttributes.Public, ParentType, LocalInterfaces );
					else
					{
						Builder = module.DefineType( Name, TypeAttributes.Public | TypeAttributes.Class, ParentType, LocalInterfaces );
						DefineDefaultConstructor();
					}
				}
		}

		if (IsImplementation) {
				// Add ____type_id and ____set_type_id feature
			TypeBuilder builder = (TypeBuilder) Builder;
			MethodBuilder method;
			FieldBuilder attribute;
			Type int32_type = Type.GetType ("System.Int32");
			ILGenerator MethodIL;

				// Define storage of type information
			attribute = builder.DefineField ("$$____type_id", int32_type, FieldAttributes.Family);

				// Define access to type id info
			method = builder.DefineMethod (
				"____type_id",
				MethodAttributes.Family | MethodAttributes.Virtual | MethodAttributes.Final |
					MethodAttributes.Public,
				int32_type, Type.EmptyTypes);

			MethodIL = method.GetILGenerator();
			MethodIL.Emit (OpCodes.Ldarg_0);
			MethodIL.Emit (OpCodes.Ldfld, attribute);
			MethodIL.Emit (OpCodes.Ret);

			set_type_id = builder.DefineMethod (
				"____set_type_id",
				MethodAttributes.Family | MethodAttributes.Virtual | MethodAttributes.Final |
					MethodAttributes.Public,
				EiffelReflectionEmit.VoidType,
				new Type [1] {int32_type});

			MethodIL = set_type_id.GetILGenerator();
			MethodIL.Emit (OpCodes.Ldarg_0);
			MethodIL.Emit (OpCodes.Ldarg_1);
			MethodIL.Emit (OpCodes.Stfld, attribute);
			MethodIL.Emit (OpCodes.Ret);

		}
		#if ASSERTIONS
			TypeBuilderCreated = true;
		#endif
	}
	
	// Build constructor that calls parent constructor
	protected void DefineDefaultConstructor()
	{
		ConstructorBuilder constructor;
		ILGenerator generator;
		EiffelClass parent_class;

		if (BaseType != EiffelReflectionEmit.NoValue)
			parent_class = EiffelReflectionEmit.Classes [BaseType];
		else
			parent_class = null;

		if
			((BaseType == EiffelReflectionEmit.NoValue) ||
			((parent_class.IsExternal) && (parent_class.DefaultConstructor != null)))
		{
				// There is no parent, or there is an external parent that defines
				// a default constructor, we can define our default constructor
				// that calls the parent one.
			InternalDefaultConstructor =(( TypeBuilder )Builder )
				.DefineDefaultConstructor( MethodAttributes.Public );
		} else {
			constructor =(( TypeBuilder )Builder )
				.DefineConstructor( MethodAttributes.Public, CallingConventions.Standard, Type.EmptyTypes );
			generator = constructor.GetILGenerator ();
				// If parent does not define a default constructor,
				// we generate a non-verifiable constructor.
				// Too bad, but we do not have the choice.
			if (parent_class.DefaultConstructor != null) {
				generator.Emit( OpCodes.Ldarg_0 );
				generator.Emit( OpCodes.Call, parent_class.DefaultConstructor);
			}
			generator.Emit( OpCodes.Ret );
			InternalDefaultConstructor = constructor;
		}
	}

#if ASSERTIONS
	// Was `CreateTypeBuilder' called?
	protected bool TypeBuilderCreated;
#endif

}
