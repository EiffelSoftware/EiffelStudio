indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIEnumConnectionPoints"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONPOINTS

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
			"IL deferred signature (System.Int32): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Skip"
		end

	next (celt: INTEGER; rgelt: ARRAY [SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINT]; pceltFetched: INTEGER): INTEGER is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.UCOMIConnectionPoint[], System.Int32&): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Next"
		end

	clone (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONPOINTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnectionPoints&): System.Void use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Clone"
		end

	reset: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIEnumConnectionPoints"
		alias
			"Reset"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONPOINTS
