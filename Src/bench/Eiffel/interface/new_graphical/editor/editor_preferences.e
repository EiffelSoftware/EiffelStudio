indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_PREFERENCES

feature -- Access

	tabulation_spaces: INTEGER
		-- number of spaces characters in a tabulation.

feature -- Element Change

	set_tabulation_spaces(number_of_spaces: INTEGER) is
		do
			tabulation_spaces := number_of_spaces
		end

end -- class SHARED_EDITOR_PREFERENCES
