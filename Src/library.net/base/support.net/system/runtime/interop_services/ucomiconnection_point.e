indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIConnectionPoint"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMICONNECTION_POINT

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	enum_connections (pp_enum: UCOMIENUM_CONNECTIONS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnections&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"EnumConnections"
		end

	get_connection_interface (p_iid: GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"GetConnectionInterface"
		end

	get_connection_point_container (pp_cpc: UCOMICONNECTION_POINT_CONTAINER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIConnectionPointContainer&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"GetConnectionPointContainer"
		end

	unadvise (dw_cookie: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"Unadvise"
		end

	advise (p_unk_sink: SYSTEM_OBJECT; pdw_cookie: INTEGER) is
		external
			"IL deferred signature (System.Object, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPoint"
		alias
			"Advise"
		end

end -- class UCOMICONNECTION_POINT
