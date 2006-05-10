indexing
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

	image: STRING
			-- String representation of the token

	length: INTEGER
			-- Number of characters represented by the token.

	position: INTEGER
			-- position in pixels of the first character of
			-- this token

	pebble: ANY
			-- pebble to be picked when user right-clicks
			-- on this token.
			-- Only cursors are used in the class STONE.

	is_margin_token: BOOLEAN is
			-- Is the current token a margin token?
			-- A margin token is a behavior token and does not
			-- contain any editable text. An example of a beginning token is
			-- the EDITOR_TOKEN_BREAKPOINT or EDITOR_TOKEN_LINE_NUMBER.  Default is False.
		do
		end

feature -- Status Report

	is_blank: BOOLEAN is
			-- Is this a blank token?
		do
			Result := False
		end

	is_feature_start: BOOLEAN is
		do
		end

	is_selectable: BOOLEAN
			-- Is this token part of a group of selectable tokens?

	is_highlighted: BOOLEAN
			-- Is current highlighted?

	is_fake: BOOLEAN
			-- Is current fake?

	is_new_line: BOOLEAN is
			-- Is current a new line token?
		do
		end

feature -- Status setting

	set_pebble (a_pebble: like pebble) is
			-- Set `pebble' to `a_pebble'
		do
			pebble := a_pebble
		end

	set_is_selectable (a_flag: BOOLEAN) is
			-- Set `is_selectable' to `a_flag'
		do
			is_selectable := a_flag
		ensure
			value_set: is_selectable = a_flag
		end

	set_is_fake (a_fake: BOOLEAN) is
			-- Set `is_fake' to `a_fake'.
		do
			is_fake := a_fake
		ensure
			value_set: is_fake = a_fake
		end

feature -- Visitor

	process (a_visitor: TOKEN_VISITOR) is
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

	set_next_token (next_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			next := next_token
		end

	set_previous_token (previous_token: EDITOR_TOKEN) is
			-- set `next' to `next_token'. `next' can
			-- be Void if there are no next token.
		do
			previous := previous_token
		end

	update_position is
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

	display (d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y')
		deferred
		end

	display_with_offset (x, d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc' at the coordinates (`x',`d_y')
		deferred
		end

	display_selected(d_y: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state.
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display(d_y, device, panel)
		end

	display_half_selected (d_y: INTEGER; start_selection, end_selection: INTEGER; device: EV_DRAWABLE; panel: TEXT_PANEL) is
			-- Display the current token on device context `dc'
			-- at the coordinates (`position',`d_y') with its
			-- selected state from beginning to `pivot'
		do
				-- by default, we call the normal `display' feature.
				-- Redefine the feature to apply a different style.
			display (d_y, device, panel)
		end

	set_highlighted (is_highighted: BOOLEAN) is
			-- Highlight
		do
			is_highlighted := True
		end

feature -- Width & height

	width: INTEGER is
			-- Width in pixel of the entire token.
		deferred
		end

	height: INTEGER is
			--
		do
			Result := editor_preferences.line_height
		end

	get_substring_width(n: INTEGER): INTEGER is
			-- Compute the width in pixels of the first
			-- `n' characters of the current string.
		require
			n_valid: n >= 0
		deferred
		end

	retrieve_position_by_width(a_width: INTEGER): INTEGER is
			-- Return the character situated under the `a_width'-th
			-- pixel.
		require
			a_width_valid: a_width >= 0
		deferred
		ensure
			Result_positive: Result > 0
			Result_small_enough: Result <= length
		end

	update_width is
			-- update value of `width'
		do
		end

feature -- Color

	text_color: EV_COLOR is
		do
			Result := editor_preferences.color_of_id (text_color_id)
		end

	background_color: EV_COLOR is
		do
			Result := editor_preferences.color_of_id (background_color_id)
		end

	selected_text_color: EV_COLOR is
		do
			Result := editor_preferences.color_of_id (selected_text_color_id)
		end

	selected_background_color: EV_COLOR is
		do
			Result := editor_preferences.color_of_id (selected_background_color_id)
		end

	focus_out_selected_background_color: EV_COLOR is
		do
			Result := editor_preferences.color_of_id (focus_out_selected_background_color_id)
		end

feature -- Color ids

	text_color_id: INTEGER is
		do
			Result := normal_text_color_id
		end

	background_color_id: INTEGER is
		do
			if is_highlighted then
				Result := highlight_color_id
			else
				Result := normal_background_color_id
			end
		end

	selected_text_color_id: INTEGER is
		do
			Result := selection_text_color_id
		end

	selected_background_color_id: INTEGER is
		do
			Result := selection_background_color_id
		end

	focus_out_selected_background_color_id: INTEGER is
		do
			Result := focus_out_selection_background_color_id
		end

feature -- Font

	font: EV_FONT is
			-- Font of current.
		do
			Result := editor_preferences.font_of_id (font_id)
		end

	font_offset: INTEGER is
			-- Number of pixels from top of line to beginning of drawing operation
		do
			Result := editor_preferences.font_offset
		end

	font_id: INTEGER is
			-- Font id.
		do
			Result := editor_font_id
		end

	font_width: INTEGER is
			-- Width of character in the editor.
		require
			is_fixed_width: is_fixed_width
		do
			Result := editor_preferences.font_width
		end

	is_fixed_width: BOOLEAN is
			-- Is `font' a fixed-width font?
		do
			Result := editor_preferences.is_fixed_width
		end

feature -- Implementation of clickable and editable text

	is_text: BOOLEAN is
			-- is this a text token ?
		do
		end

	pos_in_text: INTEGER is
			-- position of the token in the text in characters
			-- Warning: To be used only by EB_CLICK_LIST
		do
			Result := -1
		end

	set_pos_in_text (pit: INTEGER) is
			-- Does nothing : redefined in editor_token_text
		do
		end

	platform_is_windows: BOOLEAN is
			-- Is the current platform Windows?
		once
			Result := (create {PLATFORM}).is_windows
		end

	draw_text_top_left (pos, d_y: INTEGER; text_to_be_drawn: STRING; device: EV_DRAWABLE) is
		do
			device.draw_text (pos, d_y + font_offset, text_to_be_drawn)
		end

invariant
	image_not_void: image /= Void
	width_positive_or_null: width >= 0
	previous = Void implies position = 0

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
