indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.ServicePointManager"

external class
	SYSTEM_NET_SERVICEPOINTMANAGER

create {NONE}

feature -- Access

	frozen get_max_service_point_idle_time: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Net.ServicePointManager"
		alias
			"get_MaxServicePointIdleTime"
		end

	frozen get_certificate_policy: SYSTEM_NET_ICERTIFICATEPOLICY is
		external
			"IL static signature (): System.Net.ICertificatePolicy use System.Net.ServicePointManager"
		alias
			"get_CertificatePolicy"
		end

	frozen default_non_persistent_connection_limit: INTEGER is 0x4

	frozen get_default_connection_limit: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Net.ServicePointManager"
		alias
			"get_DefaultConnectionLimit"
		end

	frozen default_persistent_connection_limit: INTEGER is 0x2

	frozen get_max_service_points: INTEGER is
		external
			"IL static signature (): System.Int32 use System.Net.ServicePointManager"
		alias
			"get_MaxServicePoints"
		end

feature -- Element Change

	frozen set_certificate_policy (value: SYSTEM_NET_ICERTIFICATEPOLICY) is
		external
			"IL static signature (System.Net.ICertificatePolicy): System.Void use System.Net.ServicePointManager"
		alias
			"set_CertificatePolicy"
		end

	frozen set_max_service_points (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Net.ServicePointManager"
		alias
			"set_MaxServicePoints"
		end

	frozen set_max_service_point_idle_time (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Net.ServicePointManager"
		alias
			"set_MaxServicePointIdleTime"
		end

	frozen set_default_connection_limit (value: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.Net.ServicePointManager"
		alias
			"set_DefaultConnectionLimit"
		end

feature -- Basic Operations

	frozen find_service_point_uri_iweb_proxy (address: SYSTEM_URI; proxy: SYSTEM_NET_IWEBPROXY): SYSTEM_NET_SERVICEPOINT is
		external
			"IL static signature (System.Uri, System.Net.IWebProxy): System.Net.ServicePoint use System.Net.ServicePointManager"
		alias
			"FindServicePoint"
		end

	frozen find_service_point_string (uri_string: STRING; proxy: SYSTEM_NET_IWEBPROXY): SYSTEM_NET_SERVICEPOINT is
		external
			"IL static signature (System.String, System.Net.IWebProxy): System.Net.ServicePoint use System.Net.ServicePointManager"
		alias
			"FindServicePoint"
		end

	frozen find_service_point (address: SYSTEM_URI): SYSTEM_NET_SERVICEPOINT is
		external
			"IL static signature (System.Uri): System.Net.ServicePoint use System.Net.ServicePointManager"
		alias
			"FindServicePoint"
		end

end -- class SYSTEM_NET_SERVICEPOINTMANAGER
