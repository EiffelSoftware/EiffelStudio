note
	description: "Summary description for {OAUTH_10_TEMPLATE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_10_TEMPLATE_API

inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint: STRING_8
			-- <Precursor>	
		do
			Result := Access_token_endpoint_url
		end

	authorization_url (a_token: detachable OAUTH_TOKEN): STRING_8
			-- <Precursor>
		do
			create Result.make_from_string (Authorize_url)
			if a_token /= Void then
				Result.append (a_token.token)
			end
		end

	request_token_endpoint: STRING_8
			-- <Precursor>
		do
			Result := Request_token_endpoint_url
		end

feature {NONE} -- Implementation

	authorize_url: STRING
		deferred
		end

	request_token_endpoint_url: STRING
		deferred
		end

	access_token_endpoint_url: STRING
		deferred
		end


note
	copyright: "2013-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
