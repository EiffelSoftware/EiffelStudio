indexing
	description	: "Token that describe a generic text."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	make (text: STRING) is
		require
			no_eol_in_text: not text.has ('%N')
		do
			image := text
			length := text.count
			pos_in_text := -1
		ensure
			image_not_void: image /= Void
		end

feature -- Miscellaneous

	width: INTEGER
			-- Width in pixel of the entire token.

	get_substring_width (n: INTEGER): INTEGER is
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		local
			i, l_font_width, l_tab_position, l_tab_width: INTEGER
			l_string: STRING
			l_is_fixed: BOOLEAN
		do
			if n = 0 then
				Result := 0
			else
				l_is_fixed := is_fixed_width
				if image.has ('%T') then
					if previous /= Void and then not previous.is_margin_token then
						l_tab_position := previous.position + previous.width
					end
					from
						i := 1
						if l_is_fixed then
							l_font_width := font_width
						else
							create l_string.make_filled (' ', 1)						
						end
						l_tab_width := tabulation_width
					until
						i > n or else i > image.count
					loop
						if image @ i = '%T' then
							Result := ((((l_tab_position + Result) // l_tab_width) + 1 ) * l_tab_width ) - l_tab_position
						else							
							if l_is_fixed then
								Result := Result + l_font_width
							else								
								l_string.put (image.item (i), 1)
								Result := Result + font.string_width (l_string)
							end
						end
						i := i + 1
					end
				else
					if l_is_fixed then
						Result := Result + (n.min (image.count) * font_width)
					else
						Result := font.string_width (image.substring (1, n.min (image.count)))
					end
				end
			end
		end

	retrieve_position_by_width (a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		local
			current_position: INTEGER
			current_width	: INTEGER
			next_width	: INTEGER
			l_count: INTEGER
		do
				-- precompute an estimation of the current_position
			current_position := (a_width // font.width).min (length)

				-- We have now to check that our current position is the good one.
				-- If we are above, we decrease current_position, and the opposite.
			from
				current_width := get_substring_width (current_position)
				next_width := get_substring_width (current_position + 1)
				l_count := image.count
			until
				(a_width >= current_width and then a_width < next_width) or current_position > l_count
			loop
				if a_width < current_width then
					current_position := current_position - 1
--					check
--						current_position_positive: current_position > 0
--					end
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

	display(d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do
			if panel.text_is_fully_loaded then
				display_with_colors (d_y, text_color , background_color, device)
			else
				display_with_colors (d_y, gray_text_color , background_color, device)
			end
		end
		
	display_with_offset (x_offset, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`x_offset',`d_y')
		do
			if panel.text_is_fully_loaded then
				display_with_colors_offset (x_offset, d_y, text_color , background_color, device)
			else
				display_with_colors_offset (x_offset, d_y, gray_text_color , background_color, device)
			end
		end

	display_selected(d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `device'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		do
			if panel.has_focus then
				display_with_colors(d_y, selected_text_color, selected_background_color, device)
			else
				display_with_colors(d_y, text_color, focus_out_selected_background_color, device)
			end
		end

	display_half_selected (d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beginning to `pivot'		
		local
			local_position,
			l_start,
			l_end: INTEGER
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

			l_start := start_selection
			l_end := end_selection

			if l_start /= 1 then
				indx := image.index_of ('%T', 1)
				if indx > 0 and then indx < l_start then
					local_string := expanded_image_substring (1, l_start - 1)
				else
					local_string := image.substring (1, l_start - 1)
				end
			
				text_width := get_substring_width (l_start - 1)			

					-- Set drawing style to "normal" text
				device.set_foreground_color(txt_color)
				if background_color /= Void then
					device.set_background_color(background_color)
					device.clear_rectangle (local_position, d_y, text_width, height)
				end

					-- Display the beginning of the text.
				draw_text_top_left (local_position, d_y, local_string, device)
				local_position := local_position + text_width
			end

			-- Draw selected text -------------------------------------------------------------------

			indx := image.index_of ('%T', l_start)
			if l_start > l_end then
				if indx > 0 and then indx < l_end then
					local_string := expanded_image_substring (l_end, l_start - 1)
				else
					local_string := image.substring (l_end, l_start - 1)
				end				
			else
				if indx > 0 and then indx < l_end then
					local_string := expanded_image_substring (l_start, l_end - 1)
				else
					local_string := image.substring (l_start, l_end - 1)
				end
			end			
			
			text_width := get_substring_width (l_end - 1) - text_width
			if text_width < 0 then
				local_position := local_position - text_width.abs
			end
			text_width := text_width.abs		
	
				-- Set drawing style to "selected" text
			if panel.has_focus then
				device.set_foreground_color(selected_text_color)
			else
				device.set_foreground_color(text_color)
			end			
			if selected_background_color /= Void then
				if panel.has_focus then
					device.set_background_color (selected_background_color)
				else
					device.set_background_color (focus_out_selected_background_color)
				end
				if text_width >= 0 then
					device.clear_rectangle (local_position, d_y, text_width, height)
				end
			end

				-- Display the "selected" text.
			draw_text_top_left (local_position, d_y, local_string, device)

			local_position := local_position + text_width

			-- Draw unselected text (last part) -----------------------------------------------------

			if l_end <= length then

				if l_start > l_end then
					if image.index_of ('%T', start_selection) > 0 then
						local_string := expanded_image_substring (l_start, length)
					else
						local_string := image.substring (l_start, length)
					end	
				else
					if image.index_of ('%T', end_selection) > 0 then
						local_string := expanded_image_substring (l_end, length)
					else
						local_string := image.substring (l_end, length)
					end
				end
							
				text_width := get_substring_width(length) - text_width

					-- Set drawing style to "normal" text
				device.set_foreground_color(txt_color)
				if background_color /= Void then
					device.set_background_color (background_color)
					check
						text_valid: text_width >= 0
					end
					device.clear_rectangle (local_position, d_y, text_width, height)
					end

					-- Display the end of the text
				draw_text_top_left (local_position, d_y, local_string, device)
			end
		end

feature -- Status Setting

	update_width is
			-- update value of `width'
		do
			width := get_substring_width (image.count)
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

	display_with_colors(d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_DRAWABLE) is
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
		
	display_with_colors_offset (x_offset, d_y: INTEGER; a_text_color: EV_COLOR; a_background_color: EV_COLOR; device: EV_DRAWABLE) is
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
				device.clear_rectangle (x_offset, d_y, get_substring_width (image.count), height)
			end
			
 				-- Display the text.
 			draw_text_top_left (x_offset, d_y, text_to_be_drawn, device)
		end

feature {NONE} -- Implementation

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
			if is_fixed_width then
				Result := editor_preferences.tabulation_spaces * font_width
			else
				Result := editor_preferences.tabulation_spaces * font.string_width(" ")
			end
		end

	gray_text_color: EV_COLOR is
			-- Gray color
		local
			lightness: REAL
		do
			lightness := sqrt (text_color.lightness)
			create Result.make_with_rgb (lightness, lightness, lightness)
		end			

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EDITOR_TOKEN
