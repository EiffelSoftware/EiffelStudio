indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Net.ICredentials"

deferred external class
	SYSTEM_NET_ICREDENTIALS

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_credential (uri: SYSTEM_URI; auth_type: STRING): SYSTEM_NET_NETWORKCREDENTIAL is
		external
			"IL deferred signature (System.Uri, System.String): System.Net.NetworkCredential use System.Net.ICredentials"
		alias
			"GetCredential"
		end

end -- class SYSTEM_NET_ICREDENTIALS
