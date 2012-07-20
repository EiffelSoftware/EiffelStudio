note
	description: "Represents a multi line string property."
	date: "$Date$"
	revision: "$Revision$"

class
	MULTILINE_STRING_PROPERTY

inherit
	DIALOG_PROPERTY [STRING_32]
		redefine
			dialog,
			convert_to_data
		end

create
	make

feature {NONE} -- Implementation

	dialog: detachable TEXT_EDITOR_DIALOG note option: stable attribute end

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			Result := a_string.twin
			Result.replace_substring_all ("%%N", "%N")
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
