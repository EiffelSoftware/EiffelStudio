indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIEnumMoniker"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER

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
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Skip"
		end

	next (celt: INTEGER; rgelt: ARRAY [SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER]; pceltFetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMIMoniker[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Next"
		end

	clone (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Clone"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Reset"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER
