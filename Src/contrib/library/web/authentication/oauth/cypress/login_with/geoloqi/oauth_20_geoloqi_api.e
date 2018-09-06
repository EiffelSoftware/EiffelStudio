note
	description: "Summary description for {OAUTH_20_GEOLOQI_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Authentication", "src=https://developers.geoloqi.com/api/authentication", "protocol=uri"
	EIS: "name=OAuth 2.0", "src=https://developers.geoloqi.com/api/OAuth_2.0", "protocol=uri"

class
	OAUTH_20_GEOLOQI_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_verb: STRING_8
		do
			Result := "POST"
		end

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
			-- <Precursor>
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_endpoint: STRING_8
			-- Url that receives the access token request
		do
			create Result.make_from_string ("https://api.geoloqi.com/1/oauth/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable STRING_8
			-- Url where you should redirect your users to authneticate.
		local
		do
				--|GEOLOQUI only use POST 	request
		end

feature -- Implementation

	Template_authorization_url: STRING = "https://api.geoloqi.com/1/oauth/token"

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
