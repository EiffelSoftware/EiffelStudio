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
			display_half_selected,
			pos_in_text,
			is_text,
			set_pos_in_text,
			update_width
		end

	DOUBLE_MATH

create
	make

feature -- Initialisation

	make(text: STRING; size_cell: CELL [INTEGER]) is
		require
--| FIXME VB Failed: text_valid: text /= Void and then text.count > 0
			no_eol_in_text: not text.has ('%N')
		do
			image := text
			length := text.count
			pos_in_text := -1
			tab_size_cell := size_cell
		ensure
			image_not_void: image /= Void
--| FIXME VB Failed: length_positive: length > 0
		end

feature -- Miscellaneous

	width: INTEGER
			-- Width in pixel of the entire token.

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		local
			i: INTEGER
		do
			if n = 0 then
				Result := 0
			else
				if image.has ('%T') then
					from
						i := 1
					until
						i > n or else i > image.count
					loop
						if image @ i = '%T' then
							Result := ((((position + Result) // tabulation_width) + 1 ) * tabulation_width ) - position
						else
							Result := Result + font.string_width(image.item (i).out)
						end
						i := i + 1 
					end
				else
					Result := font.string_width(image.substring(1,n))
				end
			end
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			current_position: INTEGER
			current_width	: INTEGER
			next_width	: INTEGER
		do
				-- precompute an estimation of the current_position
			current_position := (a_width // font.width).min (length)

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := get_substring_width (current_position)
				next_width := get_substring_width (current_position + 1)
			until
				a_width >= current_width and then a_width < next_width
			loop
				if a_width < current_width then
					current_position := current_position - 1
					next_width := current_width
					current_width := get_substring_width (current_position)
				else
					current_position := current_position + 1
					current_width := next_width
					next_width := get_substring_width (current_position + 1)
				end
			end

			Result := current_position + 1 -- We return a 1-based result (first character = 1)
		end

	display(d_y: INTEGER; device: EV_PIXMAP; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			if panel.text_is_fully_loaded then
				display_with_colors(d_y, text_color , background_color, device)
			else
				display_with_colors(d_y, gray_text_color , background_color, device)
			end

		end

	display_selected(d_y: INTEGER; device: EV_PIXMAP; panel: TEXT_PANEL) is
			-- Display the current token on device context `device'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		do
			display_with_colors(d_y, selected_text_color, selected_background_color, device)
		end

	display_half_selected (d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_PIXMAP; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beggining to `pivot'
		local
			local_position: INTEGER
			local_string: STRING
			text_width: INTEGER
			indx: INTEGER
			txt_color: EV_COLOR
		do
			local_position := position
			if panel.text_is_fully_loaded then
				txt_color := text_color
			else
				txt_color := gray_text_color
			end
				-- Change drawing style here.
			device.set_font(font)

			-- Draw unselected text (first part) ----------------------------------------------------

			if start_selection /= 1 then
				indx := image.index_of ('%T', 1)
				if indx > 0 and then indx < start_selection then
					local_string := expanded_image_substring (1, start_selection - 1)
				else
					local_string := image.substring (1, start_selection - 1)
				end
			
				text_width := get_substring_width(start_selection - 1)

					-- Set drawing style to "normal" text
				device.set_foreground_color(txt_color)
				if background_color /= Void then
					device.set_background_color(background_color)
					device.clear_rectangle (local_position, d_y, text_width, height)
				end

					-- Display the beginning of the text.
--! FIXME
				draw_text_top_left (local_position, d_y, local_string, device)
				local_position := local_position + text_width
			end

			-- Draw selected text -------------------------------------------------------------------

			indx := image.index_of ('%T', start_selection)
			if indx > 0 and then indx < end_selection then
				local_string := expanded_image_substring (start_selection, end_selection - 1)
			else
				local_string := image.substring (start_selection, end_selection - 1)
			end
			
			text_width := get_substring_width(end_selection - 1) - text_width

				-- Set drawing style to "selected" text
			device.set_foreground_color(selected_text_color)
			if selected_background_color /= Void then
				device.set_background_color(selected_background_color)
				device.clear_rectangle (local_position, d_y, text_width, height)
			end

				-- Display the "selected" text.
--! FIXME
		--	device.draw_text_top_left (local_position, d_y + height // 8, local_string)
			draw_text_top_left (local_position, d_y, local_string, device)

			local_position := local_position + text_width

			-- Draw unselected text (last part) -----------------------------------------------------

			if end_selection <= length then

				if image.index_of ('%T', end_selection) > 0 then
					local_string := expanded_image_substring (end_selection, length)
				else
					local_string := image.substring (end_selection, length)
				end
			
				text_width := get_substring_width(length) - text_width

					-- Set drawing style to "normal" text
				device.set_foreground_color(txt_color)
				if background_color /= Void then
					device.set_background_color(background_color)
					device.clear_rectangle (local_position, d_y, text_width, height)
				end

					-- Display the end of the text.
--! FIXME
--				device.draw_text_top_left (local_position, d_y + height // 8, local_string)

				draw_text_top_left (local_position, d_y, local_string, device)
			end
		end

feature {EB_CLASS_INFO_ANALYZER} -- implementation of clickable and editable text

	is_text: BOOLEAN is True

	pos_in_text: INTEGER 
			-- position of the token in the text in characters
			-- Warning: To be used only by EB_CLICK_LIST

	set_pos_in_text (pit: INTEGER) is
			-- assign `pit' to `pos_in_text'
		do
			pos_in_text := pit
		end 

feature {NONE} -- Implementation

	display_with_colors(d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_PIXMAP) is
		local
			text_to_be_drawn: STRING

		do
			if image.has ('%T') then
				text_to_be_drawn := expanded_image_substring (1, image.count)
			else
				text_to_be_drawn := image
			end

 				-- Change drawing style here.
 			device.set_font (font)
			device.set_foreground_color (a_text_color)

			if a_background_color /= Void then
				device.set_background_color (a_background_color)
				device.clear_rectangle (position, d_y, get_substring_width (image.count), height)
			end
			
 				-- Display the text.
 			draw_text_top_left (position, d_y, text_to_be_drawn, device)
		end

feature {NONE} -- Implementation

	update_width is
			-- update value of `width'
		do
			width := get_substring_width(image.count)
		end

	expanded_image_substring (n1, n2: INTEGER): STRING is
		local
			sz, i, j: INTEGER
		do
			create Result.make (n2 - n1 + 1)
			from
				i := n1
			until
				i > n2
			loop	
				if image @ i = '%T' then
					sz := (get_substring_width (i) -  get_substring_width (i - 1)) // font.string_width(" ")
					from
						j := 1
					until
						j > sz
					loop
						Result.extend (' ')
						j := j + 1
					end
				else
					Result.extend (image @ i)
				end
				i := i + 1
			end
		end


	tabulation_width: INTEGER is
		do
				-- Compute the number of pixels represented by a tabulation based on
				-- user preferences number of spaces per tabulation.
			Result := tab_size_cell.item * font.string_width(" ")
		end

	gray_text_color: EV_COLOR is
		local
			lightness: REAL
		do
			lightness := sqrt (text_color.lightness)
			create Result.make_with_rgb (lightness, lightness, lightness)
		end			

	tab_size_cell: CELL [INTEGER]

end -- class EDITOR_TOKEN
