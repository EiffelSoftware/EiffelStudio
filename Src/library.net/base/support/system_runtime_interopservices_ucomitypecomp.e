indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMITypeComp"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	bind (sz_name: STRING; l_hash_val: INTEGER; w_flags: INTEGER_16; pp_tinfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO; p_desc_kind: SYSTEM_RUNTIME_INTEROPSERVICES_DESCKIND; p_bind_ptr: SYSTEM_RUNTIME_INTEROPSERVICES_BINDPTR) is
		external
			"IL deferred signature (System.String, System.Int32, System.Int16, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.DESCKIND&, System.Runtime.InteropServices.BINDPTR&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"Bind"
		end

	bind_type (sz_name: STRING; l_hash_val: INTEGER; pp_tinfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO; pp_tcomp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"BindType"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP
