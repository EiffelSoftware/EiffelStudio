indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIEnumVARIANT"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMVARIANT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	skip (celt: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumVARIANT"
		alias
			"Skip"
		end

	next (celt: INTEGER; rgvar: INTEGER; pceltFetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Int32, System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumVARIANT"
		alias
			"Next"
		end

	clone (ppenum: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIEnumVARIANT"
		alias
			"Clone"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumVARIANT"
		alias
			"Reset"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMVARIANT
