note
	description: "Summary description for {OAUTH_JWT_CONFIG}."
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_JWT_CONFIG

inherit

	OAUTH_CONFIG
		rename
			make as make_config
		end

create
	make

feature {NONE} -- Implementation

	make (a_assertion: READABLE_STRING_8; a_api_key: READABLE_STRING_8)
		do
			make_default (a_api_key, "")
			set_grant_type ("urn:ietf:params:oauth:grant-type:jwt-bearer")
			create assertion.make_from_string (a_assertion)
		end

feature -- Access

	assertion: IMMUTABLE_STRING_8
			--  JWT bearer token, base64url-encoded.

feature -- Change Element

	set_api_secret (a_secret: READABLE_STRING_8)
		do
			create api_secret.make_from_string (a_secret)
		end

note
	copyright: "2013-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
