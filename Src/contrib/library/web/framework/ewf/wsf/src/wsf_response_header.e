note
	description: "[
			 	Interface to build the http header associated with WSF_RESPONSE.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	WSF_RESPONSE_HEADER

inherit
	HTTP_HEADER_MODIFIER

	WSF_RESPONSE_EXPORTER -- to access WSF_RESPONSE.internal_header

create
	make_with_response

feature {NONE} -- Initialization

	make_with_response (res: WSF_RESPONSE)
		do
			response := res
		end

feature -- Access

	response: WSF_RESPONSE

feature -- Access

	new_cursor: INDEXABLE_ITERATION_CURSOR [READABLE_STRING_8]
			-- Fresh cursor associated with current structure.
		do
			Result := response.internal_header.new_cursor
		end

feature -- Header change: core

	add_header (h: READABLE_STRING_8)
			-- Add header `h'
			-- if it already exists, there will be multiple header with same name
			-- which can also be valid
		do
			response.add_header_line (h)
		end

	put_header (h: READABLE_STRING_8)
			-- Add header `h' or replace existing header of same header name
		do
			response.put_header_line (h)
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Javier Velilla, Olivier Ligot, Colin Adams, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
