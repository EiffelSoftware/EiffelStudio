indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.ICertificatePolicy"

deferred external class
	SYSTEM_NET_ICERTIFICATEPOLICY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	check_validation_result (srv_point: SYSTEM_NET_SERVICEPOINT; certificate: SYSTEM_SECURITY_CRYPTOGRAPHY_X509CERTIFICATES_X509CERTIFICATE; request: SYSTEM_NET_WEBREQUEST; certificate_problem: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Net.ServicePoint, System.Security.Cryptography.X509Certificates.X509Certificate, System.Net.WebRequest, System.Int32): System.Boolean use System.Net.ICertificatePolicy"
		alias
			"CheckValidationResult"
		end

end -- class SYSTEM_NET_ICERTIFICATEPOLICY
