indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMITypeInfo"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO

inherit
	ANY
		undefine
			Finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_containing_type_lib (ppTLB: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPELIB; pIndex: INTEGER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeLib&, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetContainingTypeLib"
		end

	get_type_attr (ppTypeAttr: POINTER) is
		external
			"IL deferred signature (System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetTypeAttr"
		end

	release_func_desc (pFuncDesc: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseFuncDesc"
		end

	get_documentation (index: INTEGER; strName: STRING; strDocString: STRING; dwHelpContext: INTEGER; strHelpFile: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&, System.String&, System.Int32&, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetDocumentation"
		end

	get_dll_entry (memid: INTEGER; inv_kind: INTEGER; pBstrDllName: STRING; pBstrName: STRING; pwOrdinal: INTEGER_16) is
			-- Valid values for `inv_kind' are:
			-- INVOKE_FUNC = 1
			-- INVOKE_PROPERTYGET = 2
			-- INVOKE_PROPERTYPUT = 4
			-- INVOKE_PROPERTYPUTREF = 8
		require
			valid_invokekind: inv_kind = 1 or inv_kind = 2 or inv_kind = 4 or inv_kind = 8
		external
			"IL deferred signature (System.Int32, enum System.Runtime.InteropServices.INVOKEKIND, System.String&, System.String&, System.Int16&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetDllEntry"
		end

	invoke (pvInstance: ANY; memid: INTEGER; wFlags: INTEGER_16; pDispParams: SYSTEM_RUNTIME_INTEROPSERVICES_DISPPARAMS; pVarResult: ANY; pExcepInfo: SYSTEM_RUNTIME_INTEROPSERVICES_EXCEPINFO) is
		external
			"IL deferred signature (System.Object, System.Int32, System.Int16, System.Runtime.InteropServices.DISPPARAMS&, System.Object&, System.Runtime.InteropServices.EXCEPINFO&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"Invoke"
		end

	get_ids_of_names (rgszNames: ARRAY [STRING]; cNames: INTEGER; pMemId: ARRAY [INTEGER]) is
		external
			"IL deferred signature (System.String[], System.Int32, System.Int32[]): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetIDsOfNames"
		end

	get_ref_type_info (hRef: INTEGER; ppTI: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetRefTypeInfo"
		end

	get_impl_type_flags (index: INTEGER; pImplTypeFlags: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetImplTypeFlags"
		end

	get_var_desc (index: INTEGER; ppVarDesc: POINTER) is
		external
			"IL deferred signature (System.Int32, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetVarDesc"
		end

	release_type_attr (pTypeAttr: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseTypeAttr"
		end

	get_ref_type_of_impl_type (index: INTEGER; href: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetRefTypeOfImplType"
		end

	get_names (memid: INTEGER; rgBstrNames: ARRAY [STRING]; cMaxNames: INTEGER; pcNames: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.String[], System.Int32, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetNames"
		end

	get_type_comp (ppTComp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetTypeComp"
		end

	create_instance (pUnkOuter: ANY; riid: SYSTEM_GUID; ppvObj: ANY) is
		external
			"IL deferred signature (System.Object, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"CreateInstance"
		end

	address_of_member (memid: INTEGER; inv_kind: INTEGER; ppv: POINTER) is
			-- Valid values for `inv_kind' are:
			-- INVOKE_FUNC = 1
			-- INVOKE_PROPERTYGET = 2
			-- INVOKE_PROPERTYPUT = 4
			-- INVOKE_PROPERTYPUTREF = 8
		require
			valid_invokekind: inv_kind = 1 or inv_kind = 2 or inv_kind = 4 or inv_kind = 8
		external
			"IL deferred signature (System.Int32, enum System.Runtime.InteropServices.INVOKEKIND, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"AddressOfMember"
		end

	get_func_desc (index: INTEGER; ppFuncDesc: POINTER) is
		external
			"IL deferred signature (System.Int32, System.IntPtr&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetFuncDesc"
		end

	release_var_desc (pVarDesc: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"ReleaseVarDesc"
		end

	get_mops (memid: INTEGER; pBstrMops: STRING) is
		external
			"IL deferred signature (System.Int32, System.String&): System.Void use System.Runtime.InteropServices.UCOMITypeInfo"
		alias
			"GetMops"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO
