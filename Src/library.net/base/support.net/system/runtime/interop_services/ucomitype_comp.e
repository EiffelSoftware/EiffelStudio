indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMITypeComp"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMITYPE_COMP

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	bind (sz_name: SYSTEM_STRING; l_hash_val: INTEGER; w_flags: INTEGER_16; pp_tinfo: UCOMITYPE_INFO; p_desc_kind: DESCKIND; p_bind_ptr: BINDPTR) is
		external
			"IL deferred signature (System.String, System.Int32, System.Int16, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.DESCKIND&, System.Runtime.InteropServices.BINDPTR&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"Bind"
		end

	bind_type (sz_name: SYSTEM_STRING; l_hash_val: INTEGER; pp_tinfo: UCOMITYPE_INFO; pp_tcomp: UCOMITYPE_COMP) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"BindType"
		end

end -- class UCOMITYPE_COMP
