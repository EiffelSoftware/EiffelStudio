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

	SHARED_EDITOR_PREFERENCES
		export
			{NONE} all
		end

create
	make

feature -- Initialisation

	make(number: INTEGER) is
			-- Create a token composed of `number' spaces.
		local
			i: INTEGER
		do
			length := number
			create image.make(number)
			from i := 1 until i > number loop
				image.append_character(' ')
				i := i + 1
			end
		end

feature -- Miscellaneous

	display(d_y: INTEGER; dc: WEL_DC) is
		do
			--[ Don't display anything. If an option is set to see the spaces, 
			--  put it here ]
		end

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
		do
				-- Change drawing style here.
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)
			a_dc.select_font(font)

				-- Display the text.
			a_dc.text_out (position, d_y, image)

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			a_dc.unselect_font
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
			-- FIXME ARNAUD: can be done better than this....
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
			local_position: INTEGER
		do
				-- Save current drawing style
			old_text_color := a_dc.text_color
			old_background_color := a_dc.background_color
			local_position := position

				-- Change drawing style here.
			a_dc.select_font(font)

			-----------------------------------------------------------------------------------------

			if start_selection /= 1 then
					-- Set drawing style to "normal" text
				a_dc.set_text_color(text_color)
				a_dc.set_background_color(background_color)

					-- Display the beginning of the text.
				a_dc.text_out (local_position, d_y, image.substring(1,start_selection-1))
				local_position := local_position + a_dc.string_width(image.substring(1,start_selection-1))
			end

			-----------------------------------------------------------------------------------------

				-- Set drawing style to "selected" text
			a_dc.set_text_color(selected_text_color)
			a_dc.set_background_color(selected_background_color)

				-- Display the "selected" text.
			a_dc.text_out (local_position, d_y, image.substring(start_selection,end_selection-1))
			local_position := local_position + a_dc.string_width(image.substring(start_selection,end_selection-1))

			-----------------------------------------------------------------------------------------

			if end_selection <= length then
					-- Set drawing style to "normal" text
				a_dc.set_text_color(text_color)
				a_dc.set_background_color(background_color)

					-- Display the end of the text.
				a_dc.text_out (local_position, d_y, image.substring(end_selection,length))
			end

			-----------------------------------------------------------------------------------------

				-- Restore drawing style here.
			a_dc.set_text_color(old_text_color)
			a_dc.set_background_color(old_background_color)
			if font /= Void then
				a_dc.unselect_font
			end
		end

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

	font: WEL_FONT is
			-- Font used to draw the text
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

	font_width: INTEGER is
		local
			dc: WEL_MEMORY_DC
		once
			create dc.make
			dc.select_font(font)
			Result := dc.string_width(" ")
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

end -- class EDITOR_TOKEN_SPACE
