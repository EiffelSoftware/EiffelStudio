indexing
	description	: "Token that describe one or several tabulations."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TABULATION

inherit
	EDITOR_TOKEN
		redefine
			display_selected,
			display_half_selected
		end

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

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			displayed_string: STRING
		do
				-- Change drawing style here.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)
			a_dc.select_font(font)

				-- Display the text.
			create displayed_string.make(editor_preferences.tabulation_spaces * number_of_tabs)
			displayed_string.fill_character(' ')
			a_dc.text_out (position, d_y, displayed_string)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			displayed_string: STRING
			local_position: INTEGER
		do
				-- Backup current drawing style.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			local_position := position

				-- Change drawing style here.
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)
			a_dc.select_font(font)

			local_position := local_position + get_substring_width(start_selection-1)

				-- Display the text.
			create displayed_string.make(editor_preferences.tabulation_spaces * (end_selection-start_selection))
			displayed_string.fill_character(' ')
			a_dc.text_out (local_position, d_y, displayed_string)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
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

	font_height: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
			create dc.make
			dc.select_font(font)
			Result := dc.string_height(" ")
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
