note
	description: "Token that describe the end of a line."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EDITOR_TOKEN_EOL

inherit
	EDITOR_TOKEN
		redefine
			text_color_id,
			background_color_id,
			background_color,
			is_new_line,
			character_length
		end

create
	make,
	make_with_style,
	make_windows_style,
	make_unix_style

feature -- Initialisation

	make
			-- Create the token in unix style
		obsolete
			"Use `make_with_style' instead. [2017-05-31]"
		do
			make_with_style (False)
		end

	make_with_style (a_windows_style: BOOLEAN)
			-- Create the token in `a_windows_style'.
		do
			if a_windows_style then
				wide_image := windows_style_new_line
			else
				wide_image := unix_style_new_line
			end
			length := 1
		end

	make_windows_style
			-- Create the token in Windows style.
		do
			make_with_style (True)
		end

	make_unix_style
			-- Create the token in Unix style.
		do
			make_with_style (False)
		end

feature -- Status report

	is_new_line: BOOLEAN = True
			-- Is current a new line token?

feature -- Access

	width: INTEGER
			-- Pixel width of eol symbol.
		do
		end

	character_length: INTEGER
			-- Number characters represented by the token.
		do
			Result := wide_image.count
		end

feature -- Display


	display_end_token_normal(d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; panel: TEXT_PANEL)
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its normal state.
		require
			a_device_not_void: a_device /= Void
			panel_not_void: panel /= Void
		do
			display_end_token(d_y, a_device, a_width, False, panel)
		end

	display_end_token_selected(d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; panel: TEXT_PANEL)
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- The token is displayed in its selected state.
		require
			a_device_not_void: a_device /= Void
			panel_not_void: panel /= Void
		do
			display_end_token (d_y, a_device, a_width, True, panel)
		end

	display(d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL)
		do
			-- Do nothing.
		end

	display_with_offset (x_offset, d_y: INTEGER; a_device: EV_DRAWABLE; panel: TEXT_PANEL)
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

	get_substring_width(n: INTEGER): INTEGER
			-- Conpute the width in pixels of the first
			-- `n' characters of the current string.
		do
			Result := 0
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		do
			Result := 1
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			--
		do
			a_visitor.process_editor_token_eol (Current)
		end

feature {NONE} -- Private Constants

	eol_symbol: STRING_32
			-- EOL symbol to be displayed
		do
			if character_length = 1 then
				Result := once {STRING_32} "¯"
			else
				Result := once {STRING_32} "¬"
			end
		end

feature {NONE} -- Implementation

	display_end_token (d_y: INTEGER; a_device: EV_DRAWABLE; a_width: INTEGER; selected: BOOLEAN; panel: TEXT_PANEL)
			-- Display the end token, at the coordinates (position,`d_y') on the
			-- device context `a_device', with a screen width of `a_width'.
			-- If `selected' is set, then the token is displayed in its selected
			-- state.
		local
			the_text_color: EV_COLOR
			the_background_color: EV_COLOR
		do
			if selected then
				if panel.has_focus then
					the_text_color := selected_text_color
					the_background_color := selected_background_color
				else
					the_text_color := text_color
					the_background_color := focus_out_selected_background_color
				end

	 				-- Fill the end of the line with the specified background brush.
				a_device.set_background_color(the_background_color)
 				a_device.clear_rectangle(position, d_y, a_width, d_y + height)
 			else
 				the_text_color := text_color

	 				-- Fill the end of the line with the specified background brush.
				a_device.set_background_color(editor_preferences.normal_background_color)
 				a_device.clear_rectangle(position, d_y, a_width, d_y + height)

			end

 				-- Display the  only if the option is set.
 			if panel.view_invisible_symbols then
 					-- Backup old drawing style and set the new one.
 				a_device.set_foreground_color(the_text_color)
 				a_device.set_font(font)

 					-- Display the text.
 				draw_text_top_left (position, d_y, eol_symbol, a_device)
 			end
		end

	windows_style_new_line: STRING_32 = "%R%N"
			-- Windows style new line

	unix_style_new_line: STRING_32 = "%N"
			-- Unix style new line

feature -- Color

	text_color_id: INTEGER
		do
			Result := spaces_text_color_id
		end

	background_color: EV_COLOR
		do
				-- There is no background for this symbol.
				-- Default to white.
			Result := (create {EV_STOCK_COLORS}).white
		end

	background_color_id: INTEGER
		do
			Result := 0
		end

invariant
	wide_image_is_set: not wide_image.is_empty
	character_length_restricted: character_length = 1 or character_length = 2

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
