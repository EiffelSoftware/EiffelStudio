indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.MarshalAsAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALASATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_marshalasattribute,
	make_marshalasattribute_1

feature {NONE} -- Initialization

	frozen make_marshalasattribute (unmanaged_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.UnmanagedType) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

	frozen make_marshalasattribute_1 (unmanaged_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

feature -- Access

	frozen marshal_cookie: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalCookie"
		end

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE is
		external
			"IL signature (): System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"get_Value"
		end

	frozen safe_array_sub_type: SYSTEM_RUNTIME_INTEROPSERVICES_VARENUM is
		external
			"IL field signature :System.Runtime.InteropServices.VarEnum use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SafeArraySubType"
		end

	frozen marshal_type_ref: SYSTEM_TYPE is
		external
			"IL field signature :System.Type use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalTypeRef"
		end

	frozen array_sub_type: SYSTEM_RUNTIME_INTEROPSERVICES_UNMANAGEDTYPE is
		external
			"IL field signature :System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"ArraySubType"
		end

	frozen marshal_type: STRING is
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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALASATTRIBUTE
