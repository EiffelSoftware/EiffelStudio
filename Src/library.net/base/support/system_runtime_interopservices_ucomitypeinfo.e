indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMITypeInfo"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_documentation (index: INTEGER; str_name: STRING; str_doc_string: STRING; dw_help_context: INTEGER; str_help_file: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&, System.String&, System.Int32&, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetDocumentation"
		end

	get_func_desc (index: INTEGER; pp_func_desc: POINTER) is
		external
			"IL deferred signature (System.Int32, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetFuncDesc"
		end

	get_var_desc (index: INTEGER; pp_var_desc: POINTER) is
		external
			"IL deferred signature (System.Int32, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetVarDesc"
		end

	get_ref_type_of_impl_type (index: INTEGER; href: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetRefTypeOfImplType"
		end

	get_ref_type_info (h_ref: INTEGER; pp_ti: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetRefTypeInfo"
		end

	get_names (memid: INTEGER; rg_bstr_names: ARRAY [STRING]; c_max_names: INTEGER; pc_names: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.String[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetNames"
		end

	get_type_attr (pp_type_attr: POINTER) is
		external
			"IL deferred signature (System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetTypeAttr"
		end

	get_impl_type_flags (index: INTEGER; p_impl_type_flags: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetImplTypeFlags"
		end

	release_var_desc (p_var_desc: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseVarDesc"
		end

	release_type_attr (p_type_attr: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseTypeAttr"
		end

	get_containing_type_lib (pp_tlb: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB; p_index: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeLib&, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetContainingTypeLib"
		end

	get_type_comp (pp_tcomp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetTypeComp"
		end

	address_of_member (memid: INTEGER; inv_kind: SYSTEM_RUNTIME_INTEROPSERVICES_INVOKEKIND; ppv: POINTER) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.INVOKEKIND, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"AddressOfMember"
		end

	get_dll_entry (memid: INTEGER; inv_kind: SYSTEM_RUNTIME_INTEROPSERVICES_INVOKEKIND; p_bstr_dll_name: STRING; p_bstr_name: STRING; pw_ordinal: INTEGER_16) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.INVOKEKIND, System.String&, System.String&, System.Int16&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetDllEntry"
		end

	release_func_desc (p_func_desc: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseFuncDesc"
		end

	get_mops (memid: INTEGER; p_bstr_mops: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetMops"
		end

	create_instance (p_unk_outer: ANY; riid: SYSTEM_GUID; ppv_obj: ANY) is
		external
			"IL deferred signature (System.Object, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"CreateInstance"
		end

	get_ids_of_names (rgsz_names: ARRAY [STRING]; c_names: INTEGER; p_mem_id: ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.String[], System.Int32, System.Int32[]): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetIDsOfNames"
		end

	invoke (pv_instance: ANY; memid: INTEGER; w_flags: INTEGER_16; p_disp_params: SYSTEM_RUNTIME_INTEROPSERVICES_DISPPARAMS; p_var_result: ANY; p_excep_info: SYSTEM_RUNTIME_INTEROPSERVICES_EXCEPINFO) is
		external
			"IL deferred signature (System.Object, System.Int32, System.Int16, System.Runtime.InteropServices.DISPPARAMS&, System.Object&, System.Runtime.InteropServices.EXCEPINFO&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"Invoke"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO
