indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIEnumString"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIENUM_STRING

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: NATIVE_ARRAY [SYSTEM_STRING]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.String[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Next"
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

	clone_ (ppenum: UCOMIENUM_STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumString&): System.Void use System.Runtime.InteropServices.UCOMIEnumString"
		alias
			"Clone"
		end

end -- class UCOMIENUM_STRING
