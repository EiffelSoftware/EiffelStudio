indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	get_type_comp (ppTComp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeComp"
		end

	get_lib_attr (ppTLibAttr: POINTER) is
		external
			"IL deferred signature (System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetLibAttr"
		end

	get_type_info_count: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoCount"
		end

	release_t_lib_attr (pTLibAttr: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"ReleaseTLibAttr"
		end

	get_type_info (index: INTEGER; ppTI: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfo"
		end

	get_type_info_type (index: INTEGER; p_tkind: INTEGER) is
			-- Valid values for `p_tkind' are:
			-- TKIND_ENUM = 0
			-- TKIND_RECORD = 1
			-- TKIND_MODULE = 2
			-- TKIND_INTERFACE = 3
			-- TKIND_DISPATCH = 4
			-- TKIND_COCLASS = 5
			-- TKIND_ALIAS = 6
			-- TKIND_UNION = 7
			-- TKIND_MAX = 8
		require
			valid_typekind: p_tkind = 0 or p_tkind = 1 or p_tkind = 2 or p_tkind = 3 or p_tkind = 4 or p_tkind = 5 or p_tkind = 6 or p_tkind = 7 or p_tkind = 8
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.TYPEKIND&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoType"
		end

	get_type_info_of_guid (guid: SYSTEM_GUID; ppTInfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Guid&, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetTypeInfoOfGuid"
		end

	get_documentation (index: INTEGER; strName: STRING; strDocString: STRING; dwHelpContext: INTEGER; strHelpFile: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&, System.String&, System.Int32&, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"GetDocumentation"
		end

	is_name (szNameBuf: STRING; lHashVal: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.String, System.Int32): System.Boolean use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"IsName"
		end

	find_name (szNameBuf: STRING; lHashVal: INTEGER; ppTInfo: ARRAY [SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO]; rgMemId: INTEGER; pcFound: INTEGER_16) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo[], System.Int32, System.Int16&): System.Void use System.Runtime.InteropServices.UCOMITypeLib"
		alias
			"FindName"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB
