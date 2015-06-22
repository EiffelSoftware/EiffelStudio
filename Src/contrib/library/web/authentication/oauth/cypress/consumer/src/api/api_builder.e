note
	description: "Summary description for {API_BUILDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Fluent API builder", "src=http://www.martinfowler.com/bliki/FluentInterface.html", "protocol=uri"
class
	API_BUILDER

inherit
	ANY
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
		do
			set_callback ({OAUTH_CONSTANTS}.out_of_band)
			set_signature_type(create {OAUTH_SIGNATURE_TYPE}.make)
			set_api_key ("")
			set_api_secret ("")
			create {NULL_OAUTH_API} api
		ensure then
			callback_set: callback.is_equal ({OAUTH_CONSTANTS}.out_of_band)
			signature_type_set: signature_type.is_header
			api_key_set_empty: api_key.is_empty
			api_secret_set_empty: api_secret.is_empty
			null_api: api.conforms_to (create {NULL_OAUTH_API} )
		end

feature -- Access

	callback: STRING
	signature_type: OAUTH_SIGNATURE_TYPE
	api_secret: STRING
	api_key: STRING
	scope: detachable STRING
	api: OAUTH_API

feature -- Fluent API

	with_callback (a_callback: READABLE_STRING_8): API_BUILDER
		do
			set_callback (a_callback)
			Result := Current
		ensure
			callback_set: Result.callback = a_callback
		end

	with_signature (a_signature_type: like signature_type): API_BUILDER
		do
			set_signature_type (a_signature_type)
			Result := Current
		ensure
		 	signature_set: Result.signature_type = a_signature_type
		end

	with_api_key (a_key: READABLE_STRING_8): API_BUILDER
		do
			set_api_key (a_key)
			Result := Current
		ensure
			api_key_set: Result.api_key = a_key
		end

	with_api_secret (a_secret: READABLE_STRING_8): API_BUILDER
		do
			set_api_secret (a_secret)
			Result := Current
		ensure
			api_secret_set: Result.api_secret = a_secret
		end

	with_scope (a_scope: READABLE_STRING_8): API_BUILDER
		do
			set_scope (a_scope)
			Result := Current
		end

	with_api (a_api: like api) : API_BUILDER
		do
			api := a_api
			Result := current
		ensure
			api_set: Result.api = a_api
		end

feature -- Build Service

	build: OAUTH_SERVICE_I
		require
			not_null_api:not api.conforms_to (create {NULL_OAUTH_API})
			is_valid_key: not api_key.is_empty
			is_valid_secret: not api_secret.is_empty
		local
			l_config: OAUTH_CONFIG
		do
			create l_config.make (api_key, api_secret, callback, signature_type, scope, Void)
			Result := api.create_service (l_config)
		end

feature {NONE} -- Element Change

	set_callback (a_callback: READABLE_STRING_8)
			-- Set `callback' with a callback	
		do
			callback := a_callback
		ensure
			callback_set: callback = a_callback
		end

	set_signature_type (a_signature_type: like signature_type)
			-- Set `signature_type' with `a_signature_type'
		do
			signature_type := a_signature_type
		ensure
			signature_type_set: signature_type = a_signature_type
		end

	set_api_secret (a_api_secret: READABLE_STRING_8)
			-- Set `api_secret'	with `a_api_secret'
		do
			api_secret := a_api_secret
		ensure
			api_secret_set: api_secret = a_api_secret
		end

	set_api_key (a_api_key: READABLE_STRING_8)
			-- Set `api_key' with `a_api_key'
		do
			api_key := a_api_key
		ensure
			api_key_set: api_key = a_api_key
		end

	set_scope (a_scope: READABLE_STRING_8)
			-- Set `scope' with `a_scope'
		do
			scope := a_scope
		ensure
			scope_set: attached scope as l_scope implies l_scope = a_scope
		end

note
	copyright: "2013-2015, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
