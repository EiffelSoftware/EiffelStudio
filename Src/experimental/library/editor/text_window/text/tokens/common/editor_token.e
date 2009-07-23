note
	description	: "Objects that represents a general text token."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

deferred class
	EDITOR_TOKEN

inherit
	EV_FONT_CONSTANTS
		export
			{NONE} all
		end

	SHARED_EDITOR_DATA

	EDITOR_TOKEN_IDS

feature -- Access

	wide_image: STRING_32
			-- String representation of the token

	image: STRING
			-- String representation of the token
		obsolete
			"Use `wide_image' instead."
		do
			if wide_image /= Void then
				Result := wide_image.as_string_8
			end
		end

	length: INTEGER
			-- Number of characters represented by the token.

	position: INTEGER
			-- position in pixels of the first character of
			-- this token

	pebble: ANY
			-- pebble to be picked when user right-clicks
			-- on this token.
			-- Only cursors are used in the class STONE.


feature -- Token type status Report

	is_blank: BOOLEAN
			-- Is this a blank token?
		do
		end

	is_feature_start: BOOLEAN
		do
		end

	is_new_line: BOOLEAN
			-- Is current a new line token?
		do
		end

	is_tabulation: BOOLEAN
			-- Is current a tabulation token?
		do
		end

	is_margin_token: BOOLEAN
			-- Is the current token a margin token?
			-- A margin token is a behavior token and does not
			-- contain any editable text. An example of a beginning token is
			-- the EDITOR_TOKEN_BREAKPOINT or EDITOR_TOKEN_LINE_NUMBER.  Default is False.
		do
		end

feature -- Status report

	is_selectable: BOOLEAN
			-- Is this token part of a group of selectable tokens?

	is_highlighted: BOOLEAN
			-- Is current highlighted?

	is_fake: BOOLEAN
			-- Is current fake?

feature -- Status Setting

	set_pebble (a_pebble: like pebble)
			-- Set `pebble' to `a_pebble'
		do
			pebble := a_pebble
		end

	set_is_selectable (b: BOOLEAN)
			-- Set `is_selectable' to `b'
		do
			is_selectable := b
		ensure
			value_set: is_selectable = b
		end

	set_highlighted (b: BOOLEAN)
			-- Highlight
		do
			is_highlighted := b
		ensure
			value_set: is_highlighted = b
		end

	set_is_fake (b: BOOLEAN)
			-- Set `is_fake' to `b'.
		do
			is_fake := b
		ensure
			value_set: is_fake = b
		end

	set_text_color (a_color: like userset_text_color)
			-- Set `text_color' with `a_color'.
			-- Void to use color from preferences.
		do
			userset_text_color := a_color
		ensure
			userset_text_color_set: userset_text_color = a_color
		end

	set_background_color (a_color: like userset_background_color)
			-- Set `background_color' with `a_color'.
			-- Void to use color from preferences.
		do
			userset_background_color := a_color
		ensure
			userset_background_color_set: userset_background_color = a_color
		end

	set_selected_text_color (a_color: like userset_selected_text_color)
			-- Set `selected_text_color' with `a_color'.
			-- Void to use color from preferences.
		do
			userset_selected_text_color := a_color
		ensure
			userset_selected_text_color_set: userset_selected_text_color = a_color
		end

	set_selected_background_color (a_color: like userset_selected_background_color)
			-- Set `selected_background_color' with `a_color'.
			-- Void to use color from preferences.
		do
			userset_selected_background_color := a_color
		ensure
			userset_selected_background_color_set: userset_selected_background_color = a_color
		end

	set_focus_out_selected_background_color (a_color: like userset_focus_out_selected_background_color)
			-- Set `focus_out_selected_background_color' with `a_color'.
			-- Void to use color from preferences.
		do
			userset_focus_out_selected_background_color := a_color
		ensure
			userset_focus_out_selected_background_color_set: userset_focus_out_selected_background_color = a_color
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR)
			-- Visitor
		require
			visitor_not_void: a_visitor /= Void
		deferred
		end

