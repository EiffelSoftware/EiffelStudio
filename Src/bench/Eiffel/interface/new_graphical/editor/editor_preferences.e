indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_PREFERENCES

inherit
	ANY
		redefine
			default_create
		end

feature -- Default Initialisation

	default_create is
			-- Default Initialisation
		do
			tabulation_spaces := 4
			font_name := "Courier New"
			font_size := 14
		end

feature -- Access

	tabulation_spaces: INTEGER
		-- number of spaces characters in a tabulation.

	font_name: STRING
		-- Name of the font used to display
		-- characters in the editor

	font_size: INTEGER
		-- Name of the font used to display
		-- characters in the editor

feature -- Element Change


	set_font_size(a_font_size: INTEGER) is
			-- Set `font_size' to `a_font_size'
		require
			a_font_size_valid: a_font_size > 0
		do
			font_size := a_font_size
		ensure
			font_size_set: font_size = a_font_size
		end

	set_font_name(a_font_name: STRING) is
			-- Set `font_name' to `a_font_name'
		require
			a_font_name_valid: a_font_name /= Void and then not a_font_name.empty
		do
			font_name := a_font_name
		ensure
			font_name_set: font_name = a_font_name
		end

	set_tabulation_spaces(number_of_spaces: INTEGER) is
			-- Set the number of spaces inside a tabulation
			-- to `number_of_spaces'.
		require
			number_of_spaces_valid: number_of_spaces >= 1 
		do
			tabulation_spaces := number_of_spaces
		ensure
			tabulation_spaces_set : tabulation_spaces = number_of_spaces
		end

end -- class SHARED_EDITOR_PREFERENCES
