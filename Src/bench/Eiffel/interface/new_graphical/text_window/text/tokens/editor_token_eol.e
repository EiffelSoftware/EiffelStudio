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
			corresponding_text_item
		end

create
	make

feature -- Access

	corresponding_text_item: TEXT_ITEM is
			-- Item of a structured text that corresponds
			-- to `Current'
		do
			Result := create {NEW_LINE_ITEM}.make
		end

feature -- Initialisation

	make is
			-- Create the token (image is an empty string)
		do
			image := ""
			length := 1
			width := 0
		end

feature -- Display

	width: INTEGER
-- is
--		do
--			Result := 0
--		end
	
	display_end_token_normal(d_y: INTEGER; a_device: EV_PIXMAP; a_width: INTEGER; panel: TEXT_PANEL) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its normal state.
		do
			display_end_token(d_y, a_device, a_width, False, panel)
		end

	display_end_token_selected(d_y: INTEGER; a_device: EV_PIXMAP; a_width: INTEGER; panel: TEXT_PANEL) is
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its selected state.
		do
			display_end_token(d_y, a_device, a_width, True, panel)
		end

	display(d_y: INTEGER; a_device: EV_PIXMAP; panel: TEXT_PANEL) is
		do
			-- Do nothing.
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

feature {NONE} -- Private Constants

	eol_symbol: STRING is
		once
			Result := "¶"
		end

feature {NONE} -- Implementation

	display_end_token(d_y: INTEGER; a_device: EV_PIXMAP; a_width: INTEGER; selected: BOOLEAN; panel: TEXT_PANEL) is
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
 				a_device.clear_rectangle(position, d_y, a_width - position, height)
 			else
 				the_text_color := text_color

	 				-- Fill the end of the line with the specified background brush.
				a_device.set_background_color(editor_preferences.normal_background_color)
 				a_device.clear_rectangle(position, d_y, a_width - position, height)
 
			end

 				-- Display the ¶ only if the option is set.
 			if panel.view_invisible_symbols then
 					-- Backup old drawing style and set the new one.
 				a_device.set_foreground_color(the_text_color)
 				a_device.set_font(font)
 
 					-- Display the text.
 				a_device.draw_text_top_left (position, d_y + height // 8, eol_symbol)
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
