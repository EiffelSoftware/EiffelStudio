note
	description: "[
					String used by cURL wrapper library.
					Only added features from IDENTIFIED.
																					]"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CURL_STRING

inherit
	STRING
		select
			is_equal,
			copy,
			out
		end

	IDENTIFIED
		rename
			is_equal as identified_is_equal,
			copy as identified_copy,
			out as identified_out
		end

create
	make,
	make_empty,
	make_filled,
	make_from_string,
	make_from_c_pointer,
	make_from_cil

note
	library:   "cURL: Library of reusable components for Eiffel."
	copyright: "Copyright (c) 1984-2006, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			356 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

