indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMITypeLib"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMITYPE_LIB

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_type_comp (pp_tcomp: UCOMITYPE_COMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeComp"
		end

	get_type_info_of_guid (guid: GUID; pp_tinfo: UCOMITYPE_INFO) is
		external
			"IL deferred signature (System.Guid&, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoOfGuid"
		end

	get_type_info (index: INTEGER; pp_ti: UCOMITYPE_INFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfo"
		end

	find_name (sz_name_buf: SYSTEM_STRING; l_hash_val: INTEGER; pp_tinfo: NATIVE_ARRAY [UCOMITYPE_INFO]; rg_mem_id: NATIVE_ARRAY [INTEGER]; pc_found: INTEGER_16) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo[], System.Int32[], System.Int16&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"FindName"
		end

	get_lib_attr (pp_tlib_attr: POINTER) is
		external
			"IL deferred signature (System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetLibAttr"
		end

	get_type_info_type (index: INTEGER; p_tkind: TYPEKIND) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.TYPEKIND&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoType"
		end

	release_tlib_attr (p_tlib_attr: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"ReleaseTLibAttr"
		end

	get_type_info_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoCount"
		end

	is_name (sz_name_buf: SYSTEM_STRING; l_hash_val: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Int32): System.Boolean use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"IsName"
		end

	get_documentation (index: INTEGER; str_name: SYSTEM_STRING; str_doc_string: SYSTEM_STRING; dw_help_context: INTEGER; str_help_file: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Int32, System.String&, System.String&, System.Int32&, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetDocumentation"
		end

end -- class UCOMITYPE_LIB
