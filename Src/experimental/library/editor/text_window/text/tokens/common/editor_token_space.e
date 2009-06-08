note
	description	: "Objects that represent one or several spaces"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (number: INTEGER)
			-- Create a token composed of `number' spaces.
		do
			length := number
			create wide_image.make (number)
			wide_image.fill_character(' ')
			width := length * space_width

			create alternate_image.make(number)
			alternate_image.fill_character(space_symbol)
		ensure
			image_not_void: wide_image /= Void
			alternate_image_not_void: alternate_image /= Void
			length_positive: length > 0
		end

feature -- Width & Height

	width: INTEGER

	get_substring_width (n: INTEGER): INTEGER
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
				-- The result can be easily computed since all
				-- the spaces have the same size.
			Result := n * space_width
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := a_width // space_width + 1
		end

	update_width
			-- update value of `width'
		do
			-- FIXME: take into account if invisible symbols are displayed or not to compute the correct width
			width := get_substring_width (length)
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		do
			a_visitor.process_editor_token_space (Current)
		end

feature {NONE} -- Implementation

	display_blanks (d_x, d_y: INTEGER; device: EV_DRAWABLE; selected: BOOLEAN; char_start, char_end: INTEGER; panel: TEXT_PANEL): INTEGER
		local
			the_text_color		: EV_COLOR
			the_background_color: EV_COLOR
			l_count: INTEGER
		do
 			if selected then
 				if panel.has_focus then
	 				the_text_color := selected_text_color
	 				the_background_color := selected_background_color
	 			else
	 				the_text_color := text_color
	 				the_background_color := focus_out_selected_background_color
 				end
 			else
 				the_text_color := text_color
 				the_background_color := background_color
 			end

 				-- Change the drawing style.
 			device.set_foreground_color(the_text_color)
 			device.set_font(font)

				-- Compute the width of the string.
			l_count := char_end - char_start + 1
 			Result := d_x + l_count * space_width

				-- Fill the rectangle occupied by the tabulation
			if the_background_color /= Void then
				device.set_background_color(the_background_color)
 				device.clear_rectangle(d_x, d_y, Result - d_x, height)
			end

 				-- Display the text with the selected drawing style if needed.
			if l_count > 0 then
				if panel.view_invisible_symbols then
					device.draw_text_top_left (d_x, d_y, alternate_image.substring (char_start, char_end))
				elseif length < 11 then
					device.draw_text_top_left (d_x, d_y, space_images.item (l_count))
				else
					device.draw_text_top_left (d_x, d_y, wide_image.substring (char_start, char_end))
				end
			end
		end

feature {NONE} -- Private Constants

	space_width: INTEGER
		do
			if is_fixed_width then
				Result := font_width
			else
				Result := font.string_width (once " ")
			end
		end

	space_symbol: CHARACTER_32
		once
			Result := '�'
		end

	alternate_image: like wide_image
			-- String representation of what is displayed
			-- when the "invisible" symbols (spaces, end of lines
			-- & tabulations) are set to be visible.

	space_images: SPECIAL [STRING_32]
			-- Quick look up for `wide_image' when count is 10 or less
		once
			create Result.make_empty (11)
			Result.extend ("")
			Result.extend (" ")
			Result.extend ("  ")
			Result.extend ("   ")
			Result.extend ("    ")
			Result.extend ("     ")
			Result.extend ("      ")
			Result.extend ("       ")
			Result.extend ("        ")
			Result.extend ("         ")
			Result.extend ("          ")
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITOR_TOKEN_SPACE
