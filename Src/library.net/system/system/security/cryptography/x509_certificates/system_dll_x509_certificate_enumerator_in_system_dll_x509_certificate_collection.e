indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_X509_CERTIFICATE_ENUMERATOR_IN_SYSTEM_DLL_X509_CERTIFICATE_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR
		rename
			reset as system_collections_ienumerator_reset,
			move_next as system_collections_ienumerator_move_next,
			get_current as system_collections_ienumerator_get_current
		end

create
	make

feature {NONE} -- Initialization

	frozen make (mappings: SYSTEM_DLL_X509_CERTIFICATE_COLLECTION) is
		external
			"IL creator signature (System.Security.Cryptography.X509Certificates.X509CertificateCollection) use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		end

feature -- Access

	frozen get_current: X509_CERTIFICATE is
		external
			"IL signature (): System.Security.Cryptography.X509Certificates.X509Certificate use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"GetHashCode"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_collections_ienumerator_move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"System.Collections.IEnumerator.MoveNext"
		end

	frozen system_collections_ienumerator_reset is
		external
			"IL signature (): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"System.Collections.IEnumerator.Reset"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"Finalize"
		end

	frozen system_collections_ienumerator_get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Security.Cryptography.X509Certificates.X509CertificateCollection+X509CertificateEnumerator"
		alias
			"System.Collections.IEnumerator.get_Current"
		end

end -- class SYSTEM_DLL_X509_CERTIFICATE_ENUMERATOR_IN_SYSTEM_DLL_X509_CERTIFICATE_COLLECTION
