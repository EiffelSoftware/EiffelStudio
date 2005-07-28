indexing
	description	: "Token that describe the end of a line."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN
		redefine
			text_color,
			background_color,
			process
		end

create
	make

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
		end

feature -- Display

	width: INTEGER is
		do		
		end
	
	display_end_token_normal(d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; panel: TEXT_PANEL) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its normal state.
		do
			display_end_token(d_y, a_device, a_width, False, panel)
		end

	display_end_token_selected(d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; panel: TEXT_PANEL) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its selected state.
		do
			display_end_token (d_y, a_device, a_width, True, panel)
		end

	display(d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL) is
		do
			-- Do nothing.
		end
		
	display_with_offset (x_offset, d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc' at the coordinates (`position + x_offset',`d_y')
		local
			the_text_color: EV_COLOR
			l_width: INTEGER
			l_view_invisible: BOOLEAN
		do
			the_text_color := text_color
			a_device.set_background_color (editor_preferences.normal_background_color)
			l_view_invisible := panel /= Void and then panel.view_invisible_symbols
			if l_view_invisible then
				if is_fixed_width then
					l_width := font_width
				else
					l_width := font.string_width (eol_symbol)
				end
			end
			a_device.clear_rectangle (x_offset, d_y, l_width, d_y + height)
			if l_view_invisible then
				a_device.set_foreground_color (the_text_color)
				a_device.set_font (font)
				draw_text_top_left (x_offset, d_y, eol_symbol, a_device)
			end
		end

feature -- Width & height

	get_substring_width(n: INTEGER): INTEGER is
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			Result := 0
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end
		
feature -- Visitor

	process (a_visitor: TOKEN_VISITOR) is
			--
		do
			a_visitor.process_eol_token (image)
		end

feature {NONE} -- Private Constants

	eol_symbol: STRING is
		once
			Result := "�"
		end

feature {NONE} -- Implementation

	display_end_token (d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; selected: BOOLEAN; panel: TEXT_PANEL) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- If `selected' is set, then the token is displayed in its selected
			-- state.
		local
			the_text_color: EV_COLOR
		do
			if selected then 
 				the_text_color := selected_text_color

	 				-- Fill the end of the line with the specified background brush.
				a_device.set_background_color(selected_background_color)
 				a_device.clear_rectangle(position, d_y, a_width, d_y + height)
 			else
 				the_text_color := text_color

	 				-- Fill the end of the line with the specified background brush.
				a_device.set_background_color(editor_preferences.normal_background_color)
 				a_device.clear_rectangle(position, d_y, a_width, d_y + height)
 
			end

 				-- Display the � only if the option is set.
 			if panel.view_invisible_symbols then
 					-- Backup old drawing style and set the new one.
 				a_device.set_foreground_color(the_text_color)
 				a_device.set_font(font)
 
 					-- Display the text.
 				draw_text_top_left (position, d_y, eol_symbol, a_device)
 			end
		end

feature {NONE} -- Implementation
	
	text_color: EV_COLOR is
		do
			Result := editor_preferences.spaces_text_color
		end

	background_color: EV_COLOR is
		do
				-- There is no background for this symbol.
			Result := Void
		end

end -- class EDITOR_TOKEN_EOL
