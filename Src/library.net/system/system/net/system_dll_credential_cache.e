indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.CredentialCache"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_CREDENTIAL_CACHE

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICREDENTIALS
	IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.CredentialCache"
		end

feature -- Access

	frozen get_default_credentials: SYSTEM_DLL_ICREDENTIALS is
		external
			"IL static signature (): System.Net.ICredentials use System.Net.CredentialCache"
		alias
			"get_DefaultCredentials"
		end

feature -- Basic Operations

	frozen remove (uri_prefix: SYSTEM_DLL_URI; auth_type: SYSTEM_STRING) is
		external
			"IL signature (System.Uri, System.String): System.Void use System.Net.CredentialCache"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.CredentialCache"
		alias
			"GetHashCode"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.CredentialCache"
		alias
			"GetEnumerator"
		end

	frozen add (uri_prefix: SYSTEM_DLL_URI; auth_type: SYSTEM_STRING; cred: SYSTEM_DLL_NETWORK_CREDENTIAL) is
		external
			"IL signature (System.Uri, System.String, System.Net.NetworkCredential): System.Void use System.Net.CredentialCache"
		alias
			"Add"
		end

	frozen get_credential (uri_prefix: SYSTEM_DLL_URI; auth_type: SYSTEM_STRING): SYSTEM_DLL_NETWORK_CREDENTIAL is
		external
			"IL signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.CredentialCache"
		alias
			"GetCredential"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Net.CredentialCache"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Net.CredentialCache"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Net.CredentialCache"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_CREDENTIAL_CACHE
