note
	description: "Summary description for {JSON_TOKEN_EXTRACTOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TOKEN_EXTRACTOR

inherit

	ACCESS_TOKEN_EXTRACTOR

feature -- Extractor

	extract (response: READABLE_STRING_8): detachable OAUTH_TOKEN
		local
			l_json_parser: JSON_PARSER
		do
			create l_json_parser.make_with_string (response)
			l_json_parser.parse_content
			if
				l_json_parser.is_valid and then
				attached {JSON_OBJECT} l_json_parser.parsed_json_object as l_object
			then
				if attached {JSON_STRING} l_object.item ("access_token") as l_access_token then
					create Result.make_token_secret_response (l_access_token.item, "", response)

					if attached {JSON_STRING} l_object.item ("refresh_token") as l_refresh_value then
						Result.set_refresh_token (l_refresh_value.item)
					end
					if attached {JSON_STRING} l_object.item ("token_type") as l_token_type then
						Result.set_token_type (l_token_type.item)
					end
					if
						attached {JSON_NUMBER} l_object.item ("expires_in") as l_expires_in_value and then
						l_expires_in_value.is_integer
					then
						Result.set_expires_in (l_expires_in_value.integer_64_item.to_integer) -- Truncation to integer_32
					end
				end
			end
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
