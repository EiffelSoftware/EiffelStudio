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

namespace ISE.Compiler {

internal class CLASS
{
	public CLASS ()
	{
		Interfaces = new System.Collections.ArrayList();
		BaseType = COMPILER.NoValue;
		#if ASSERTIONS
			TypeBuilderCreated = false;
		#endif
	}
	
	// Associated ModuleBuilder
	protected ModuleBuilder module;
	
	// Type ID
	public int TypeID, InterfaceID;

	// Base type
	public int BaseType;
	
	// List of implemented Interfaces
	public System.Collections.ArrayList Interfaces;
	
	public String name;
		// Dotnet name of current class.

	public String eiffel_name;
		// Name of current class as seen in Eiffel.
	
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
		return( BaseType != COMPILER.NoValue );
	}
	
	// Type name of ARRAY Class
	public String ArrayElementName;

	// Invariant Routine
	public FEATURE InvariantRoutine;

	// Creation Routines
	public FEATURE[] CreationRoutines;

	private string source_file_name = null;
			// Location of Eiffel source file defining Current.

	// Set `FeatureID' of `FeatureIDTable' to be invariant
	// routine.
	public void SetInvariant (int FeatureID)
	{
		InvariantRoutine = (FEATURE) FeatureIDTable [FeatureID];
		InvariantRoutine.set_is_invariant (true);
	}

	// Assign all routine with `FeatureIDs' to be creation routine
	// of Current class.
	public void SetCreationRoutines (int[] FeatureIDs)
	{
		CreationRoutines = new FEATURE [FeatureIDs.Length];
		int nb = FeatureIDs.Length;

		for (int i = 0; i < nb; i++) {
			CreationRoutines [i] = (FEATURE) FeatureIDTable [FeatureIDs [i]];
			CreationRoutines [i].set_is_creation_routine (true);
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
	// value: FEATURE
	public System.Collections.Hashtable FeatureIDTable;

	// Methods
	// key: RoutineID
	// value: FEATURE
	public System.Collections.Hashtable StaticFeatureIDTable;

	// Default Constructor for Eiffel objects
	protected ConstructorInfo InternalDefaultConstructor;
	public ConstructorInfo DefaultConstructor {
		get {
			if
				((InternalDefaultConstructor == null) &&
				COMPILER.Classes [TypeID].IsExternal &&
				!COMPILER.Classes [TypeID].IsArray)
			{
				COMPILER.Classes [TypeID].SetDefaultConstructor (
					COMPILER.Classes [TypeID].Builder.GetConstructor (
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
					"and an interface or deferred (" + eiffel_name + ")" );
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
	
	// Set `name' with `class_name'
	public void set_name (String class_name)
	{
	  	#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "set_name: Type Builder already created" );
		#endif
		name = class_name;
	}

	// Set `eiffel_name' with `class_name'
	public void set_eiffel_name (String class_name)
	{
	  	#if ASSERTIONS
			if (TypeBuilderCreated)
				throw new ApplicationException( "set_eiffel_name: Type Builder already created" );
		#endif
		eiffel_name = class_name;
	}

	// Add Class with TypeID `ID' to list of parents
	public void AddParent( int ID )
	{
		#if ASSERTIONS
			if( TypeBuilderCreated )
				throw new ApplicationException( "AddParent: Type Builder already created" );
		#endif
		if (COMPILER.Classes [ID].IsInterface) {
			Interfaces.Add (ID);
		} else {
			#if ASSERTIONS
				if( BaseType != COMPILER.NoValue )
					throw new ApplicationException( "AddParent: Class " + eiffel_name +
						" already has a base type (" + COMPILER.Classes [BaseType].Builder +")");
				if( IsInterface )
					throw new ApplicationException( "AddParent: Class " + eiffel_name + " is an interface." );
			#endif
			BaseType = ID;
		}
	}

	public void set_implementation_class ()
		// Set current to be an implementation class.
	{
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
			LocalInterfaces [Interfaces.Count] = COMPILER.ISE_EiffelInterface;
		} else {
			LocalInterfaces = new Type [Interfaces.Count];
		}
		for( i = 0; i < Interfaces.Count; i++ )
			LocalInterfaces [i] = COMPILER.Classes [( int )Interfaces [i]].Builder;
		if( BaseType != COMPILER.NoValue )
			ParentType = COMPILER.Classes [BaseType].Builder;
		else
			ParentType = COMPILER.ObjectType;
		if( IsDeferred && !IsInterface )
		{
			Builder = module.DefineType( name, TypeAttributes.Public | TypeAttributes.Abstract, ParentType, LocalInterfaces );
			DefineDefaultConstructor();
		}
		else
		{
			if( IsInterface )
					Builder = module.DefineType( name, TypeAttributes.Public | TypeAttributes.Interface | TypeAttributes.Abstract, null,  LocalInterfaces );
			else
				{
					if( IsExpanded )
						Builder = module.DefineType( name, TypeAttributes.Public, ParentType, LocalInterfaces );
					else
					{
						Builder = module.DefineType( name, TypeAttributes.Public | TypeAttributes.Class, ParentType, LocalInterfaces );
						DefineDefaultConstructor();
					}
				}
		}

		if (IsImplementation) {
				// Add ____type and ____set_type feature
			TypeBuilder builder = (TypeBuilder) Builder;
			MethodBuilder set_type, class_name;
			MethodBuilder method;
			FieldBuilder attribute;
			Type type = COMPILER.Ise_eiffel_derivation_type;
			ILGenerator MethodIL;

				// Define storage of type information
			attribute = builder.DefineField ("$$____type", type, FieldAttributes.Family);

				// Implement `____type' to access type info.
			method = builder.DefineMethod (
				"____type",
				MethodAttributes.Family | MethodAttributes.Virtual | MethodAttributes.Final |
					MethodAttributes.Public,
				type, Type.EmptyTypes);

			MethodIL = method.GetILGenerator();
			MethodIL.Emit (OpCodes.Ldarg_0);
			MethodIL.Emit (OpCodes.Ldfld, attribute);
			MethodIL.Emit (OpCodes.Ret);

				// Implement `____set_type'.
			set_type = builder.DefineMethod (
				"____set_type",
				MethodAttributes.Family | MethodAttributes.Virtual | MethodAttributes.Final |
					MethodAttributes.Public,
				COMPILER.VoidType,
				new Type [1] {type});

			MethodIL = set_type.GetILGenerator();
			MethodIL.Emit (OpCodes.Ldarg_0);
			MethodIL.Emit (OpCodes.Ldarg_1);
			MethodIL.Emit (OpCodes.Stfld, attribute);
			MethodIL.Emit (OpCodes.Ret);

				// Implement `____class_name'.
			class_name = builder.DefineMethod (
				"____class_name",
				MethodAttributes.Family | MethodAttributes.Virtual | MethodAttributes.Final |
					MethodAttributes.Public,
				typeof (String),
				Type.EmptyTypes);

			MethodIL = class_name.GetILGenerator();
			MethodIL.Emit (OpCodes.Ldstr, eiffel_name);
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
		CLASS parent_class;

		if (BaseType != COMPILER.NoValue)
			parent_class = COMPILER.Classes [BaseType];
		else
			parent_class = null;

		if
			((BaseType == COMPILER.NoValue) ||
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

} // end of CLASS

} // end of namespace
