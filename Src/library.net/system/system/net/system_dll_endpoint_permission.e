indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.EndpointPermission"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_ENDPOINT_PERMISSION

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code,
			equals,
			to_string
		end

create {NONE}

feature -- Access

	frozen get_hostname: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.EndpointPermission"
		alias
			"get_Hostname"
		end

	frozen get_port: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.EndpointPermission"
		alias
			"get_Port"
		end

	frozen get_transport: SYSTEM_DLL_TRANSPORT_TYPE is
		external
			"IL signature (): System.Net.TransportType use System.Net.EndpointPermission"
		alias
			"get_Transport"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.EndpointPermission"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.EndpointPermission"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.EndpointPermission"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_ENDPOINT_PERMISSION
