indexing
	description	: "Objects that represent one or several spaces"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SPACE

inherit
	EDITOR_TOKEN
		redefine
			display_selected,
			display_half_selected
		end

create
	make

feature -- Initialisation

	make(number: INTEGER) is
			-- Create a token composed of `number' spaces.
		do
			length := number
			create image.make(number)
			image.fill_character(' ')

			create alternate_image.make(number)
			alternate_image.fill_character(space_symbol)
		end

feature -- Display

	display(d_y: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := display_spaces(position, d_y, a_dc, False, 1, length)
		end

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := display_spaces(position, d_y, a_dc, True, 1, length)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
		local
			local_position: INTEGER
		do
			local_position := position

				-- if the selection do not start at the beginning of the token,
				-- display the first 'non selected' area
			if start_selection /= 1 then
				local_position := display_spaces(local_position, d_y, a_dc, False, 1, start_selection-1)
			end

				-- Display the 'selected' area
			local_position := display_spaces(local_position, d_y, a_dc, True, start_selection, end_selection-1)

				-- if the selection do not end at the end of the token,
				-- Display the last 'non selected' area
			if end_selection <= length then
				local_position := display_spaces(local_position, d_y, a_dc, False, end_selection,length)
			end
		end

feature -- Width & Height

	width: INTEGER is
		do
			Result := length * font_width
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
				-- The result can be easily computed since all
				-- the spaces have the same size.
			Result := n * font_width
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := a_width // font_width + 1
		end

feature {NONE} -- Implementation

	display_spaces(d_x, d_y: INTEGER; a_dc: WEL_DC; selected: BOOLEAN; char_start, char_end: INTEGER): INTEGER is
		local
			old_text_color		: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			the_text_color		: WEL_COLOR_REF
			the_background_color: WEL_COLOR_REF
			the_text			: STRING
		do
				-- Select the drawing style we will use.
			if editor_preferences.view_invisible_symbols then
				the_text := alternate_image.substring(char_start, char_end)
			else
				the_text := image.substring(char_start, char_end)
			end

			if selected then
				the_text_color := selected_text_color
				the_background_color := selected_background_color
			else
				the_text_color := text_color
				the_background_color := background_color
			end

				-- Backup old drawing style and set the new one.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			a_dc.set_text_color(the_text_color)
			a_dc.set_background_color(the_background_color)
			a_dc.select_font(font)

				-- Display the text.
			a_dc.text_out (d_x, d_y, the_text)
			Result := d_x + a_dc.string_width(the_text)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
		end

feature {NONE} -- Private Constants

	font_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
			create dc.make
			dc.select_font(font)
			Result := dc.string_width(" ")
			dc.unselect_font
		end

	space_symbol: CHARACTER is
		once
			Result := '·'
		end
	
	alternate_image: STRING
			-- String representation of what is displayed
			-- when the "invisible" symbols (spaces, end of lines
			-- & tabulations) are set to be visible.

end -- class EDITOR_TOKEN_SPACE
