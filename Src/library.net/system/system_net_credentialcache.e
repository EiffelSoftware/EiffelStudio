indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.CredentialCache"

external class
	SYSTEM_NET_CREDENTIALCACHE

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_NET_ICREDENTIALS
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Net.CredentialCache"
		end

feature -- Access

	frozen get_default_credentials: SYSTEM_NET_ICREDENTIALS is
		external
			"IL static signature (): System.Net.ICredentials use System.Net.CredentialCache"
		alias
			"get_DefaultCredentials"
		end

feature -- Basic Operations

	frozen remove (uri_prefix: SYSTEM_URI; auth_type: STRING) is
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

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Net.CredentialCache"
		alias
			"GetEnumerator"
		end

	frozen add (uri_prefix: SYSTEM_URI; auth_type: STRING; cred: SYSTEM_NET_NETWORKCREDENTIAL) is
		external
			"IL signature (System.Uri, System.String, System.Net.NetworkCredential): System.Void use System.Net.CredentialCache"
		alias
			"Add"
		end

	frozen get_credential (uri_prefix: SYSTEM_URI; auth_type: STRING): SYSTEM_NET_NETWORKCREDENTIAL is
		external
			"IL signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.CredentialCache"
		alias
			"GetCredential"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Net.CredentialCache"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_NET_CREDENTIALCACHE
