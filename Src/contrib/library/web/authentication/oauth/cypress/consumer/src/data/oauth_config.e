note
	description: "Summary description for {OAUTH_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Oauth20 spec", "src=https://tools.ietf.org/html/rfc6749"

class
	OAUTH_CONFIG

create
	make_default, make

feature {NONE} -- Initializaton

	make (a_key: READABLE_STRING_8; a_secret: READABLE_STRING_8; a_callback: like callback; a_signature: like signature_type; a_scope: like scope; a_stream: like debug_stream)
		do
			create api_key.make_from_string (a_key)
			create api_secret.make_from_string (a_secret)
			callback := a_callback
			signature_type := a_signature
			scope := a_scope
			debug_stream := a_stream
		ensure
			key_set: api_key.same_string (a_key)
			secret_Set: api_secret.same_string (a_secret)
			callback_set: attached callback as l_callback implies l_callback = a_callback
			signature_type_set: attached signature_type as l_signature implies l_signature = a_signature
			scope_set: attached scope implies has_scope
			debug_stream_set: attached debug_stream as l_debug_stream implies l_debug_stream = a_stream
		end

	make_default (a_key: like api_key; a_secret: like api_secret)
		do
			make (a_key, a_secret, Void, Void, Void, Void)
		ensure
			key_set: api_key = a_key
			secret_Set: api_secret = a_secret
		end

feature -- Access

	api_key: IMMUTABLE_STRING_8
			-- The client identifier issued to the client during the registration process.
			-- TODO fix and use STRING_32 or STRING_8

	api_secret: IMMUTABLE_STRING_8
			-- The client MAY omit the parameter if the client secret is an empty string.	

	callback: detachable STRING_8
			--  Url redirecting the user-agent back to the client.

	signature_type: detachable OAUTH_SIGNATURE_TYPE

	scope: detachable STRING
			-- scope of the access request.	
			-- TODO: check if scope can be unicode encoded.

	debug_stream: detachable STRING

	grant_type: detachable STRING
			--  The authorization code grant type is used to obtain both access tokens and refresh tokens and is optimized for confidential clients.
			--  OAuth defines four grant types: authorization code, implicit, resource owner password credentials, and client credentials.

	state: detachable STRING
			-- An opaque value used by the client to maintain state between the request and callback.

feature -- Status Report

	has_scope: BOOLEAN
		do
			Result := attached scope
		end

feature -- Change Element

	set_callback (a_callback: like callback)
			-- Set callback with `a_callback'
		do
			callback := a_callback
		ensure
			callback_set: attached callback as l_callback implies l_callback = a_callback
		end

	set_scope (a_scope: READABLE_STRING_8)
			-- Set scope with `a_scope'
		do
			scope := a_scope
		ensure
			scope_set: attached scope as l_scope implies l_scope.same_string (a_scope)
		end

	set_grant_type (a_type: READABLE_STRING_8)
			-- Set grant_type with `a_type'
		do
			grant_type := a_type
		ensure
			grant_type_set: attached grant_type as l_grant_type implies l_grant_type.same_string_general (a_type)
		end

	set_signature_type (a_signature: OAUTH_SIGNATURE_TYPE)
			-- Set signature_type with `a_signature'
		do
			signature_type := a_signature
		ensure
			signature_type_set: attached signature_type as l_signature_type implies l_signature_type = a_signature
		end

	set_state (a_state: READABLE_STRING_8)
			-- Set `state' with `a_state'
		do
			state := a_state
		ensure
			state_set: attached state as l_state implies l_state.same_string (a_state)
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
