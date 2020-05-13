note
	description: "[
				Provides a few helpful feature to respond predefined message to the client
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_HANDLER_HELPER

inherit
	ANY

feature -- Helper

	execute_content_type_not_allowed (req: WSF_REQUEST; res: WSF_RESPONSE; a_content_types: detachable ARRAY [STRING]; a_uri_formats: detachable ARRAY [STRING])
		local
			accept_s, uri_s: detachable STRING
			i, n: INTEGER
		do
			if a_content_types /= Void then
				create accept_s.make (10)
				from
					i := a_content_types.lower
					n := a_content_types.upper
				until
					i > n
				loop
					accept_s.append_string (a_content_types[i])
					if i < n then
						accept_s.append_character (',')
						accept_s.append_character (' ')
					end
					i := i + 1
				end
			else
				accept_s := "*/*"
			end

			if a_uri_formats /= Void then
				create uri_s.make (10)
				from
					i := a_uri_formats.lower
					n := a_uri_formats.upper
				until
					i > n
				loop
					uri_s.append_string (a_uri_formats[i])
					if i < n then
						uri_s.append_character (',')
						uri_s.append_character (' ')
					end
					i := i + 1
				end
			end
			res.put_header ({HTTP_STATUS_CODE}.unsupported_media_type, 
					{ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} << 
						["Content-Type", "text/plain"], ["Accept", accept_s]
					>>
				)
			if accept_s /= Void then
				res.put_string ("Unsupported request content-type, Accept: " + accept_s + "%N")
			end
			if uri_s /= Void then
				res.put_string ("Unsupported request format from the URI: " + uri_s + "%N")
			end
		end

	execute_request_method_not_allowed (req: WSF_REQUEST; res: WSF_RESPONSE; a_methods: ITERABLE [STRING])
		local
			s: STRING
		do
			create s.make (25)
			across
				a_methods as c
			loop
				if not s.is_empty then
					s.append_character (',')
					s.append_character (' ')
				end
				s.append_string (c.item)
			end
			res.put_header ({HTTP_STATUS_CODE}.method_not_allowed,
					{ARRAY [TUPLE [READABLE_STRING_8, READABLE_STRING_8]]} <<
						["Content-Type", {HTTP_MIME_TYPES}.text_plain],
						["Allow", s]
					>>)
			res.put_string ("Unsupported request method, Allow: " + s + "%N")
		end

note
	copyright: "2011-2012, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
