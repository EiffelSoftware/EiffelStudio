indexing
	description	: "Token that describe a generic text."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_TEXT

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

	make(text: STRING) is
		require
			text_valid: text /= Void and then text.count > 0
		do
			image := text
			length := text.count
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Miscellaneous

	width: INTEGER is
		do
			dc.select_font(font)
			Result := dc.string_width(image)
			dc.unselect_font
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 0 then
				Result := 0
			else
				dc.select_font(font)
				Result := dc.string_width(image.substring(1,n))
				dc.unselect_font
			end
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			space_width: INTEGER
			current_position: INTEGER
			current_width: INTEGER
			next_width: INTEGER
		do
			dc.select_font(font)

				-- precompute an estimation of the current_position
			space_width := dc.string_width(" ")
			current_position := a_width // space_width

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := dc.string_width(image.substring(1,current_position))
				next_width := dc.string_width(image.substring(1,current_position+1))
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := dc.string_width(image.substring(1,current_position))
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := dc.string_width(image.substring(1,current_position+1))
				end
			end
			dc.unselect_font

			Result := current_position + 1 -- We return a 1-based result (first character = 1)
		end

	display(d_y: INTEGER; a_dc: WEL_DC) is
		do
			display_with_colors(d_y, text_color, background_color, a_dc)
		end

	display_selected(d_y: INTEGER; a_dc: WEL_DC) is
		do
			display_with_colors(d_y, selected_text_color, selected_background_color, a_dc)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; a_dc: WEL_DC) is
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

feature {NONE} -- Implementation

	display_with_colors(d_y: INTEGER; a_text_color: WEL_COLOR_REF; a_background_color: WEL_COLOR_REF; a_dc: WEL_DC) is
		local
			old_text_color: WEL_COLOR_REF
			old_background_color: WEL_COLOR_REF
		do
				-- Change drawing style here.
			if a_text_color /= Void then
				old_text_color := a_dc.text_color
				a_dc.set_text_color(a_text_color)
			end
			if a_background_color /= Void then
				old_background_color := a_dc.background_color
				a_dc.set_background_color(a_background_color)
			end
			if font /= Void then
				a_dc.select_font(font)
			end

				-- Display the text.
			a_dc.text_out (position, d_y, image)

				-- Restore drawing style here.
			if text_color /= Void then
				a_dc.set_text_color(old_text_color)
			end
			if background_color /= Void then
				a_dc.set_background_color(old_background_color)
			end
			if font /= Void then
				a_dc.unselect_font
			end
		end

feature {NONE} -- Properties used to display the token

	font: WEL_FONT is
		local
			log_font: WEL_LOG_FONT
		once
				-- create the font
			create log_font.make(editor_preferences.font_size, editor_preferences.font_name)
			create Result.make_indirect(log_font)
		end

	dc: WEL_MEMORY_DC is
		once
			create Result.make
		end


end -- class EDITOR_TOKEN
