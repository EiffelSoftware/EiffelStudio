using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.InteropServices;

internal class EiffelMethod
{
	// Set `ParentTypeId' with `TypeID'.
	public EiffelMethod( int ID, int arg_count) {
		TypeID = ID;
		MethodBuilderCreated = false;
		ParameterNames = new string [arg_count];
		ParameterTypeIDs = new int [arg_count];
		FeatureID = EiffelReflectionEmit.NoValue;
		ReturnTypeID = EiffelReflectionEmit.NoValue;
		IsAttribute = false;
		IsDeferred = false;
		IsRedefined = false;
	}

	// TypeID of containing class
	protected int TypeID;
	
	// .NET Name if any
	public string RealName;

	// Eiffel Name always set
	public string EiffelName;

	// Final name of method
	public string Name() {
		if (RealName == null)
			return EiffelName;
		else
			return RealName;
	}

	// Is feature deferred?
	public bool IsDeferred;
	
	// Is feature redefined/implemented from parent?
	public bool IsRedefined;

	// Is feature an attribute?
	public bool IsAttribute;
	
	// Is feature a static?
	public bool IsStatic;

	// Is feature a C external one?
	public bool Is_C_External;
	
	// Is feature frozen?
	public bool IsFrozen;

	// Is feature an invariant?
	public bool IsInvariant;

	// Is feature a creation routine?
	public bool IsCreationRoutine;

	// Return Type identifier in class
	public int ReturnTypeID;
	
	// Feature identifier in class
	public int FeatureID;

	// Belongs to interface
	public bool IsInterfaceRoutine;
	
	// Associated Method builder to a routine
	internal MethodBase Builder;
	internal MethodBuilder SetterBuilder;

	// Associated constructor method builder
	// Can be a MethodBuilder or a MethodInfo
	private MethodBase InternalConstructorBuilder;
	public MethodBase ConstructorBuilder {
		get {
			return InternalConstructorBuilder;
		}
	}

	// Associated attribute builder
	// Can be a FieldBuilder or a FieldInfo
	public FieldInfo AttributeBuilder;

	// Parameter Names
	public string[] ParameterNames;
	
	// Parameter TypeIDs
	public int[] ParameterTypeIDs;

