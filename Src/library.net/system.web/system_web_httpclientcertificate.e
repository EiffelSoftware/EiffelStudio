indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.HttpClientCertificate"

external class
	SYSTEM_WEB_HTTPCLIENTCERTIFICATE

inherit
	SYSTEM_COLLECTIONS_SPECIALIZED_NAMEVALUECOLLECTION
		redefine
			get
		end
	SYSTEM_RUNTIME_SERIALIZATION_ISERIALIZABLE
	SYSTEM_RUNTIME_SERIALIZATION_IDESERIALIZATIONCALLBACK
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			copy_to as system_collections_icollection_copy_to
		end

create {NONE}

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpClientCertificate"
		alias
			"get_Flags"
		end

	frozen get_cookie: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_Cookie"
		end

	frozen get_secret_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpClientCertificate"
		alias
			"get_SecretKeySize"
		end

	frozen get_valid_until: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpClientCertificate"
		alias
			"get_ValidUntil"
		end

	frozen get_certificate: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpClientCertificate"
		alias
			"get_Certificate"
		end

	frozen get_is_present: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpClientCertificate"
		alias
			"get_IsPresent"
		end

	frozen get_key_size: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpClientCertificate"
		alias
			"get_KeySize"
		end

	frozen get_valid_from: SYSTEM_DATETIME is
		external
			"IL signature (): System.DateTime use System.Web.HttpClientCertificate"
		alias
			"get_ValidFrom"
		end

	frozen get_is_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.HttpClientCertificate"
		alias
			"get_IsValid"
		end

	frozen get_subject: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_Subject"
		end

	frozen get_server_issuer: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_ServerIssuer"
		end

	frozen get_cert_encoding: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.HttpClientCertificate"
		alias
			"get_CertEncoding"
		end

	frozen get_binary_issuer: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpClientCertificate"
		alias
			"get_BinaryIssuer"
		end

	frozen get_issuer: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_Issuer"
		end

	frozen get_server_subject: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_ServerSubject"
		end

	frozen get_serial_number: STRING is
		external
			"IL signature (): System.String use System.Web.HttpClientCertificate"
		alias
			"get_SerialNumber"
		end

	frozen get_public_key: ARRAY [INTEGER_8] is
		external
			"IL signature (): System.Byte[] use System.Web.HttpClientCertificate"
		alias
			"get_PublicKey"
		end

feature -- Basic Operations

	get (field: STRING): STRING is
		external
			"IL signature (System.String): System.String use System.Web.HttpClientCertificate"
		alias
			"Get"
		end

end -- class SYSTEM_WEB_HTTPCLIENTCERTIFICATE
