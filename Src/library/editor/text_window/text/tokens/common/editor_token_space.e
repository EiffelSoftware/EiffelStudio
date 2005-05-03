indexing
	description	: "Objects that represent one or several spaces"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_SPACE

inherit
	EDITOR_TOKEN_BLANK
		redefine
			update_width
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

	get_substring_width (n: INTEGER): INTEGER is
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

	update_width is
			-- update value of `width'
		do
			-- FIXME: take into account if invisible symbols are displayed or not to compute the correct width
			width := get_substring_width (length)
		end
	
feature {NONE} -- Implementation

	display_blanks (d_x, d_y: INTEGER; device: EV_DRAWABLE; selected: BOOLEAN; char_start, char_end: INTEGER; panel: TEXT_PANEL): INTEGER is
		local
			the_text_color		: EV_COLOR
			the_background_color: EV_COLOR
			the_text			: STRING
		do
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
 			Result := d_x + (char_end - char_start + 1) * space_width

				-- Fill the rectangle occupied by the tabulation
			if the_background_color /= Void then
				device.set_background_color(the_background_color)
 				device.clear_rectangle(d_x, d_y, Result - d_x, height)
			end

 				-- Display the text with the selected drawing style.
			if panel.view_invisible_symbols then
 				device.draw_text_top_left (d_x, d_y, alternate_image.substring (char_start, char_end))
			else
				if length < 11 then
					device.draw_text_top_left (d_x, d_y, space_image_hash.item (char_end - char_start + 1))
				else
					device.draw_text_top_left (d_x, d_y, image.substring (char_start, char_end))
				end
			end
		end

feature {NONE} -- Private Constants

	space_width: INTEGER is
		do
			if is_fixed_width then
				Result := font_width
			else
				Result := font.string_width (once " ")
			end
		end

	space_symbol: CHARACTER is
		once
			Result := '·'
		end
	
	alternate_image: STRING
			-- String representation of what is displayed
			-- when the "invisible" symbols (spaces, end of lines
			-- & tabulations) are set to be visible.

	space_image_hash: HASH_TABLE [STRING, INTEGER] is
			-- Hash of images for quick look up when count is 10 or less
		once
			create Result.make (10)
			Result.put (" ", 1)
			Result.put ("  ", 2)
			Result.put ("   ", 3)
			Result.put ("    ", 4)
			Result.put ("     ", 5)
			Result.put ("      ", 6)
			Result.put ("       ", 7)
			Result.put ("        ", 8)
			Result.put ("         ", 9)
			Result.put ("          ", 10)
		end

end -- class EDITOR_TOKEN_SPACE
