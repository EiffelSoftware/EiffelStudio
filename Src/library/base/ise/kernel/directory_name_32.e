note
	description: "Directory name abstraction based on {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class DIRECTORY_NAME_32

inherit
	PATH_NAME_32

create
	make_from_string,
	make_from_path

convert
	to_string_32: {STRING_32, READABLE_STRING_GENERAL, READABLE_STRING_32}

feature {NONE} -- Creation

	make_from_string (s: READABLE_STRING_32)
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			create {DIRECTORY_NAME} path_name.make_from_string (u.string_32_to_utf_8_string_8 (s))
		end

;note
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
