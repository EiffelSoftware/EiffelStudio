indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	bind (szName: STRING; lHashVal: INTEGER; wFlags: INTEGER_16; ppTInfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO; p_desc_kind: INTEGER; pBindPtr: SYSTEM_RUNTIME_INTEROPSERVICES_BINDPTR) is
			-- Valid values for `p_desc_kind' are:
			-- DESCKIND_NONE = 0
			-- DESCKIND_FUNCDESC = 1
			-- DESCKIND_VARDESC = 2
			-- DESCKIND_TYPECOMP = 3
			-- DESCKIND_IMPLICITAPPOBJ = 4
			-- DESCKIND_MAX = 5
		require
			valid_desckind: p_desc_kind = 0 or p_desc_kind = 1 or p_desc_kind = 2 or p_desc_kind = 3 or p_desc_kind = 4 or p_desc_kind = 5
		external
			"IL deferred signature (System.String, System.Int32, System.Int16, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.DESCKIND&, System.Runtime.InteropServices.BINDPTR&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"Bind"
		end

	bind_type (szName: STRING; lHashVal: INTEGER; ppTInfo: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPEINFO; ppTComp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP) is
		external
			"IL deferred signature (System.String, System.Int32, System.Runtime.InteropServices.UCOMITypeInfo&, System.Runtime.InteropServices.UCOMITypeComp&): System.Void use System.Runtime.InteropServices.UCOMITypeComp"
		alias
			"BindType"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMITYPECOMP
