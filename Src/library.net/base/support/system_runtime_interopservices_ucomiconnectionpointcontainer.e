indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIConnectionPointContainer"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINTCONTAINER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	find_connection_point (riid: SYSTEM_GUID; pp_cp: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINT) is
		external
			"IL deferred signature (System.Guid&, System.Runtime.InteropServices.UCOMIConnectionPoint&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPointContainer"
		alias
			"FindConnectionPoint"
		end

	enum_connection_points (pp_enum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONPOINTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnectionPoints&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPointContainer"
		alias
			"EnumConnectionPoints"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINTCONTAINER
