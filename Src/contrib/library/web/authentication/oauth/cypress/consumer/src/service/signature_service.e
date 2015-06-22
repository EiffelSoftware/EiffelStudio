note
	description: "Signs a base string, returning the OAuth signature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SIGNATURE_SERVICE

feature -- Access

	signature (base_string: READABLE_STRING_8; api_secret: READABLE_STRING_GENERAL; token_secret: READABLE_STRING_GENERAL): STRING_8
			-- Return a signature
			-- `base_string' url-encoded string to sign
			-- `api_secret' api secret for your app
			-- `token_secret' token secret (empty string for the request token step)
		require
			base_string_not_empty: not base_string.is_empty
			api_secret_not_empty : not api_secret.is_empty
		deferred
		end

	signature_method: STRING_8
			-- Return the signature algorithm
		deferred
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
