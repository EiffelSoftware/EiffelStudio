indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIEnumString"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMSTRING

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	clone (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMSTRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumString&): System.Void use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Clone"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Reset"
		end

	skip (celt: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Skip"
		end

	next (celt: INTEGER; rgelt: ARRAY [STRING]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.String[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Next"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMSTRING
