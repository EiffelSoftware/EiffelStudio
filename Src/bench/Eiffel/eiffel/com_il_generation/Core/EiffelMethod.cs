/*
indexing
	description: "Abstract representation of an Eiffel routine that will be generated
		in either an interface or a class. Goal is to create a XXBuilder where XX represents
		either an attribute or a routine. And if it is an attribute, we automatically have
		its `SetterBuilder' needed to set the attribute value. To create the XXBuilder
		we need some info stored in `info' and once it is created `info' is set to
		Void and thus saving us a lot of space in memory during the code generation".
	date: "$Date$"
	revision: "$Revision$"
*/

using System;
using System.IO;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.InteropServices;

internal class EiffelMethod
{
	public EiffelMethod( int ID, int arg_count) {
		argument_count = arg_count;
		parameter_type_ids = new int [arg_count];
		ReturnTypeID = EiffelReflectionEmit.NoValue;
		info = new FEATURE_INFO(arg_count);
	}

	// Feature information
	private FEATURE_INFO info;

	// Parameter TypeIDs
	public int[] parameter_type_ids;

	// Number of argument of current routine
	public int argument_count;

	// Final name of method
	public string Name() {
		if (info == null)
			return Builder.Name;
		else
			return info.name ();
	}

	// Is feature an attribute?
	public bool IsAttribute;
	
	// Is feature a C external one?
	public bool Is_C_External;
	
	// Is feature a creation routine?
	public bool IsCreationRoutine;

	// Return Type identifier in class
	public int ReturnTypeID;

	// Associated Method builder to a routine
	internal MethodInfo Builder;
	internal MethodBuilder SetterBuilder;

	// Associated attribute builder
	// Can be a FieldBuilder or a FieldInfo
	public FieldInfo AttributeBuilder;


#if ASSERTIONS
	// Was `CreateMethodBuilder' called?
	private bool MethodBuilderCreated;
#endif
	