feature -- Linkable functions

	previous: EDITOR_TOKEN
			-- Previous token in the line. Void if none

	next: EDITOR_TOKEN
			-- Next token in the line. Void if none.

	set_next_token (next_token: EDITOR_TOKEN)
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			next := next_token
		end

	set_previous_token (previous_token: EDITOR_TOKEN)
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			previous := previous_token
		end

	update_position
			-- Update the value of `position'.
		do
				-- Update current position
			if previous /= Void then
				if not previous.is_margin_token then
					position := previous.position + previous.width
				else
					position := 0
				end
			else
				position := 0
			end
		end

feature -- Display

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		deferred
		end

	display_with_offset (x, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc' at the coordinates (`x',`d_y')
		deferred
		end

	display_selected(d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		require
			device_not_void: device /= Void
			panel_not_void: panel /= Void
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display(d_y, device, panel)
		end

	display_half_selected (d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL)
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beginning to `pivot'
		require
			device_not_void: device /= Void
			panel_not_void: panel /= Void
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display (d_y, device, panel)
		end

feature -- Width & height

	width: INTEGER
			-- Width in pixel of the entire token.
		deferred
		end

	height: INTEGER
			-- Line height
		local
			l_userset_data: like userset_data
		do
			l_userset_data := userset_data
			if l_userset_data /= Void and l_userset_data.line_height > 0 then
				Result := l_userset_data.line_height
			else
				Result := editor_preferences.line_height
			end
		end

	get_substring_width(n: INTEGER): INTEGER
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		require
			n_valid: n >= 0
		deferred
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			a_width_valid: a_width >= 0
		deferred
		ensure
			Result_positive: Result > 0
			Result_small_enough: Result <= length
		end

	update_width
			-- update value of `width'
		do
		end

feature -- Color

	text_color: EV_COLOR
		do
			if attached userset_text_color as l_color then
				Result := l_color
			else
				Result := editor_preferences.color_of_id (text_color_id)
			end
		end

	background_color: EV_COLOR
		do
			if attached userset_background_color as l_color then
				Result := l_color
			else
				Result := editor_preferences.color_of_id (background_color_id)
			end
		end

	selected_text_color: EV_COLOR
		do
			if attached userset_selected_text_color as l_color then
				Result := l_color
			else
				Result := editor_preferences.color_of_id (selected_text_color_id)
			end
		end

	selected_background_color: EV_COLOR
		do
			if attached userset_background_color as l_color then
				Result := l_color
			else
				Result := editor_preferences.color_of_id (selected_background_color_id)
			end
		end

	focus_out_selected_background_color: EV_COLOR
		do
			if attached userset_focus_out_selected_background_color as l_color then
				Result := l_color
			else
				Result := editor_preferences.color_of_id (focus_out_selected_background_color_id)
			end
		end

feature -- Color ids

	text_color_id: INTEGER
		do
			Result := normal_text_color_id
		end

	background_color_id: INTEGER
		do
			if is_highlighted then
				Result := highlight_color_id
			else
				Result := normal_background_color_id
			end
		end

	selected_text_color_id: INTEGER
		do
			Result := selection_text_color_id
		end

	selected_background_color_id: INTEGER
		do
			Result := selection_background_color_id
		end

	focus_out_selected_background_color_id: INTEGER
		do
			Result := focus_out_selection_background_color_id
		end

feature -- Font

	font: EV_FONT
			-- Font of current.
		local
			l_userset_fonts: like userset_fonts
		do
			l_userset_fonts := userset_fonts
			if l_userset_fonts /= Void then
				Result := l_userset_fonts [font_id]
			else
				Result := editor_preferences.font_of_id (font_id)
			end
		end

	font_offset: INTEGER
			-- Number of pixels from top of line to beginning of drawing operation
		do
			if userset_font_offset > 0 then
				Result := userset_font_offset
			else
				Result := editor_preferences.font_offset
			end
		end

	font_id: INTEGER
			-- Font id.
		do
			Result := editor_font_id
		end

	font_width: INTEGER
			-- Width of character in the editor.
		require
			is_fixed_width: is_fixed_width
		local
			l_width: like userset_font_width
		do
			l_width := userset_font_width
			if l_width > 0 then
				Result := l_width
			else
				Result := editor_preferences.font_width
			end
		end

	is_fixed_width: BOOLEAN
			-- Is `font' a fixed-width font?
		local
			l_data: like userset_data
		do
			l_data := userset_data
			if l_data /= Void and then l_data.is_font_fixed_set then
				Result := userset_data.is_font_fixed
			else
				Result := editor_preferences.is_fixed_width
			end
		end

feature -- Implementation of clickable and editable text

	is_text: BOOLEAN
			-- is this a text token ?
		do
		end

	pos_in_text: INTEGER
			-- Position of the token in the text in characters

	set_pos_in_text (pit: INTEGER)
			-- Does nothing : redefined in editor_token_text
		require
			pit_non_negative: pit >= 0
		do
			pos_in_text := pit
		ensure
			pos_in_text_set: pos_in_text = pit
		end

	is_clickable: BOOLEAN

	set_is_clickable (a_clickable: BOOLEAN)
			-- Set `is_clickable' with `a_clickable'.
		do
			is_clickable := a_clickable
		ensure
			is_clickable_set: is_clickable = a_clickable
		end

	platform_is_windows: BOOLEAN
			-- Is the current platform Windows?
		once
			Result := (create {PLATFORM}).is_windows
		end

	draw_text_top_left (pos, d_y: INTEGER; text_to_be_drawn: STRING_32; device: EV_DRAWABLE)
		do
			device.draw_text (pos, d_y + font_offset, text_to_be_drawn)
		end

feature {TEXT_PANEL, VIEWER_LINE}

	set_userset_data (a_data: like userset_data)
			-- Set `userset_data' with `a_data'
		do
			userset_data := a_data
		ensure
			userset_data_set: userset_data = a_data
		end

feature {NONE} -- Userset Implementation, text panel wide attributes

	userset_data: TEXT_PANEL_BUFFERED_DATA;
			-- Userset editor data

	userset_fonts: SPECIAL [EV_FONT]
			-- Userset fonts
		do
			if userset_data /= Void then
				Result := userset_data.fonts
			end
		end

	userset_font_offset: like font_offset
			-- Userset font offset
		do
			if userset_data /= Void then
				Result := userset_data.font_offset
			end
		end

	userset_font_width: INTEGER
			-- Userset font width
		local
			l_userset_data: like userset_data
		do
			l_userset_data := userset_data
			if l_userset_data /= Void then
				Result := l_userset_data.font_width
			end
		end

feature {NONE} -- Userset Implementation, token wide attributes

	userset_text_color: detachable EV_COLOR

	userset_background_color: detachable EV_COLOR

	userset_selected_text_color: detachable EV_COLOR

	userset_selected_background_color: detachable EV_COLOR

	userset_focus_out_selected_background_color: detachable EV_COLOR

invariant
	wide_image_not_void: wide_image /= Void
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




end -- class EDITOR_TOKEN
