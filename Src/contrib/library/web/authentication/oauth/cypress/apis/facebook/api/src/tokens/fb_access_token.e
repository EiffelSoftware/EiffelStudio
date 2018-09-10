note
	description: "Object that represent an Access Token"
	date: "$Date$"
	revision: "$Revision$"
	EIS:"Name=Access Token", "src=https://developers.facebook.com/docs/facebook-login/access-tokens", "protocol=uri"

class
	FB_ACCESS_TOKEN

feature -- Access

	access_token: detachable STRING
			-- A long live token generated from a short live token.

	expires_in: INTEGER_64
			-- Define the validity period of an obtained token.

feature -- Change Element

	set_access_token (a_access_token: like access_token)
			-- Set `access_token' with `a_access_token'.
		do
			access_token := a_access_token
		ensure
			access_token_set: access_token = a_access_token
		end

	set_expires_in (a_val: like expires_in)
		do
			expires_in := a_val
		ensure
			expires_in_set: expires_in = a_val
		end
end
