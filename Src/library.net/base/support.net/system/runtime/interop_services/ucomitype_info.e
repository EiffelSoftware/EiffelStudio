indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMITypeInfo"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMITYPE_INFO

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_documentation (index: INTEGER; str_name: SYSTEM_STRING; str_doc_string: SYSTEM_STRING; dw_help_context: INTEGER; str_help_file: SYSTEM_STRING) is
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

	get_ref_type_info (h_ref: INTEGER; pp_ti: UCOMITYPE_INFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetRefTypeInfo"
		end

	get_names (memid: INTEGER; rg_bstr_names: NATIVE_ARRAY [SYSTEM_STRING]; c_max_names: INTEGER; pc_names: INTEGER) is
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

	get_containing_type_lib (pp_tlb: UCOMITYPE_LIB; p_index: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeLib&, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetContainingTypeLib"
		end

	get_type_comp (pp_tcomp: UCOMITYPE_COMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetTypeComp"
		end

	address_of_member (memid: INTEGER; inv_kind: INVOKEKIND; ppv: POINTER) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.INVOKEKIND, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"AddressOfMember"
		end

	get_dll_entry (memid: INTEGER; inv_kind: INVOKEKIND; p_bstr_dll_name: SYSTEM_STRING; p_bstr_name: SYSTEM_STRING; pw_ordinal: INTEGER_16) is
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

	get_mops (memid: INTEGER; p_bstr_mops: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Int32, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetMops"
		end

	create_instance (p_unk_outer: SYSTEM_OBJECT; riid: GUID; ppv_obj: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"CreateInstance"
		end

	get_ids_of_names (rgsz_names: NATIVE_ARRAY [SYSTEM_STRING]; c_names: INTEGER; p_mem_id: NATIVE_ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.String[], System.Int32, System.Int32[]): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetIDsOfNames"
		end

	invoke (pv_instance: SYSTEM_OBJECT; memid: INTEGER; w_flags: INTEGER_16; p_disp_params: DISPPARAMS; p_var_result: SYSTEM_OBJECT; p_excep_info: EXCEPINFO; pu_arg_err: INTEGER) is
		external
			"IL deferred signature (System.Object, System.Int32, System.Int16, System.Runtime.InteropServices.DISPPARAMS&, System.Object&, System.Runtime.InteropServices.EXCEPINFO&, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"Invoke"
		end

end -- class UCOMITYPE_INFO
