indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIEnumConnections"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONS

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	clone (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnections&): System.Void use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Clone"
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

	next (celt: INTEGER; rgelt: ARRAY [SYSTEM_RUNTIME_INTEROPSERVICES_CONNECTDATA]; pcelt_fetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.CONNECTDATA[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnections"
		alias
			"Next"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONS
