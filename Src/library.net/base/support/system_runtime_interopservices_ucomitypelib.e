indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMITypeLib"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_type_comp (pp_tcomp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeComp"
		end

	get_type_info_of_guid (guid: SYSTEM_GUID; pp_tinfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Guid&, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoOfGuid"
		end

	get_type_info (index: INTEGER; pp_ti: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfo"
		end

	find_name (sz_name_buf: STRING; l_hash_val: INTEGER; pp_tinfo: ARRAY [SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO]; rg_mem_id: INTEGER; pc_found: INTEGER_16) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo[], System.Int32, System.Int16&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"FindName"
		end

	get_lib_attr (pp_tlib_attr: POINTER) is
		external
			"IL deferred signature (System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetLibAttr"
		end

	get_type_info_type (index: INTEGER; p_tkind: SYSTEM_RUNTIME_INTEROPSERVICES_TYPEKIND) is
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

	is_name (sz_name_buf: STRING; l_hash_val: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Int32): System.Boolean use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"IsName"
		end

	get_documentation (index: INTEGER; str_name: STRING; str_doc_string: STRING; dw_help_context: INTEGER; str_help_file: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&, System.String&, System.Int32&, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetDocumentation"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB
