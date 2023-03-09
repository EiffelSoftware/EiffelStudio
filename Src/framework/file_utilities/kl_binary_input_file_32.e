note
	description: "Same as {KL_BINARY_INPUT_FILE} with names in {STRING_32}."
	date: "$Date$"
	revision: "$Revision$"

class
	KL_BINARY_INPUT_FILE_32

inherit
	KL_BINARY_INPUT_FILE
		rename
			make as kl_make
		export
			{ANY} path
		redefine
			make_with_path
		end

create
	make, make_with_path

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
			-- Create a new file named `a_name'.
			-- (`a_name' should follow the pathname convention
			-- of the underlying platform. For pathname conversion
			-- use KI_FILE_SYSTEM.pathname_from_file_system.)
		do
			kl_make ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (a_name))
		end

	make_with_path (a_path: PATH)
			-- <Precursor>
		local
			u: UTF_CONVERTER
		do
			create last_string.make_empty
			name := u.utf_32_string_to_utf_8_string_8 (a_path.name)
			Precursor (a_path)
		end

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
