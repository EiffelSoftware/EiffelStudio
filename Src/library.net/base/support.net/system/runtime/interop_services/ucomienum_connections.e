indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIEnumConnections"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIENUM_CONNECTIONS

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	next (celt: INTEGER; rgelt: NATIVE_ARRAY [CONNECTDATA]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.CONNECTDATA[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Next"
		end

	reset is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Reset"
		end

	skip (celt: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Skip"
		end

	clone_ (ppenum: UCOMIENUM_CONNECTIONS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnections&): System.Void use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Clone"
		end

end -- class UCOMIENUM_CONNECTIONS
