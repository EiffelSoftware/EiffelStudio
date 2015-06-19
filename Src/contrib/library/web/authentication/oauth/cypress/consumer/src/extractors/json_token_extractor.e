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

	extract (response: READABLE_STRING_GENERAL): detachable OAUTH_TOKEN
		local
			l_json_parser: JSON_PARSER
		do
			create l_json_parser.make_parser (response.as_string_8)
			if attached {JSON_OBJECT} l_json_parser.parse_object as l_object then
				if attached {JSON_STRING} l_object.item ("access_token") as l_value then
					create Result.make_token_secret_response (l_value.item, "", response.as_string_8)
				end
				if attached {JSON_STRING} l_object.item ("refresh_token") as l_value then
					if Result /= Void then
						Result.set_refresh_token (l_value.item)
					end
				end
				if attached {JSON_NUMBER} l_object.item ("expires_in") as l_value then
					if  Result /= Void and then l_value.is_integer then
						Result.set_expires_in (l_value.integer_type)
					end
				end
			end
		end

		--TODO add code to extract refresh_token

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
