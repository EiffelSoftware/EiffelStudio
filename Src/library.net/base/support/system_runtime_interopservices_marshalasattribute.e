indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.MarshalAsAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALASATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_marshal_as_attribute,
	make_marshal_as_attribute_1

feature {NONE} -- Initialization

	frozen make_marshal_as_attribute (unmanaged_type: INTEGER) is
			-- Valid values for `unmanaged_type' are:
			-- Bool = 2
			-- I1 = 3
			-- U1 = 4
			-- I2 = 5
			-- U2 = 6
			-- I4 = 7
			-- U4 = 8
			-- I8 = 9
			-- U8 = 10
			-- R4 = 11
			-- R8 = 12
			-- Currency = 15
			-- BStr = 19
			-- LPStr = 20
			-- LPWStr = 21
			-- LPTStr = 22
			-- ByValTStr = 23
			-- IUnknown = 25
			-- IDispatch = 26
			-- Struct = 27
			-- Interface = 28
			-- SafeArray = 29
			-- ByValArray = 30
			-- SysInt = 31
			-- SysUInt = 32
			-- VBByRefStr = 34
			-- AnsiBStr = 35
			-- TBStr = 36
			-- VariantBool = 37
			-- FunctionPtr = 38
			-- AsAny = 40
			-- LPArray = 42
			-- LPStruct = 43
			-- CustomMarshaler = 44
			-- Error = 45
		require
			valid_unmanaged_type: unmanaged_type = 2 or unmanaged_type = 3 or unmanaged_type = 4 or unmanaged_type = 5 or unmanaged_type = 6 or unmanaged_type = 7 or unmanaged_type = 8 or unmanaged_type = 9 or unmanaged_type = 10 or unmanaged_type = 11 or unmanaged_type = 12 or unmanaged_type = 15 or unmanaged_type = 19 or unmanaged_type = 20 or unmanaged_type = 21 or unmanaged_type = 22 or unmanaged_type = 23 or unmanaged_type = 25 or unmanaged_type = 26 or unmanaged_type = 27 or unmanaged_type = 28 or unmanaged_type = 29 or unmanaged_type = 30 or unmanaged_type = 31 or unmanaged_type = 32 or unmanaged_type = 34 or unmanaged_type = 35 or unmanaged_type = 36 or unmanaged_type = 37 or unmanaged_type = 38 or unmanaged_type = 40 or unmanaged_type = 42 or unmanaged_type = 43 or unmanaged_type = 44 or unmanaged_type = 45
		external
			"IL creator signature (enum System.Runtime.InteropServices.UnmanagedType) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

	frozen make_marshal_as_attribute_1 (unmanagedType: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.MarshalAsAttribute"
		end

feature -- Access

	frozen size_param_index: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SizeParamIndex"
		end

	frozen array_sub_type: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"ArraySubType"
		end

	frozen size_const: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SizeConst"
		end

	frozen marshal_type: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalType"
		end

	frozen marshal_type_ref: SYSTEM_TYPE is
		external
			"IL field signature :System.Type use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalTypeRef"
		end

	frozen marshal_cookie: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"MarshalCookie"
		end

	frozen safe_array_sub_type: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.VarEnum use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"SafeArraySubType"
		end

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.UnmanagedType use System.Runtime.InteropServices.MarshalAsAttribute"
		alias
			"get_Value"
		ensure
			valid_unmanaged_type: Result = 2 or Result = 3 or Result = 4 or Result = 5 or Result = 6 or Result = 7 or Result = 8 or Result = 9 or Result = 10 or Result = 11 or Result = 12 or Result = 15 or Result = 19 or Result = 20 or Result = 21 or Result = 22 or Result = 23 or Result = 25 or Result = 26 or Result = 27 or Result = 28 or Result = 29 or Result = 30 or Result = 31 or Result = 32 or Result = 34 or Result = 35 or Result = 36 or Result = 37 or Result = 38 or Result = 40 or Result = 42 or Result = 43 or Result = 44 or Result = 45
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_MARSHALASATTRIBUTE
