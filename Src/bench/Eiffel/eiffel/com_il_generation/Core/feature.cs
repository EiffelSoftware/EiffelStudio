/*
indexing
	description: "Abstract representation of an Eiffel routine that will be generated
		in either an interface or a class. Goal is to create a XXBuilder where XX represents
		either an attribute or a routine. And if it is an attribute, we automatically have
		its `setter_builder' needed to set the attribute value. To create the XXBuilder
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

namespace ISE.Compiler {

internal class FEATURE
{
	public FEATURE( int ID, int arg_count) {
		argument_count = arg_count;
		parameter_type_ids = new int [arg_count];
		return_type_id = COMPILER.NoValue;
		info = new FEATURE_INFO(arg_count);
	}

	// Feature information
	private FEATURE_INFO info;

	// Parameter TypeIDs
	public int[] parameter_type_ids;

	// Number of argument of current routine
	public int argument_count;

	// Final name of method
	public string name () {
		if (info == null)
			return method_builder.Name;
		else
			return info.name ();
	}

	// Is feature an attribute?
	public bool is_attribute;
	
	// Is feature a C external one?
	public bool is_c_external;
	
	// Is feature a creation routine?
	public bool is_creation_routine;

	// Return Type identifier in class
	public int return_type_id;

	// Associated Method builder to a routine
	internal MethodInfo method_builder;

	// Associated attribute builder
	// Can be a FieldBuilder or a FieldInfo
	public FieldInfo attribute_builder;
	internal MethodBuilder setter_builder;


#if ASSERTIONS
	// Was `create_method_builder' called?
	private bool is_method_builder_created;
#endif
	
	// Set `RealName' with `FeatureName'.
	public void set_real_name( string FeatureName ) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "set_real_name: Method builder already created" );
		#endif
		info.set_real_name (FeatureName);
	}

	// Set `EiffelName' with `FeatureName'.
	public void set_eiffel_name( string FeatureName ) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "set_eiffel_name: Method builder already created" );
		#endif
		info.set_eiffel_name (FeatureName);
	}

	// Set `FeatureID' with `ID'.
	public void set_feature_id ( int ID ) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "set_feature_id: Method builder already created" );
		#endif
		info.set_feature_id (ID);
	}

	// Set `IsInterfaceRoutine' with `ID'.
	public void set_is_interface_routine (bool val) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "set_is_interface_routine: Method builder " +
					"already created" );
		#endif
		info.set_is_interface_routine (val);
	}

	// Set `return_type_id' with `TypeID'.
	public void set_return_type_id (int TypeID) {
		return_type_id = TypeID;
	}

	// Add a new argument to method
	public void add_argument (string a_name, int TypeID ,int pos) {
		info.parameter_names [pos] = a_name;
		parameter_type_ids [pos] = TypeID;
	}

	// Set `IsDeferred' with `val'.
	public void set_is_deferred (bool val) {
	  	#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "SetDeferred: Method builder already created" );
			if( info.is_frozen )
				throw new ApplicationException( "SetDeferred: Frozen feature cannot be deferred" );
		#endif
		info.set_is_deferred (val);
	}

	// Set `IsRedefined' with `val'.
	public void set_is_redefined (bool val) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "SetRedefined: Method builder already created" );
		#endif
		info.set_is_redefined (val);
	}
	
	// Set `IsFrozen' with `val'.
	public void set_is_frozen (bool val) {
		#if ASSERTIONS
			if( is_method_builder_created )
				throw new ApplicationException( "SetFrozen: Method builder already created" );
			if( info.is_deferred )
				throw new ApplicationException( "SetFrozen: Deferred feature cannot be frozen" );
		#endif
		info.set_is_frozen (val);
	}

	// Set `is_invariant' with `val'.
	public void set_is_invariant (bool val) {
		info.set_is_invariant (val);
	}

	// Set `is_creation_routine' with `val'.
	public void set_is_creation_routine (bool val) {
		is_creation_routine = val;
	}
	
	// Set `is_attribute' with `val'.
	public void set_is_attribute (bool val) {
		is_attribute = val;
	}

	// Set `is_static' with `val'.
	public void set_is_static (bool val) {
		info.set_is_static (val);
	}

	// Set `is_c_external' with `val'.
	public void set_is_c_external (bool val) {
		is_c_external = val;
	}

	// Set `method_builder' with `methodBuilder'
	// Used for external features
	public void set_method_builder (MethodInfo a_method) {
		method_builder = a_method;
		#if ASSERTIONS
			is_method_builder_created = true;
		#endif
	}
	
	// Set `attribute_builder' with `fieldBuilder'
	// Used for external features
	public void set_attribute_builder( FieldInfo fieldBuilder ) {
		attribute_builder = fieldBuilder;
		#if ASSERTIONS
			is_method_builder_created = true;
		#endif
	}
	
	// Create associated method builder
	public void create_method_builder () {
		MethodAttributes Attributes;
		CLASS current_class = COMPILER.Classes [COMPILER.CurrentTypeID];
		Type[] ParameterTypes;
		Type return_type;
		string att_name	= name();
		int i, nb, start_index;
		bool is_static = info.is_static;
		bool needs_attribute = is_attribute && current_class.IsFrozen;
		
		#if ASSERTIONS
			if( is_method_builder_created && !(is_attribute && info.is_redefined))
				throw new ApplicationException( "create_method_builder: Already done" );
			if( info.feature_id == COMPILER.NoValue )
				throw new ApplicationException( "create_method_builder: No Feature ID" );
		#endif

		nb = argument_count;
		if( info.is_invariant ) {
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

			if (is_static && !is_c_external)
				nb = nb + 1;
			ParameterTypes = new Type [nb];

			if (is_static) {
				if (!is_c_external) {
					ParameterTypes [0] = COMPILER.Classes
						[current_class.InterfaceID].Builder;
					start_index = 1;
				} else {
					start_index = 0;
				}
				for(i = start_index; i < nb; i++ )
					ParameterTypes [i] = COMPILER.Classes
						[parameter_type_ids [i - start_index]].Builder;
			} else {
				for(i = 0; i < nb; i++ )
					ParameterTypes [i] = COMPILER.Classes
						[parameter_type_ids [i]].Builder;
			}
		}

		if
			((is_attribute && !info.is_interface_routine && is_static) ||
			(needs_attribute))
		{
			attribute_builder = ((TypeBuilder) current_class.Builder)
				.DefineField( att_name, COMPILER.Classes [return_type_id].Builder,
							  FieldAttributes.Public );
		} else {
			if (return_type_id == COMPILER.NoValue)
				return_type = COMPILER.VoidType;
			else
				return_type = COMPILER.Classes [return_type_id].Builder;

			if (is_c_external && is_static) {
				method_builder = ((TypeBuilder) current_class.Builder).
					DefinePInvokeMethod( name(),
					COMPILER.dll_name, Attributes,
					CallingConventions.Standard, return_type, ParameterTypes,
					CallingConvention.Cdecl, CharSet.Ansi);
				((MethodBuilder) method_builder).SetImplementationFlags (MethodImplAttributes.PreserveSig);
			} else {
//				if ((!info.is_interface_routine) && (!is_static || info.is_deferred))
//					Attributes = Attributes | MethodAttributes.NewSlot;
				method_builder =((TypeBuilder) current_class.Builder ).
					DefineMethod( name(), Attributes, return_type, ParameterTypes );
			}

			if (info.is_invariant) {
				(( MethodBuilder )method_builder ).DefineParameter ( 1,
					ParameterAttributes.In, "Current_object");
			} else {
				if (is_static) {
					if (!is_c_external) {
						((MethodBuilder) method_builder).DefineParameter( 1,
							ParameterAttributes.In, "Current");
						start_index = 1;
					} else {
						start_index = 0;
					}
					for( i = start_index; i < nb; i++ )
						(( MethodBuilder )method_builder ).DefineParameter( i + 1,
							ParameterAttributes.In, info.parameter_names [i - start_index]);
				} else {
					for( i = 0; i < nb; i++ )
						(( MethodBuilder )method_builder ).DefineParameter( i + 1,
							ParameterAttributes.In, info.parameter_names [i]);
				}
				(( MethodBuilder )method_builder ).InitLocals = true;
			}

		}

		if (is_attribute && !is_static && !needs_attribute) {
			return_type = COMPILER.Classes [return_type_id].Builder;
			setter_builder = ((TypeBuilder) current_class.Builder).
				DefineMethod (COMPILER.SetterPrefix + name(),
				Attributes | MethodAttributes.Family, COMPILER.VoidType,
				new Type [1] {return_type} );
			setter_builder.DefineParameter (1, ParameterAttributes.In, name ());
		}

		if
			(COMPILER.is_debugging_enabled &&
			!info.is_interface_routine && !info.is_static)
		{
			((MethodBuilder) method_builder).SetCustomAttribute (debugger_step_through_attr ());
			((MethodBuilder) method_builder).SetCustomAttribute (debugger_hidden_attr ());
		}
		if( method_builder == null && attribute_builder == null ) {
			throw new ApplicationException (
				"create_method_builder: method_builder null after call for " + name());
		}

		#if ASSERTIONS
			is_method_builder_created = true;
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

} // end of FEATURE

} // end of namespace 
