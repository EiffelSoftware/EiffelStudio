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

create
	make

feature -- Initialisation

	make(text: STRING) is
		require
			text_valid: text /= Void and then text.count > 0
		do
			image := text
			length := text.count
			width := font.string_width(image)
		ensure
			image_not_void: image /= Void
			length_positive: length > 0
		end

feature -- Miscellaneous

	width: INTEGER
			-- Width in pixel of the entire token.
--		do
--			Result := font.string_width(image)
--		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 0 then
				Result := 0
			else
				Result := font.string_width(image.substring(1,n))
			end
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			current_position: INTEGER
			current_width	: INTEGER
			next_width		: INTEGER
		do
				-- precompute an estimation of the current_position
			current_position := a_width // font.width

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := font.string_width(image.substring(1,current_position))
				next_width := font.string_width(image.substring(1,current_position+1))
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := font.string_width(image.substring(1,current_position))
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := font.string_width(image.substring(1,current_position+1))
				end
			end

			Result := current_position + 1 -- We return a 1-based result (first character = 1)
		end

	display(d_y: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			display_with_colors(d_y, text_color, background_color, device)
		end

	display_selected(d_y: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		do
			display_with_colors(d_y, selected_text_color, selected_background_color, device)
		end

	display_half_selected(d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_PIXMAP) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beggining to `pivot'
		local
			old_text_color: EV_COLOR
			old_background_color: EV_COLOR
			local_position: INTEGER
			local_string: STRING
			text_width: INTEGER
		do
			local_position := position

				-- Change drawing style here.
			device.set_font(font)

			-- Draw unselected text (first part) ----------------------------------------------------

			if start_selection /= 1 then
				local_string := image.substring(1,start_selection-1)
				text_width := font.string_width(local_string)

					-- Set drawing style to "normal" text
				device.set_foreground_color(text_color)
				if background_color /= Void then
					device.set_background_color(background_color)
					device.clear_rectangle (local_position, d_y, local_position + text_width, d_y + font.height)
				end

					-- Display the beginning of the text.
				device.draw_text (local_position, d_y, local_string)
				local_position := local_position + text_width
			end

			-- Draw selected text -------------------------------------------------------------------

			local_string := image.substring(start_selection,end_selection-1)
			text_width := font.string_width(local_string)

				-- Set drawing style to "selected" text
			device.set_foreground_color(selected_text_color)
			if selected_background_color /= Void then
				device.set_background_color(selected_background_color)
				device.clear_rectangle (local_position, d_y, local_position + text_width, d_y + font.height)
			end

				-- Display the "selected" text.
			device.draw_text (local_position, d_y, local_string)
			local_position := local_position + text_width

			-- Draw unselected text (last part) -----------------------------------------------------

			if end_selection <= length then

				local_string := image.substring(end_selection,length)
				text_width := font.string_width(local_string)

					-- Set drawing style to "normal" text
				device.set_foreground_color(text_color)
				if background_color /= Void then
					device.set_background_color(background_color)
				device.clear_rectangle (local_position, d_y, local_position + text_width, d_y + font.height)
				end

					-- Display the end of the text.
				device.draw_text (local_position, d_y, local_string)
			end
		end

feature {NONE} -- Implementation

	display_with_colors(d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_PIXMAP) is
		do
 				-- Change drawing style here.
 			device.set_font(font)
			device.set_foreground_color(a_text_color)

			if a_background_color /= Void then
				device.set_background_color(a_background_color)
				device.clear_rectangle (position, d_y, position + font.string_width(image), d_y + font.height)
			end

 				-- Display the text.
 			device.draw_text (position, d_y, image)
		end

feature {NONE} -- Properties used to display the token

end -- class EDITOR_TOKEN
