indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.CompilerServices.RuntimeHelpers"

frozen external class
	SYSTEM_RUNTIME_COMPILERSERVICES_RUNTIMEHELPERS

create {NONE}

feature -- Access

	frozen get_offset_to_string_data: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"get_OffsetToStringData"
		end

feature -- Basic Operations

	frozen run_class_constructor (type: SYSTEM_RUNTIMETYPEHANDLE) is
		external
			"IL static signature (System.RuntimeTypeHandle): System.Void use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"RunClassConstructor"
		end

	frozen initialize_array (array: SYSTEM_ARRAY; fldHandle: SYSTEM_RUNTIMEFIELDHANDLE) is
		external
			"IL static signature (System.Array, System.RuntimeFieldHandle): System.Void use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"InitializeArray"
		end

	frozen get_object_value (obj: ANY): ANY is
		external
			"IL static signature (System.Object): System.Object use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"GetObjectValue"
		end

end -- class SYSTEM_RUNTIME_COMPILERSERVICES_RUNTIMEHELPERS
