indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(number: INTEGER) is
		local
			i: INTEGER
		do
			number_of_tabs := number
			create image.make(number)
			from i := 1 until i > number loop
				image.append_character('%T')
				i := i + 1
			end
			length := editor_preferences.tabulation_spaces * number_of_tabs
		end

feature -- Miscellaneous

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		local
			tabulation_width: INTEGER
		do
				-- Compute the number of pixel represented by a tabulation based on
				-- user preferences.
			tabulation_width := editor_preferences.tabulation_spaces * dc.string_width(" ")

				-- Handle first tabulation.
			Result := ((d_x // Tabulation_width) + 1 ) * Tabulation_width

				-- Handle next tabulations.
			Result := Result + Tabulation_width * (number_of_tabs - 1)

				-- update width
			width := Result - d_x
		end

feature {NONE} -- Implementation

	number_of_tabs: INTEGER

end -- class EDITOR_TOKEN_TABULATION
