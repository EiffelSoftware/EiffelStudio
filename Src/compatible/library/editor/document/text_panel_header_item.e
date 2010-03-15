note
	description: "Item for TEXT_PANEL_HEADER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_HEADER_ITEM

inherit
	DOCUMENT_ITEM		
		redefine
			make
		end

	SHARED_EDITOR_DATA
		undefine
			is_equal
		end
		
	SHARED_EDITOR_FONT
		undefine
			is_equal
		end

create
	make
		
feature -- Creation

	make (a_name: STRING)
		require else
			no_unwanted_chars_in_name: not a_name.has ('%N') and not a_name.has ('%T')
		do
			Precursor (a_name)
			image := short_name (a_name)			
			length := image.count
		ensure then
			image_not_void: image /= Void
		end
		
feature -- Access

	image: STRING
			-- String representation of the token

	length: INTEGER
			-- Number of characters represented by the token.

	position: INTEGER
			-- position in pixels of the first character of
			-- this token

	data: TEXT
		-- Data

	cursor_line: INTEGER
		-- Stored cursor line
	
	cursor_char: INTEGER
		-- Stored cursor char
		
	first_line_displayed: INTEGER
		-- Stored first line displayed in text

	document_type: STRING
			-- Return file extension for Current based on name, Void if none
		do
			create Result.make_empty
			if not (name.occurrences ('.') = 0) then
				Result ?= name.substring (name.last_index_of ('.', name.count) + 1, name.count)
				Result.to_lower
			else
				create Result.make_empty
			end
		end

feature -- Display

	display (device: EV_PIXMAP; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		do	
 				-- Change drawing style here.
 			device.set_font (editor_preferences.header_font)
			device.set_foreground_color (editor_preferences.normal_text_color)
			device.clear_rectangle (position, 0, width, device.height)
			
 				-- Display the text.
 			draw_text_top_left (position + padding, text_font_offset (device.height), image, device)
		end

	display_selected (device: EV_PIXMAP; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		local
			l_bg_color: EV_COLOR
		do		
				-- Change drawing style here.
 			device.set_font (editor_preferences.header_font)
			device.set_foreground_color (editor_preferences.normal_text_color)
			l_bg_color := device.background_color.twin		
			device.set_background_color (background_color)
			device.clear_rectangle (position, 0, width, device.height)			
			
 				-- Display the text.
 			draw_text_top_left (position + padding, text_font_offset (device.height), image, device)
 			device.set_background_color (l_bg_color)
		end

feature -- Width & height

	width: INTEGER
			-- Width in pixel of the entire token.		

	retrieve_position_by_width(a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			a_width_valid: a_width >= 0
		do
		ensure
			Result_positive: Result > 0
			Result_small_enough: Result <= length
		end

	update_width
			-- update value of `width'
		do
			width := get_substring_width (image.count) + (2 * padding)
		end

	update_position
			-- Update the value of `position' to its correct value
		do
				-- Update current position
			if previous /= Void then				
				position := previous.position + previous.width
			else
				position := 0
			end

			update_width
		end

	get_substring_width (n: INTEGER): INTEGER
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		do
			if n = 0 then
				Result := 0
			else
				Result := editor_preferences.header_font.string_width(image.substring (1,n))
			end
		end

feature {TEXT_PANEL_HEADER} -- Status Setting
		
	set_data (a_data: like data)
			-- Set `data'
		require
			data_not_void: a_data /= Void
		do
			data := a_data
		ensure
			data_set: data = a_data
		end		

	set_image (a_image: STRING)
			-- Set `image'
		do
			image := short_name (a_image)
		end		

	set_cursor_line (a_cursor_line: like cursor_line)
			-- Set `cursor_line'
		do
			cursor_line := a_cursor_line
		end	

	set_cursor_char (a_cursor_char: like cursor_char)
			-- Set `cursor_char'
		do
			cursor_char := a_cursor_char
		end	
	
	set_first_line_displayed (a_line_no: INTEGER)
			-- Set `first_line_displayed'
		do
			first_line_displayed := a_line_no	
		end		

feature {NONE} -- Implementation

	short_name (a_name: STRING): STRING
			-- Short file/directory name (minus directory hierarchy) of `a_name'
		require
			name_not_void: a_name /= Void
		local
			l_name: STRING
		do
			l_name := a_name.twin
			l_name.replace_substring_all ("\", "/")
			if l_name.last_index_of ('/', a_name.count) > 0 then
				Result := l_name.substring (l_name.last_index_of ('/', l_name.count) + 1, l_name.count)			
			else
				Result := l_name
			end
		ensure
			has_result: Result /= Void
		end

feature {NONE} -- Properties used to display the token

	padding: INTEGER = 4
		-- Left and right padding width for Current

	text_color: EV_COLOR
		do
			Result := editor_preferences.normal_text_color
		end

	background_color: EV_COLOR
		do
			--| by default, no background...
			Result := editor_preferences.normal_background_color
		end

	draw_text_top_left (pos, d_y: INTEGER; text_to_be_drawn: STRING; device: EV_PIXMAP)
		do
			device.draw_text (pos, d_y, text_to_be_drawn)
		end

	text_font_offset (a_height: INTEGER): INTEGER
			-- 
		do			
			Result := (a_height / 2).ceiling + (header_font_cell.item.value.height / 2).floor	
		end		

invariant
	image_not_void: image /= Void	
	width_positive_or_null: width >= 0
	previous = Void implies position = 0

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




end -- class TEXT_PANEL_HEADER_ITEM
