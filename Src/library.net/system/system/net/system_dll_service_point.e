indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.ServicePoint"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_SERVICE_POINT

inherit
	SYSTEM_OBJECT
		redefine
			get_hash_code
		end

create {NONE}

feature -- Access

	frozen get_connection_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.ServicePoint"
		alias
			"get_ConnectionName"
		end

	get_protocol_version: VERSION is
		external
			"IL signature (): System.Version use System.Net.ServicePoint"
		alias
			"get_ProtocolVersion"
		end

	frozen get_certificate: X509_CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Net.ServicePoint"
		alias
			"get_Certificate"
		end

	frozen get_idle_since: SYSTEM_DATE_TIME is
		external
			"IL signature (): System.DateTime use System.Net.ServicePoint"
		alias
			"get_IdleSince"
		end

	frozen get_max_idle_time: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.ServicePoint"
		alias
			"get_MaxIdleTime"
		end

	frozen get_client_certificate: X509_CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Net.ServicePoint"
		alias
			"get_ClientCertificate"
		end

	frozen get_connection_limit: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.ServicePoint"
		alias
			"get_ConnectionLimit"
		end

	frozen get_supports_pipelining: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.ServicePoint"
		alias
			"get_SupportsPipelining"
		end

	frozen get_current_connections: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.ServicePoint"
		alias
			"get_CurrentConnections"
		end

	frozen get_address: SYSTEM_DLL_URI is
		external
			"IL signature (): System.Uri use System.Net.ServicePoint"
		alias
			"get_Address"
		end

feature -- Element Change

	frozen set_connection_limit (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.ServicePoint"
		alias
			"set_ConnectionLimit"
		end

	frozen set_max_idle_time (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.ServicePoint"
		alias
			"set_MaxIdleTime"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.ServicePoint"
		alias
			"GetHashCode"
		end

end -- class SYSTEM_DLL_SERVICE_POINT
