indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIConnectionPointContainer"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMICONNECTION_POINT_CONTAINER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	find_connection_point (riid: GUID; pp_cp: UCOMICONNECTION_POINT) is
		external
			"IL deferred signature (System.Guid&, System.Runtime.InteropServices.UCOMIConnectionPoint&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPointContainer"
		alias
			"FindConnectionPoint"
		end

	enum_connection_points (pp_enum: UCOMIENUM_CONNECTION_POINTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumConnectionPoints&): System.Void use System.Runtime.InteropServices.UCOMIConnectionPointContainer"
		alias
			"EnumConnectionPoints"
		end

end -- class UCOMICONNECTION_POINT_CONTAINER
