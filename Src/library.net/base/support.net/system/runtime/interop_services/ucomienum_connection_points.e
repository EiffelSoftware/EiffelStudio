indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIENUM_CONNECTION_POINTS

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: NATIVE_ARRAY [UCOMICONNECTION_POINT]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMIConnectionPoint[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Next"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Reset"
		end

	skip (celt: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Skip"
		end

	clone_ (ppenum: UCOMIENUM_CONNECTION_POINTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnectionPoints&): System.Void use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Clone"
		end

end -- class UCOMIENUM_CONNECTION_POINTS
