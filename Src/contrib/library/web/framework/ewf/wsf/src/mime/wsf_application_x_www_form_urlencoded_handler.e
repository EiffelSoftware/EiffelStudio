note
	description: "Summary description for {WSF_APPLICATION_X_WWW_FORM_URLENCODED_HANDLER}."
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_APPLICATION_X_WWW_FORM_URLENCODED_HANDLER

inherit
	WSF_MIME_HANDLER

	WSF_MIME_HANDLER_HELPER

	WSF_VALUE_UTILITIES
		export
			{NONE} all
		end

feature -- Status report

	valid_content_type (a_content_type: HTTP_CONTENT_TYPE): BOOLEAN
		do
			Result := a_content_type.same_simple_type ({HTTP_MIME_TYPES}.application_x_www_form_encoded)
		end

feature -- Execution

	handle (a_content_type: HTTP_CONTENT_TYPE; req: WSF_REQUEST;
			a_vars: HASH_TABLE [WSF_VALUE, READABLE_STRING_GENERAL]; a_raw_data: detachable CELL [detachable READABLE_STRING_8])
		local
			l_content: READABLE_STRING_8
			n, p, i, j: INTEGER
			s: READABLE_STRING_8
			l_name, l_value: READABLE_STRING_8
		do
			l_content := full_input_data (req)
			if a_raw_data /= Void then
				a_raw_data.replace (l_content)
			end
			check content_count_same_as_content_length_if_not_chunked: (not req.is_chunked_input) implies (l_content.count = req.content_length_value.to_integer_32) end  --| FIXME: truncated value
			n := l_content.count
			if n > 0 then
				from
					p := 1
				until
					p = 0
				loop
					i := l_content.index_of ('&', p)
					if i = 0 then
						s := l_content.substring (p, n)
						p := 0
					else
						s := l_content.substring (p, i - 1)
						p := i + 1
					end
					if not s.is_empty then
						j := s.index_of ('=', 1)
						if j > 0 then
							l_name := s.substring (1, j - 1)
							l_value := s.substring (j + 1, s.count)
							add_percent_encoded_string_value_to_table (l_name, l_value, a_vars)
						end
					end
				end
			end
		end

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
