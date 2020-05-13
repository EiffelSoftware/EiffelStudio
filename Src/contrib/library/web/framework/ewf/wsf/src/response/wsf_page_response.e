note
	description: "[

		]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_PAGE_RESPONSE

inherit
	WSF_RESPONSE_MESSAGE

create
	make,
	make_with_body

convert
	make_with_body ({STRING_8})

feature {NONE} -- Initialization

	make
		do
			status_code := {HTTP_STATUS_CODE}.ok
			create header.make
		end

	make_with_body (a_body: STRING_8)
			-- Initialize `body` with `a_body`.
			-- Note: it mays not be the same object.
		do
			make
			body := a_body
		end

feature -- Status

	status_code: INTEGER

feature -- Header

	header: HTTP_HEADER

	body: detachable STRING_8

feature -- Element change

	put_header (a_status_code: INTEGER; a_headers: detachable ARRAY [TUPLE [key: READABLE_STRING_8; value: READABLE_STRING_8]])
			-- Send headers with status `a_status', and headers from `a_headers'
		do
			set_status_code (a_status_code)
			if a_headers /= Void then
				header.append_array (a_headers)
			end
		end

	set_status_code (c: like status_code)
		do
			status_code := c
		end

	set_body (a_body: like body)
		do
			body := a_body
		ensure
			body_set: a_body /= Void implies body = a_body
		end

	put_string (a_string: READABLE_STRING_8)
			-- Append `a_string' to `body'
		local
			l_body: like body
		do
			l_body := body
			if l_body = Void then
				create l_body.make (a_string.count)
				set_body (l_body)
			end
			l_body.append (a_string)
		end

feature {WSF_RESPONSE} -- Output

	send_to (res: WSF_RESPONSE)
		local
			b: like body
			h: like header
		do
			h := header
			b := body
			res.set_status_code (status_code)

			if b /= Void then
				if not h.has_content_length then
					h.put_content_length (b.count)
				end
				if not h.has_content_type then
					h.put_content_type_text_plain
				end
			end
			res.put_header_lines (h)
			if b /= Void then
				res.put_string (b)
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
