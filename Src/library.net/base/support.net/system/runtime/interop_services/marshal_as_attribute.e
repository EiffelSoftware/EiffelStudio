indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.MarshalAsAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	MARSHAL_AS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_marshal_as_attribute_1,
	make_marshal_as_attribute

feature {NONE} -- Initialization

	frozen make_marshal_as_attribute_1 (unmanaged_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

	frozen make_marshal_as_attribute (unmanaged_type: UNMANAGED_TYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.UnmanagedType) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

feature -- Access

	frozen marshal_cookie: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalCookie"
		end

	frozen get_value: UNMANAGED_TYPE is
		external
			"IL signature (): System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"get_Value"
		end

	frozen safe_array_sub_type: VAR_ENUM is
		external
			"IL field signature :System.Runtime.InteropServices.VarEnum use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SafeArraySubType"
		end

	frozen safe_array_user_defined_sub_type: TYPE is
		external
			"IL field signature :System.Type use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SafeArrayUserDefinedSubType"
		end

	frozen marshal_type_ref: TYPE is
		external
			"IL field signature :System.Type use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalTypeRef"
		end

	frozen array_sub_type: UNMANAGED_TYPE is
		external
			"IL field signature :System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"ArraySubType"
		end

	frozen marshal_type: SYSTEM_STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalType"
		end

	frozen size_const: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SizeConst"
		end

	frozen size_param_index: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SizeParamIndex"
		end

end -- class MARSHAL_AS_ATTRIBUTE