	// Set `RealName' with `FeatureName'.
	public void SetRealName( string FeatureName ) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetRealName: Method builder already created" );
		#endif
		info.set_real_name (FeatureName);
	}

	// Set `EiffelName' with `FeatureName'.
	public void SetEiffelName( string FeatureName ) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetEiffelName: Method builder already created" );
		#endif
		info.set_eiffel_name (FeatureName);
	}

	// Set `FeatureID' with `ID'.
	public void SetFeatureID( int ID ) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetFeatureID: Method builder already created" );
		#endif
		info.set_feature_id (ID);
	}

	// Set `IsInterfaceRoutine' with `ID'.
	public void SetIsInterfaceRoutine (bool val) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetIsInterfaceRoutine: Method builder " +
					"already created" );
		#endif
		info.set_is_interface_routine (val);
	}

	// Set `ReturnTypeID' with `TypeID'.
	public void SetReturnType( int TypeID ) {
		ReturnTypeID = TypeID;
	}

	// Add a new argument to method
	public void AddArgument( string a_name, int TypeID ,int pos) {
		info.parameter_names [pos] = a_name;
		parameter_type_ids [pos] = TypeID;
	}

	// Set `IsDeferred' with `val'.
	public void SetIsDeferred (bool val) {
	  	#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetDeferred: Method builder already created" );
			if( info.is_frozen )
				throw new ApplicationException( "SetDeferred: Frozen feature cannot be deferred" );
		#endif
		info.set_is_deferred (val);
	}

	// Set `IsRedefined' with `val'.
	public void SetIsRedefined (bool val) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetRedefined: Method builder already created" );
		#endif
		info.set_is_redefined (val);
	}
	
	// Set `IsFrozen' with `val'.
	public void SetIsFrozen (bool val) {
		#if ASSERTIONS
			if( MethodBuilderCreated )
				throw new ApplicationException( "SetFrozen: Method builder already created" );
			if( info.is_deferred )
				throw new ApplicationException( "SetFrozen: Deferred feature cannot be frozen" );
		#endif
		info.set_is_frozen (val);
	}

	// Set `IsInvariant' with `val'.
	public void SetIsInvariant (bool val) {
		info.SetIsInvariant (val);
	}

	// Set `IsCreationRoutine' with `val'.
	public void SetIsCreationRoutine (bool val) {
		IsCreationRoutine = val;
	}
	
	// Set `IsAttribute' with `val'.
	public void SetIsAttribute (bool val) {
		IsAttribute = val;
	}

	// Set `IsStatic' with `val'.
	public void SetIsStatic (bool val) {
		info.set_is_static (val);
	}

	// Set `Is_C_External' with `val'.
	public void SetIs_C_External (bool val) {
		Is_C_External = val;
	}

	// Set `Builder' with `methodBuilder'
	// Used for external features
	public void SetMethodBuilder (MethodInfo methodBuilder) {
		Builder = methodBuilder;
		#if ASSERTIONS
			MethodBuilderCreated = true;
		#endif
	}
	
	// Set `AttributeBuilder' with `fieldBuilder'
	// Used for external features
	public void SetAttributeBuilder( FieldInfo fieldBuilder ) {
		AttributeBuilder = fieldBuilder;
		#if ASSERTIONS
			MethodBuilderCreated = true;
		#endif
	}
	
	// Create associated method builder
	public void CreateMethodBuilder() {
		MethodAttributes Attributes;
		EiffelClass current_class = EiffelReflectionEmit.Classes [EiffelReflectionEmit.CurrentTypeID];
		Type[] ParameterTypes;
		Type return_type;
		string att_name	= Name();
		int i, nb, start_index;
		bool is_static = info.is_static;
		bool needs_attribute = IsAttribute && current_class.IsFrozen;
		
		#if ASSERTIONS
			if( MethodBuilderCreated && !(IsAttribute && info.is_redefined))
				throw new ApplicationException( "CreateMethodBuilder: Already done" );
			if( info.feature_id == EiffelReflectionEmit.NoValue )
				throw new ApplicationException( "CreateMethodBuilder: No Feature ID" );
		#endif

		nb = argument_count;
		if( info.IsInvariant ) {
			Attributes = MethodAttributes.Static | MethodAttributes.Public;
			ParameterTypes = new Type[1];
			ParameterTypes [0] = current_class.Builder;
		} else {
			if (info.is_frozen)
				Attributes = MethodAttributes.Final;

			if (is_static && !info.is_deferred)
				Attributes = MethodAttributes.Static;
			else
				Attributes = MethodAttributes.Virtual;

			Attributes = Attributes | MethodAttributes.Public;

			if (info.is_deferred)
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
						[parameter_type_ids [i - start_index]].Builder;
			} else {
				for(i = 0; i < nb; i++ )
					ParameterTypes [i] = EiffelReflectionEmit.Classes
						[parameter_type_ids [i]].Builder;
			}
		}

		if
			((IsAttribute && !info.is_interface_routine && is_static) ||
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
					DefinePInvokeMethod( Name(),
					EiffelReflectionEmit.dll_name, Attributes,
					CallingConventions.Standard, return_type, ParameterTypes,
					CallingConvention.Cdecl, CharSet.Ansi);
				((MethodBuilder) Builder).SetImplementationFlags (MethodImplAttributes.PreserveSig);
			} else {
//				if ((!info.is_interface_routine) && (!is_static || info.is_deferred))
//					Attributes = Attributes | MethodAttributes.NewSlot;
				Builder =((TypeBuilder) current_class.Builder ).
					DefineMethod( Name(), Attributes, return_type, ParameterTypes );
			}

			if (info.IsInvariant) {
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
							ParameterAttributes.In, info.parameter_names [i - start_index]);
				} else {
					for( i = 0; i < nb; i++ )
						(( MethodBuilder )Builder ).DefineParameter( i + 1,
							ParameterAttributes.In, info.parameter_names [i]);
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

		if
			(EiffelReflectionEmit.is_debugging_enabled &&
			!info.is_interface_routine && !info.is_static)
		{
			((MethodBuilder) Builder).SetCustomAttribute (debugger_step_through_attr ());		
			((MethodBuilder) Builder).SetCustomAttribute (debugger_hidden_attr ());		
		}
		if( Builder == null && AttributeBuilder == null ) {
			throw new ApplicationException (
				"CreateMethodBuilder: Builder null after call for " + Name());
		}

		#if ASSERTIONS
			MethodBuilderCreated = true;
		#endif

			// We do not need `info' anymore since the Builder(s) has(ve) been
			// created now. We thus save some space in memory.
		info = null;
	}

	// Debugger CAs to hide dummy callbacks routine
	private static CustomAttributeBuilder internal_debugger_step_through_attr;
	private static CustomAttributeBuilder internal_debugger_hidden_attr;
	private static CustomAttributeBuilder debugger_step_through_attr () {
		if (internal_debugger_step_through_attr == null) {
			Type type = Type.GetType ("System.Diagnostics.DebuggerStepThroughAttribute");
			ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
			internal_debugger_step_through_attr =
				new CustomAttributeBuilder (constructor, new object [0] {});
		}
		return internal_debugger_step_through_attr;
	}
	private static CustomAttributeBuilder debugger_hidden_attr () {
		if (internal_debugger_hidden_attr == null) {
			Type type = Type.GetType ("System.Diagnostics.DebuggerHiddenAttribute");
			ConstructorInfo constructor = type.GetConstructor (Type.EmptyTypes);
			internal_debugger_hidden_attr =
				new CustomAttributeBuilder (constructor, new object [0] {});
		}
		return internal_debugger_hidden_attr;
	}

}
