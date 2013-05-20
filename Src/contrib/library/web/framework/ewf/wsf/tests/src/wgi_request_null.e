note
	description: "Summary description for {WGI_REQUEST_NULL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WGI_REQUEST_NULL

inherit
	WGI_REQUEST_FROM_TABLE
		rename
			make as wgi_request_from_table_make
		end

create
	make_with_file,
	make_with_body

feature {NONE} -- Initialization

	make_with_file (a_meta: ITERABLE [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]; f: FILE)
		local
			ht: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			i: WGI_NULL_FILE_INPUT_STREAM
			c: WGI_NULL_CONNECTOR
		do
			create c.make
			create i.make (f)
			create ht.make (10)
			across
				a_meta as curs
			loop
				ht.force (curs.item.value, curs.item.name)
			end
			wgi_request_from_table_make (ht, i, c)
		end

	make_with_body (a_meta: ITERABLE [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_8]]; s: READABLE_STRING_8)
		local
			ht: HASH_TABLE [READABLE_STRING_8, READABLE_STRING_8]
			i: WGI_NULL_STRING_INPUT_STREAM
			c: WGI_NULL_CONNECTOR
		do
			create c.make
			create i.make (s)
			create ht.make (10)
			across
				a_meta as curs
			loop
				ht.force (curs.item.value, curs.item.name)
			end
			wgi_request_from_table_make (ht, i, c)
		end

note
	copyright: "2011-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
