note
	description: "Summary description for {OAUTH_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name:OAuth1.0", "src=http://tools.ietf.org/html/rfc5849", "protocol=uri"
	EIS: "name:OAuth2.0", "src=http://tools.ietf.org/html/draft-ietf-oauth-v2-31", "protocol=uri"

class
	OAUTH_CONSTANTS

feature -- Access

	Timestamp: STRING = "oauth_timestamp"

	Sign_method: STRING = "oauth_signature_method"

	Signature: STRING = "oauth_signature"

	Consumer_secret: STRING = "oauth_consumer_secret"

	Consumer_key: STRING = "oauth_consumer_key"

	Callback: STRING = "oauth_callback"

	Version: STRING = "oauth_version"

	Nonce: STRING = "oauth_nonce"

	Param_prefix: STRING = "oauth_"

	Token: STRING = "oauth_token"

	Token_secret: STRING = "oauth_token_secret"

	Out_of_band: STRING = "oob"

	Verifier: STRING = "oauth_verifier"

	Header: STRING = "Authorization"

	Empty_token: OAUTH_TOKEN
		do
			create Result.make_empty
		end

	Scope: STRING = "scope"

feature -- OAuth2.0

	Access_token: STRING = "access_token"

	Client_id: STRING = "client_id"

	Client_secret: STRING = "client_secret"

	Redirect_uri: STRING = "redirect_uri"

	Code: STRING = "code"

	Grant_type: STRING = "grant_type"

	Authorization_code: STRING = "authorization_code"

note
	copyright: "2013-2013, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