	// Set `RealName' with `FeatureName'.
	public void SetRealName( string FeatureName ) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetRealName: Method builder already created" );
		#endif
		RealName = FeatureName;
	}

	// Set `EiffelName' with `FeatureName'.
	public void SetEiffelName( string FeatureName ) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetEiffelName: Method builder already created" );
		#endif
		EiffelName = FeatureName;
	}

	// Set `FeatureID' with `ID'.
	public void SetFeatureID( int ID ) {
		#if ÆSSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetFeatureID: Method builder already created" );
		#endif
		FeatureID = ID;
	}

	// Set `IsInterfaceRoutine' with `ID'.
	public void SetIsInterfaceRoutine (bool val) {
		#if ÆSSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetIsInterfaceRoutine: Method builder " +
					"already created" );
		#endif
		IsInterfaceRoutine = val;
	}

	// Set `ReturnTypeID' with `TypeID'.
	public void SetReturnType( int TypeID ) {
		ReturnTypeID = TypeID;
	}

	// Add a new argument to method
	public void AddArgument( string a_name, int TypeID ,int pos) {
		ParameterNames [pos] = a_name;
		ParameterTypeIDs [pos] = TypeID;
	}

	// Set `IsDeferred' with `val'.
	public void SetIsDeferred (bool val) {
	  	#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetDeferred: Method builder already created" );
			if( IsFrozen )
				throw new ApplicationException( "SetDeferred: Frozen feature cannot be deferred" );
		#endif
		IsDeferred = val;
	}

	// Set `IsRedefined' with `val'.
	public void SetIsRedefined (bool val) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetRedefined: Method builder already created" );
		#endif
		IsRedefined = val;
	}
	
	public void SetIsFrozen (bool val) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetFrozen: Method builder already created" );
			if( IsDeferred )
				throw new ApplicationException( "SetFrozen: Deferred feature cannot be frozen" );
		#endif
		IsFrozen = val;
	}

	// Set `IsInvariant' with `val'.
	public void SetIsInvariant (bool val) {
		IsInvariant = val;
	}

	// Set `IsCreationRoutine' with `val'.
	public void SetIsCreationRoutine (bool val) {
		IsCreationRoutine = val;
		CreateConstructorBuilder();
	}
	
	// Set `IsAttribute' with `val'.
	public void SetIsAttribute (bool val) {
		IsAttribute = val;
	}

	// Set `IsStatic' with `val'.
	public void SetIsStatic (bool val) {
		IsStatic = val;
	}

	// Set `Is_C_External' with `val'.
	public void SetIs_C_External (bool val) {
		Is_C_External = val;
	}

	// Set `Builder' with `methodBuilder'
	// Used for external features
	public void SetMethodBuilder (MethodBase methodBuilder) {
		Builder = methodBuilder;
		MethodBuilderCreated = true;
	}
	
	// Set `AttributeBuilder' with `fieldBuilder'
	// Used for external features
	public void SetAttributeBuilder( FieldInfo fieldBuilder ) {
		AttributeBuilder = fieldBuilder;
		MethodBuilderCreated = true;
	}
	
	// Create associated method builder
	public void CreateMethodBuilder() {
		MethodAttributes Attributes;
		EiffelClass current_class = EiffelReflectionEmit.Classes [TypeID];
		Type[] ParameterTypes;
		Type return_type;
		string att_name	= Name();
		int i, nb, start_index;
		bool is_static = IsStatic;
		bool needs_attribute = IsAttribute && current_class.IsFrozen;
		
#if ASSERTIONS
		if( MethodBuilderCreated && !(IsAttribute && IsRedefined))
			throw new ApplicationException( "CreateMethodBuilder: Already done" );
		if( FeatureID == EiffelReflectionEmit.NoValue )
			throw new ApplicationException( "CreateMethodBuilder: No Feature ID" );
#endif

		nb = ParameterTypeIDs.Length;
		if( IsInvariant ) {
			Attributes = MethodAttributes.Static | MethodAttributes.Public;
			ParameterTypes = new Type[1];
			ParameterTypes [0] = current_class.Builder;
		} else {
			if (IsFrozen)
				Attributes = MethodAttributes.Final;

			if (is_static && !IsDeferred)
				Attributes = MethodAttributes.Static;
			else
				Attributes = MethodAttributes.Virtual;

			Attributes = Attributes | MethodAttributes.Public;

			if (IsDeferred)
				Attributes = Attributes | MethodAttributes.Abstract;

			if (is_static && !Is_C_External)
				nb = nb + 1;
			ParameterTypes = new Type [nb];

			if (is_static) {
				if (!Is_C_External) {
					ParameterTypes [0] = EiffelReflectionEmit.Classes
						[current_class.InterfaceID].Builder;
					start_index = 1;
				} else {
					start_index = 0;
				}
				for(i = start_index; i < nb; i++ )
					ParameterTypes [i] = EiffelReflectionEmit.Classes
						[ParameterTypeIDs [i - start_index]].Builder;
			} else {
				for(i = 0; i < nb; i++ )
					ParameterTypes [i] = EiffelReflectionEmit.Classes
						[ParameterTypeIDs [i]].Builder;
			}
		}

		if
			((IsAttribute && !IsInterfaceRoutine && is_static) ||
			(needs_attribute))
		{
			AttributeBuilder = ((TypeBuilder) current_class.Builder)
				.DefineField( att_name, EiffelReflectionEmit.Classes [ReturnTypeID].Builder,
							  FieldAttributes.Public );
		} else {
			if (ReturnTypeID == EiffelReflectionEmit.NoValue)
				return_type = EiffelReflectionEmit.VoidType;
			else
				return_type = EiffelReflectionEmit.Classes [ReturnTypeID].Builder;

			if (Is_C_External && is_static) {
				Builder = ((TypeBuilder) current_class.Builder).
					DefinePInvokeMethod( Name(), "Project.dll", Attributes,
					CallingConventions.Standard, return_type, ParameterTypes,
					CallingConvention.Cdecl, CharSet.Ansi);
			} else {
//				if ((!IsInterfaceRoutine) && (!is_static || IsDeferred))
//					Attributes = Attributes | MethodAttributes.NewSlot;
				Builder =((TypeBuilder) current_class.Builder ).
					DefineMethod( Name(), Attributes, return_type, ParameterTypes );
			}

			if (IsInvariant) {
				(( MethodBuilder )Builder ).DefineParameter ( 1,
					ParameterAttributes.In, "Current_object");
			} else {
				if (is_static) {
					if (!Is_C_External) {
						((MethodBuilder) Builder).DefineParameter( 1,
							ParameterAttributes.In, "Current");
						start_index = 1;
					} else {
						start_index = 0;
					}
					for( i = start_index; i < nb; i++ )
						(( MethodBuilder )Builder ).DefineParameter( i + 1,
							ParameterAttributes.In, ParameterNames [i - start_index]);
				} else {
					for( i = 0; i < nb; i++ )
						(( MethodBuilder )Builder ).DefineParameter( i + 1,
							ParameterAttributes.In, ParameterNames [i]);
				}
				(( MethodBuilder )Builder ).InitLocals = true;
			}

		}

		if (IsAttribute && !is_static && !needs_attribute) {
			return_type = EiffelReflectionEmit.Classes [ReturnTypeID].Builder;
			SetterBuilder = ((TypeBuilder) current_class.Builder).
				DefineMethod (EiffelReflectionEmit.SetterPrefix + Name(),
				Attributes | MethodAttributes.Family, EiffelReflectionEmit.VoidType,
				new Type [1] {return_type} );
			SetterBuilder.DefineParameter (1, ParameterAttributes.In, Name ());
		}

		if( Builder == null && AttributeBuilder == null )
			throw new ApplicationException (
				"CreateMethodBuilder: Builder null after call for " + Name());
		MethodBuilderCreated = true;
	}
	
	// Create associated method builder
	public void CreateConstructorBuilder() {
		MethodAttributes Attributes;
		Type[] ParameterTypes;
		int i;
		
		Attributes = MethodAttributes.Final | MethodAttributes.Public
			| MethodAttributes.RTSpecialName | MethodAttributes.SpecialName ;

		ParameterTypes = new Type[ ParameterTypeIDs.Length ];
		for(i = 0; i < ParameterTypeIDs.Length; i++ )
			ParameterTypes [i] = EiffelReflectionEmit.Classes [ParameterTypeIDs [i]].Builder;

		InternalConstructorBuilder =(( TypeBuilder )EiffelReflectionEmit.Classes [TypeID].Builder ).
			DefineMethod( Name(), Attributes, EiffelReflectionEmit.VoidType, ParameterTypes );
		for( i = 0; i < ParameterNames.Length; i++ )
			(( MethodBuilder )InternalConstructorBuilder ).DefineParameter
				( i + 1, ParameterAttributes.In, ParameterNames [i]);
		(( MethodBuilder )InternalConstructorBuilder ).InitLocals = true;
		
		if( InternalConstructorBuilder == null)
			throw new ApplicationException (
				"CreateMethodBuilder: Builder null after call for " + Name());
	}
	
	// Was `CreateMethodBuilder' called?
	protected bool MethodBuilderCreated;
	
}
