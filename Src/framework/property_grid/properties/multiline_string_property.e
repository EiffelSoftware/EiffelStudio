indexing
	description: "Represents a multi line string property."
	date: "$Date$"
	revision: "$Revision$"

class
	MULTILINE_STRING_PROPERTY

inherit
	DIALOG_PROPERTY [STRING_32]
		redefine
			dialog
		end

create
	make

feature {NONE} -- Implementation

	dialog: TEXT_EDITOR_DIALOG

end
