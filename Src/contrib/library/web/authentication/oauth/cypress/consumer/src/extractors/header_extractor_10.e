note
	description: "Summary description for {HEADER_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_EXTRACTOR_10

inherit
	HEADER_EXTRACTOR

	OAUTH_SHARED_ENCODER

feature -- Extractor

	extract (request: OAUTH_REQUEST): STRING_8
			-- Generates an OAuth 'Authorization' Http header to include in requests as the signature.
		require else
			has_oauth_parameters: not request.oauth_parameters.is_empty
		local
			l_parameters: HASH_TABLE [STRING_8, STRING_8]
			l_element: STRING_8
			l_encoder: OAUTH_ENCODER
		do
			l_parameters := request.oauth_parameters

			l_encoder := oauth_encoder
			create Result.make (l_parameters.count * Estimated_param_length)
			Result.append (Preamble)
			across
				l_parameters as ic
			loop
				if Result.count > Preamble.count then
					Result.append (Param_separator)
				end
				create l_element.make_from_string (Header_template)
				l_element.replace_substring_all ("$KEY", ic.key)
				l_element.replace_substring_all ("$VALUE", l_encoder.encoded_string (ic.item))
				Result.append (l_element)
				l_parameters.forth
			end
		end

feature {NONE} -- Implementation

	Param_separator: STRING = ", "

	Preamble: STRING = "OAuth "

	Estimated_param_length: INTEGER = 20

	Header_template: STRING = "$KEY=%"$VALUE%""

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
