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

	dialog: TEXT_EDITOR_DIALOG

	convert_to_data (a_string: like displayed_value): like value
			-- Convert displayed data into data.
		do
			Result := a_string.twin
			Result.replace_substring_all ("%%N", "%N")
		end

end
