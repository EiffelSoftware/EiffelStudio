indexing
	description	: "Objects that represent one or several spaces"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SPACE

inherit
	EDITOR_TOKEN_BLANK

create
	make

feature -- Initialisation

	make(number: INTEGER) is
			-- Create a token composed of `number' spaces.
		do
			length := number
			create image.make(number)
			image.fill_character(' ')
			width := length * space_width

			create alternate_image.make(number)
			alternate_image.fill_character(space_symbol)
		ensure
			image_not_void: image /= Void
			alternate_image_not_void: alternate_image /= Void
			length_positive: length > 0
		end

feature -- Width & Height

	width: INTEGER
-- is
--		do
--			Result := length * space_width
--		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
				-- The result can be easily computed since all
				-- the spaces have the same size.
			Result := n * space_width
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := a_width // space_width + 1
		end

feature {NONE} -- Implementation

	display_blanks(d_x, d_y: INTEGER; device: EV_PIXMAP; selected: BOOLEAN; char_start, char_end: INTEGER; panel: TEXT_PANEL): INTEGER is
		local
			the_text_color		: EV_COLOR
			the_background_color: EV_COLOR
			the_text			: STRING
		do
 				-- Select the drawing style we will use.
 			if panel.view_invisible_symbols then
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

 				-- Change the drawing style.
 			device.set_foreground_color(the_text_color)
 			device.set_font(font)
 
				-- Compute the width of the string. 
 			Result := d_x + font.string_width(the_text)

				-- Fill the rectangle occupied by the tabulation
			if the_background_color /= Void then
				device.set_background_color(the_background_color)
 				device.clear_rectangle(d_x, d_y, Result - d_x, height)
			end

 				-- Display the text.
 			device.draw_text_top_left (d_x, d_y + height // 8, the_text)
		end

feature {NONE} -- Private Constants

	space_width: INTEGER is
		do
			Result := font.string_width(" ")
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
