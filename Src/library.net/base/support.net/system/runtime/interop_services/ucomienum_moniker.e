indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIEnumMoniker"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIENUM_MONIKER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: NATIVE_ARRAY [UCOMIMONIKER]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMIMoniker[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Next"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Reset"
		end

	skip (celt: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Skip"
		end

	clone_ (ppenum: UCOMIENUM_MONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIEnumMoniker"
		alias
			"Clone"
		end

end -- class UCOMIENUM_MONIKER
