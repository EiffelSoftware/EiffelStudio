indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.ServicePoint"

external class
	SYSTEM_NET_SERVICEPOINT

inherit
	ANY
		redefine
			get_hash_code
		end

create {NONE}

feature -- Access

	frozen get_connection_name: STRING is
		external
			"IL signature (): System.String use System.Net.ServicePoint"
		alias
			"get_ConnectionName"
		end

	get_protocol_version: SYSTEM_VERSION is
		external
			"IL signature (): System.Version use System.Net.ServicePoint"
		alias
			"get_ProtocolVersion"
		end

	frozen get_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Net.ServicePoint"
		alias
			"get_Certificate"
		end

	frozen get_idle_since: SYSTEM_DATETIME is
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

	frozen get_client_certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE is
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

	frozen get_address: SYSTEM_URI is
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

end -- class SYSTEM_NET_SERVICEPOINT
