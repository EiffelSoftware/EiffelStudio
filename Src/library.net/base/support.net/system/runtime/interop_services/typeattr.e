indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.TYPEATTR"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	TYPEATTR

inherit
	VALUE_TYPE

feature -- Access

	frozen w_major_ver_num: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"wMajorVerNum"
		end

	frozen c_impl_types: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cImplTypes"
		end

	frozen memid_destructor: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"memidDestructor"
		end

	frozen cb_size_instance: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cbSizeInstance"
		end

	frozen member_id_nil: INTEGER is 0xffffffff

	frozen typekind: TYPEKIND is
		external
			"IL field signature :System.Runtime.InteropServices.TYPEKIND use System.Runtime.InteropServices.TYPEATTR"
		alias
			"typekind"
		end

	frozen c_funcs: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cFuncs"
		end

	frozen memid_constructor: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"memidConstructor"
		end

	frozen w_minor_ver_num: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"wMinorVerNum"
		end

	frozen w_type_flags: TYPEFLAGS is
		external
			"IL field signature :System.Runtime.InteropServices.TYPEFLAGS use System.Runtime.InteropServices.TYPEATTR"
		alias
			"wTypeFlags"
		end

	frozen tdesc_alias: TYPEDESC is
		external
			"IL field signature :System.Runtime.InteropServices.TYPEDESC use System.Runtime.InteropServices.TYPEATTR"
		alias
			"tdescAlias"
		end

	frozen cb_size_vft: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cbSizeVft"
		end

	frozen guid: GUID is
		external
			"IL field signature :System.Guid use System.Runtime.InteropServices.TYPEATTR"
		alias
			"guid"
		end

	frozen lpstr_schema: POINTER is
		external
			"IL field signature :System.IntPtr use System.Runtime.InteropServices.TYPEATTR"
		alias
			"lpstrSchema"
		end

	frozen dw_reserved: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"dwReserved"
		end

	frozen c_vars: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cVars"
		end

	frozen lcid: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"lcid"
		end

	frozen idldesc_type: IDLDESC is
		external
			"IL field signature :System.Runtime.InteropServices.IDLDESC use System.Runtime.InteropServices.TYPEATTR"
		alias
			"idldescType"
		end

	frozen cb_alignment: INTEGER_16 is
		external
			"IL field signature :System.Int16 use System.Runtime.InteropServices.TYPEATTR"
		alias
			"cbAlignment"
		end

end -- class TYPEATTR
