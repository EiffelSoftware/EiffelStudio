note
	description: "Same as {PLAIN_TEXT_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	PLAIN_TEXT_FILE_32

inherit
	PLAIN_TEXT_FILE
		rename
			make as old_make,
			make_with_name as make
		end

create
	make,
	make_with_path

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
