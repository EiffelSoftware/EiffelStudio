indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.RuntimeHelpers"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	RUNTIME_HELPERS

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_offset_to_string_data: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"get_OffsetToStringData"
		end

feature -- Basic Operations

	frozen initialize_array (array: SYSTEM_ARRAY; fld_handle: RUNTIME_FIELD_HANDLE) is
		external
			"IL static signature (System.Array, System.RuntimeFieldHandle): System.Void use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"InitializeArray"
		end

	frozen get_object_value (obj: SYSTEM_OBJECT): SYSTEM_OBJECT is
		external
			"IL static signature (System.Object): System.Object use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"GetObjectValue"
		end

	frozen run_class_constructor (type: RUNTIME_TYPE_HANDLE) is
		external
			"IL static signature (System.RuntimeTypeHandle): System.Void use System.Runtime.CompilerServices.RuntimeHelpers"
		alias
			"RunClassConstructor"
		end

end -- class RUNTIME_HELPERS
