indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.ICredentials"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICREDENTIALS

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_credential (uri: SYSTEM_DLL_URI; auth_type: SYSTEM_STRING): SYSTEM_DLL_NETWORK_CREDENTIAL is
		external
			"IL deferred signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.ICredentials"
		alias
			"GetCredential"
		end

end -- class SYSTEM_DLL_ICREDENTIALS
