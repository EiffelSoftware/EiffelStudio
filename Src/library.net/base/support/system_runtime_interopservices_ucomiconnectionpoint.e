indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIConnectionPoint"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	unadvise (dwCookie: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"Unadvise"
		end

	get_connection_interface (pIID: SYSTEM_GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"GetConnectionInterface"
		end

	advise (pUnkSink: ANY; pdwCookie: INTEGER) is
		external
			"IL deferred signature (System.Object, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"Advise"
		end

	enum_connections (ppEnum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMCONNECTIONS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnections&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"EnumConnections"
		end

	get_connection_point_container (ppCPC: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINTCONTAINER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIConnectionPointContainer&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"GetConnectionPointContainer"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMICONNECTIONPOINT
