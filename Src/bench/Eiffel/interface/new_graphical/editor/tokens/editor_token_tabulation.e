indexing
	description	: "Token that describe one or several tabulations."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

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
			length := number_of_tabs
		end

feature -- Miscellaneous

	Initialised: BOOLEAN
		-- debug purpose

	display(d_x: INTEGER; d_y: INTEGER; dc: WEL_DC): INTEGER is
		local
			tabulation_width: INTEGER
		do
			Initialised := True				-- debug purpose

				-- Compute the number of pixel represented by a tabulation based on
				-- user preferences.
			tabulation_width := editor_preferences.tabulation_spaces * dc.string_width(" ")

				-- Handle first tabulation.
			Result := ((d_x // Tabulation_width) + 1 ) * Tabulation_width
			width_first_tab := Result - d_x

				-- Handle next tabulations.
			Result := Result + Tabulation_width * (number_of_tabs - 1)

				-- update width
			width := Result - d_x
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		require
			Initialised
		do
			if n = 1 then
				Result := width_first_tab
			else
				Result := width_first_tab + Tabulation_width * (number_of_tabs - 1)
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			Initialised
		do
			if a_width < width_first_tab then
				Result := 1
			else
				Result := 2 + (a_width - width_first_tab) // Tabulation_width
			end
		end

feature {NONE} -- Implementation

	number_of_tabs: INTEGER

end -- class EDITOR_TOKEN_TABULATION
