note
	description: "Summary description for {TOKEN_EXTRACTOR_10}."
	date: "$Date$"
	revision: "$Revision$"

class
	TOKEN_EXTRACTOR_10

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
		do
				-- Extract token definition
			if response.has_substring (Token_definition) then
				l_token_index := response.substring_index (Token_definition, 1)
				l_extract := response.substring (token_definition.count + l_token_index, response.count)
				l_param_index := l_extract.index_of (parameter_separator, 1)
				if l_param_index /= 0 then
					l_extract := l_extract.substring (1 , l_param_index - 1)
				end
					-- FIXME: can token be unicode??
				create Result.make_token_secret_response (l_extract, empty_secret, response)

					-- Extract Secret token definition
				if response.has_substring (Secret_token_definition) then
					l_token_index := response.substring_index (Secret_token_definition, 1)
					l_extract := response.substring (Secret_token_definition.count + l_token_index, response.count)
					l_param_index := l_extract.index_of (parameter_separator, 1)
					if l_param_index /= 0  then
						l_extract := l_extract.substring (1 , l_param_index - 1)
					end
						-- FIXME: can token be unicode??
					Result.set_secret (l_extract)
				else
					Result := Void
				end
			end
		ensure then
			token_definition: attached Result implies response.has_substring (Token_definition) and then response.has_substring (Secret_token_definition)
		end

feature {NONE} -- Implementation

	Token_definition: STRING = "oauth_token="

	Secret_token_definition: STRING = "oauth_token_secret="

	Empty_secret: STRING = ""

	Parameter_separator: CHARACTER = '&'

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
