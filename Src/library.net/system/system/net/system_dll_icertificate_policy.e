indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.ICertificatePolicy"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICERTIFICATE_POLICY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	check_validation_result (srv_point: SYSTEM_DLL_SERVICE_POINT; certificate: X509_CERTIFICATE; request: SYSTEM_DLL_WEB_REQUEST; certificate_problem: INTEGER): BOOLEAN is
		external
			"IL deferred signature (System.Net.ServicePoint, System.Security.Cryptography.X509Certificates.X509Certificate, System.Net.WebRequest, System.Int32): System.Boolean use System.Net.ICertificatePolicy"
		alias
			"CheckValidationResult"
		end

end -- class SYSTEM_DLL_ICERTIFICATE_POLICY
