note
	description: "Summary description for {HEADER_EXTRACTOR_10}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER_EXTRACTOR_10

inherit

	HEADER_EXTRACTOR

feature -- Extractor

	extract (request: OAUTH_REQUEST): READABLE_STRING_GENERAL
			-- Generates an OAuth 'Authorization' Http header to include in requests as the signature.
		require else
			has_oauth_parameters: not request.outh_parameters.is_empty
		local
			l_parameters : STRING_TABLE[STRING]
			header: STRING_32
			l_element : STRING_32
			l_encoder : OAUTH_ENCODER
			l_keys : ARRAY [READABLE_STRING_GENERAL]
		do
			l_parameters := request.outh_parameters
			l_keys := sort (l_parameters.current_keys)

			create l_encoder
			create header.make (l_parameters.count * Estimated_param_length)
			header.append (Preamble)
			from
--				l_index := 1
				l_parameters.start
			until
--				l_index > l_keys.count
				l_parameters.after
			loop
				if header.count > Preamble.count then
					header.append (Param_separator)
				end
				create l_element.make_from_string (Header_template)
				l_element.replace_substring_all ("$KEY", l_parameters.key_for_iteration.as_string_8)
				l_element.replace_substring_all ("$VALUE", l_encoder.encoded_string (l_parameters.item_for_iteration.as_string_8))
--				l_element.replace_substring_all ("$KEY", l_keys[l_index].as_string_8)
--				if attached {STRING_8} l_parameters.at (l_keys[l_index].as_string_8) as l_value then
--					l_element.replace_substring_all ("$VALUE", l_encoder.encoded_string (l_value.as_string_8))
--				end
				header.append (l_element)
				l_parameters.forth
--				l_index := l_index + 1
			end
			Result := header
		end


feature {NONE} -- Implementation

	Param_separator: STRING = ", "

	Preamble: STRING = "OAuth "

	Estimated_param_length: INTEGER = 20

	Header_template: STRING = "$KEY=%"$VALUE%""


	sort (keys : ARRAY [READABLE_STRING_GENERAL]): ARRAY [READABLE_STRING_GENERAL]
		local
			l_sort: QUICK_SORTER [READABLE_STRING_GENERAL]
			l_comp: COMPARABLE_COMPARATOR [READABLE_STRING_GENERAL]
		do
			Result := keys.twin
			create l_comp
			create l_sort.make (l_comp)
			l_sort.sort (Result)
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
