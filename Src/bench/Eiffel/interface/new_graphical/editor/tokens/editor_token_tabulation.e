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

	display(d_y: INTEGER; dc: WEL_DC) is
		do
			-- Display nothing
		end

	width: INTEGER is
		do
				-- Width of first tabulation.
			Result := ((position // tabulation_width) + 1 ) * tabulation_width - position

				-- Handle next tabulations.
			Result := Result + tabulation_width * (number_of_tabs - 1)
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 0 then
				Result := 0
			else
					-- Width of first tabulation.
				Result := (((position // tabulation_width) + 1 ) * tabulation_width ) - position

					-- Handle next tabulations.
				Result := Result + tabulation_width * (n - 1)
			end
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			width_first_tab: INTEGER
		do
			width_first_tab := (((position // tabulation_width) + 1 ) * tabulation_width ) - position

			if a_width < width_first_tab then
				Result := 1
			else
				Result := 2 + (a_width - width_first_tab) // tabulation_width
			end
		end

feature {NONE} -- Implementation

	number_of_tabs: INTEGER

	tabulation_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
				-- Compute the number of pixel represented by a tabulation based on
				-- user preferences.
			create dc.make
			dc.select_font(font)
			Result := editor_preferences.tabulation_spaces * dc.string_width(" ")
			dc.unselect_font
		end

	font: WEL_FONT is
			-- Font used to draw the text
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

end -- class EDITOR_TOKEN_TABULATION
