indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.EndpointPermission"

external class
	SYSTEM_NET_ENDPOINTPERMISSION

inherit
	ANY
		rename
			is_equal as equals_object
		redefine
			get_hash_code,
			equals_object,
			to_string
		end

create {NONE}

feature -- Access

	frozen get_hostname: STRING is
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

	frozen get_transport: SYSTEM_NET_TRANSPORTTYPE is
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

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.EndpointPermission"
		alias
			"Equals"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.EndpointPermission"
		alias
			"ToString"
		end

end -- class SYSTEM_NET_ENDPOINTPERMISSION
