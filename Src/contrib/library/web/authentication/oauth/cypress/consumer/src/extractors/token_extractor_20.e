note
	description: "Summary description for {TOKEN_EXTRACTOR_20}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_EXTRACTOR_20

inherit
	ACCESS_TOKEN_EXTRACTOR

	OAUTH_SHARED_ENCODER

feature -- Access

	extract (response: READABLE_STRING_8): detachable OAUTH_TOKEN
			-- Extracts the access token from the contents of an Http Response
		local
			l_token_index: INTEGER
			l_param_index: INTEGER
			l_extract: STRING_8
			l_decoded: STRING_32
		do
			if response.has_substring (Token_definition) then
				l_token_index := response.substring_index (Token_definition, 1)
				l_extract := response.substring (token_definition.count + 1, response.count)
				l_param_index := l_extract.index_of (parameter_separator, 1)
				if l_param_index /= 0 then
					l_extract := l_extract.substring (1, l_param_index - 1)
				end
					-- FIXME: can token be unicode encoded?
				create Result.make_token_secret_response (oauth_decoded_string (l_extract), empty_secret, response)
				if response.has_substring (Token_expires) then
					l_token_index := response.substring_index (Token_expires, 1)
					l_extract := response.substring (l_token_index + Token_expires.count + 1, response.count)
					l_param_index := l_extract.index_of (parameter_separator, l_token_index)
					if l_param_index /= 0 then
						l_extract := l_extract.substring (l_param_index + 1, response.count)
					end
					l_decoded := oauth_decoded_string (l_extract)
					Result.set_expires_in (l_decoded.to_integer)
				end
			end
		end

feature {NONE} -- Implementation

	Token_definition: STRING = "access_token="

	Token_expires: STRING = "expires"

	Empty_secret: STRING = ""

	Parameter_separator: CHARACTER = '&'
			-- TODO add code to extract refresh_token

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
