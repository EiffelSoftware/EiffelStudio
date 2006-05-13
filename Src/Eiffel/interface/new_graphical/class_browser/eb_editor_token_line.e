indexing
	description: "Object that represents an editor token text block (may be multi-line) which is not used in an editor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR_TOKEN_TEXT

inherit
	SHARED_EDITOR_FONT

	EVS_SETTING_CHANGE_ACTIONS

feature{NONE} -- Initialization

	make_empty is
			--
		do
		end

	make_from_editor_line (a_line: EIFFEL_EDITOR_LINE) is
			-- Initialize `tokens' with `a_line'.
		require
			a_line_attached: a_line /= Void
		do
		end

feature -- Token operation

	set_tokens (a_tokens: LIST [EDITOR_TOKEN]) is
			-- Set `tokens' with `a_tokens'.
		require
			a_tokens_attached: a_tokens /= Void
		local
			l_tokens: like tokens
			l_token: EDITOR_TOKEN
		do
			lock_update
			l_tokens := tokens
			l_tokens.wipe_out
			from
				a_tokens.start
			until
				a_tokens.after
			loop
				l_token := a_tokens.item
				if l_token /= Void then
					l_token.update_width
					l_tokens.extend (l_token)
				end
				a_tokens.forth
			end
			is_position_up_to_date := False
			is_required_width_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			tokens_set: tokens.count = a_tokens.count
		end

feature -- Setting

	enable_text_wrap is
			-- Enable text wrap.
		do
			lock_update
			is_text_wrap_enabled := True
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			text_wrap_enabled: is_text_wrap_enabled
		end

	disable_text_wrap is
			-- disable text wrap.
		do
			lock_update
			is_text_wrap_enabled := False
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			text_wrap_disabled: not is_text_wrap_enabled
		end

	set_overriden_font (a_font: like overriden_font) is
			-- Set `overriden_font' with `a_font'.
		require
			a_font_attached: a_font /= Void
		do
			lock_update
			overriden_font := a_font
			is_position_up_to_date := False
			is_required_width_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_font_set: overriden_font = a_font
		end

	remove_overriden_font is
			-- Remove `overriden_font'.
		do
			lock_update
			overriden_font := Void
			is_position_up_to_date := False
			is_required_width_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_font_removed: overriden_font = Void
		end

	set_overriden_line_height (a_line_height: like overriden_line_height) is
			-- Set `overriden_line_height' with `a_line_height'.
		require
			a_line_height_positive: a_line_height > 0
		do
			lock_update
			overriden_line_height := a_line_height
			is_overriden_line_height_set := True
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_line_height_set: overriden_line_height = a_line_height and is_overriden_line_height_set
		end

	remove_overriden_line_height is
			-- Remove `overriden_line_height'.
		do
			lock_update
			overriden_line_height := 0
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_line_height_removed: overriden_line_height = 0 and not is_overriden_line_height_set
		end

	set_maximum_width (a_width: INTEGER) is
			-- Set `maximum_width' with `a_width'.
		require
			a_width_positive: a_width > 0
		do
			lock_update
			maximum_width := a_width
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			maximum_width_set: maximum_width = a_width
		end

	set_maximum_height (a_height: INTEGER) is
			-- Set `maximum_height' with `a_height'.
		require
			a_height_positive: a_height > 0
		do
			lock_update
			maximum_height := a_height
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			maximum_height_set: maximum_height = a_height
		end

	set_maximum_size (a_width: INTEGER; a_height: INTEGER) is
			-- Set `maximum_width' with `a_width' and `maximum_height' with `a_height'.
		require
			a_width_non_negative: a_width >= 0
			a_height_non_negative: a_height >= 0
		do
			lock_update
			maximum_width := a_width
			maximum_height := a_height
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			maximum_width_set: maximum_width = a_width
			maximum_tooltip_height_set: maximum_height = a_height
		end

	set_x_offset (a_offset: INTEGER) is
			-- Set `x_offset' with `a_offset'.			
		do
			x_offset := a_offset
			is_position_up_to_date := False
		ensure
			x_offset_set: x_offset = a_offset
		end

	set_y_offset (a_offset: INTEGER) is
			-- Set `y_offset' with `a_offset'.			
		do
			y_offset := a_offset
			is_position_up_to_date := False
		ensure
			y_offset_set: y_offset = a_offset
		end

	set_x_y_offset (a_x_offset, a_y_offset: INTEGER) is
			-- Set `x_offset' with `a_x_offset' and `y_offset' with `a_y_offset'.
		do
			x_offset := a_x_offset
			y_offset := a_y_offset
			is_position_up_to_date := False
		ensure
			x_offset_set: x_offset = a_x_offset
			y_offset_set: y_offset = a_y_offset
		end

feature -- Status report

	is_overriden_font_set: BOOLEAN is
			-- Will `overriden_font' be used instead of those fonts which are stored in editor tokens?
		do
			Result := overriden_font /= Void
		ensure
			good_result: (Result implies overriden_font /= Void) and (not Result implies overriden_font = Void)
		end

	is_overriden_line_height_set: BOOLEAN
			-- Will `overriden_line_height' be used?

	is_text_wrap_enabled: BOOLEAN
			-- Is text wrap enabled?
			-- Has effect if `maximum_width' is set and some lines in `tokens' needs more room than `maximum_width'.

	is_maximum_width_set: BOOLEAN is
			-- Is `maximum_width' set?
		do
			Result := maximum_width > 0
		ensure
			good_result: (Result implies maximum_width > 0) and (not Result implies maximum_width = 0)
		end

	is_maximum_height_set: BOOLEAN is
			-- Is `maximum_height' set?
		do
			Result := maximum_height > 0
		ensure
			good_result: (Result implies maximum_height > 0) and (not Result implies maximum_height = 0)
		end

	token_index_at_position (x, y: INTEGER): INTEGER is
			-- Index of item in `tokens' whose region contains position (x, y)
			-- 0 if no item in `tokens' satisfies this condition.
		local
			l_pos: like token_position
			l_cursor: CURSOR
			done: BOOLEAN
		do
			if not is_position_up_to_date then
				update_position
			end
			l_pos := token_position
			l_cursor := l_pos.cursor
			from
				l_pos.start
			until
				l_pos.after or done
			loop
				if l_pos.item.has_x_y (x, y) and not tokens.i_th (l_pos.index).image.is_equal (once "...") then
					Result := l_pos.index
					done := True
				end
				l_pos.forth
			end
			l_pos.go_to (l_cursor)
		ensure
			result_non_negative: Result >= 0
			result_correct: Result > 0 implies (Result <= token_position.count and then token_position.i_th (Result).has_x_y (x, y))
		end

	pebble (a_index: INTEGER): ANY is
			-- Pebble of item at position `a_index'.
		require
			a_index_valid: a_index >= 1 and a_index <= tokens.count
		do
			Result := tokens.i_th (a_index).pebble
		end

feature -- Display

	display_within_region (x, y, a_width, a_height: INTEGER; a_drawable: EV_DRAWABLE; a_selected_token_index: INTEGER; a_focus: BOOLEAN) is
			-- Dispaly only `tokens' which intersect with region defined by `x', `y', `a_width' and `a_height' using `a_drawable'.
			-- `a_selected_token_index' indicates that token should be displayed in its selected status.
			-- `a_focus' indicates whether `tokens' has focus or not.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_tokens: like tokens
			l_pos: like token_position
			l_token: EDITOR_TOKEN
			l_cursor: CURSOR
			l_pos_cursor: CURSOR
			l_index: INTEGER
			l_rec: EV_RECTANGLE
			l_max_height: INTEGER
			l_last_line_y: INTEGER
			l_ell_ready: BOOLEAN
			l_x, l_y: INTEGER
			l_last_available_line: INTEGER
			l_need_ell: BOOLEAN
			done: BOOLEAN
			l_line_height: INTEGER
		do
			if not is_position_up_to_date then
				update_position
			end
			l_tokens := tokens
			if not l_tokens.is_empty then
				l_pos := token_position
				l_cursor := l_tokens.cursor
				l_pos_cursor := l_pos.cursor
				l_line_height := actual_line_height
				if is_maximum_height_set then
					l_max_height := maximum_height
					l_last_available_line := maximum_height - l_line_height
					from
						l_pos.finish
					until
						l_pos.before or l_need_ell
					loop
						if l_pos.item.y > l_last_available_line then
							l_need_ell := True
						end
						l_pos.back
					end
				end
				create l_rec.make (x, y, a_width, a_height)
				from
					l_tokens.start
					l_pos.start
					l_index := 1
				until
					l_tokens.after or done
				loop
					l_token := l_tokens.item
					if l_pos.item.intersects (l_rec) then
						if l_need_ell then
							if l_pos.item.y + l_line_height > l_last_available_line then
								display_token (l_pos.item.x, l_pos.item.y, create{EDITOR_TOKEN_TEXT}.make ("..."), a_drawable)
								done := True
							end
						end
						if not done then
							if l_index = a_selected_token_index then
								display_selected_token (l_pos.item.x, l_pos.item.y, l_token, a_focus, a_drawable)
							else
								display_token (l_pos.item.x, l_pos.item.y, l_token, a_drawable)
							end
						end
					end
					l_index := l_index + 1
					l_tokens.forth
					l_pos.forth
				end
				l_tokens.go_to (l_cursor)
				l_pos.go_to (l_pos_cursor)
			end
		end

	display (x, y: INTEGER; a_drawable: EV_DRAWABLE; a_selected_token_index: INTEGER; a_focus: BOOLEAN) is
			-- Display `tokens' at position (x, y) using `a_drawable'.
			-- `a_selected_token_index' indicates that token should be displayed in its selected status.
			-- `a_focus' indicates whether `tokens' has focus or not.			
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_tokens: like tokens
			l_pos: like token_position
			l_token: EDITOR_TOKEN
			l_cursor: CURSOR
			l_pos_cursor: CURSOR
			l_index: INTEGER
		do
			if not is_position_up_to_date then
				update_position
			end
			l_tokens := tokens
			if not l_tokens.is_empty then
				l_pos := token_position
				l_cursor := l_tokens.cursor
				l_pos_cursor := l_pos.cursor
				from
					l_tokens.start
					l_pos.start
					l_index := 1
				until
					l_tokens.after
				loop
					l_token := l_tokens.item
					if l_index = a_selected_token_index then
						display_selected_token (x + l_pos.item.x, y + l_pos.item.y, l_token, a_focus, a_drawable)
					else
						display_token (x + l_pos.item.x, y + l_pos.item.y, l_token, a_drawable)
					end
					l_index := l_index + 1
					l_tokens.forth
					l_pos.forth
				end
				l_tokens.go_to (l_cursor)
				l_pos.go_to (l_pos_cursor)
			end
		end

feature -- Position status

	is_position_up_to_date: BOOLEAN
			-- Is `token_position' update to date?

	is_required_width_up_to_date: BOOLEAN
			-- Is `required_width' up to date?

feature -- Measure

	maximum_width: INTEGER
			-- Maximum width in pixel of `tokens'
			-- Default value is 0, meaning maximum width is not set, `tokens' will be displayed
			-- in actually required width.

	maximum_height: INTEGER
			-- Maxiumu height in pixel of `tokens'
			-- Default value is 0, meaning maximum height is not set, `tokens' will be displayed
			-- in actually required height.

	x_offset: INTEGER
			-- X offset in pixel to display `tokens'

	y_offset: INTEGER
			-- Y offset in pixel to display `tokens'

feature -- Access

	overriden_font: EV_FONT
			-- Current set font which is used to display editor tokens

	overriden_line_height: INTEGER
			-- Line height in pixel

	tokens: ARRAYED_LIST [EDITOR_TOKEN] is
			-- `tokens' stored in list
		do
			if internal_tokens = Void then
				create internal_tokens.make (0)
			end
			Result := internal_tokens
		ensure
			result_attached: Result /= Void
		end

	token_position: ARRAYED_LIST [EV_RECTANGLE] is
			-- Position information of every token in `tokens'
		do
			if internal_token_position = Void then
				create internal_token_position.make (0)
			end
			Result := internal_token_position
		ensure
			result_attached: Result /= Void
		end

	string_representation: STRING is
			-- String representation of current
		local
			l_cursor: CURSOR
			l_tokens: like tokens
		do
			l_tokens := tokens
			l_cursor := l_tokens.cursor
			create Result.make (20)
			from
				l_tokens.start
			until
				l_tokens.after
			loop
				Result.append (l_tokens.item.image)
				l_tokens.forth
			end
			if l_cursor /= Void then
				l_tokens.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Measure

	actual_line_height: INTEGER is
			-- Actual line height
			-- It takes both `line_height' and `overriden_line_height' into account.
		do
			if is_overriden_line_height_set then
				Result := overriden_line_height
			else
				Result := line_height
			end
		ensure
			good_result:
				(is_overriden_line_height_set implies Result = overriden_line_height) and
				(not is_overriden_line_height_set implies Result = line_height)
		end

	required_width: INTEGER is
			-- Required width in pixel to fully display `tokens'
		require
			tokens_attached: tokens /= Void
		local
			l_cur_line_width: INTEGER
			l_max_line_width: INTEGER
			l_cursor: CURSOR
			l_tokens: like tokens
			l_token: EDITOR_TOKEN
			l_overriden_font_used: BOOLEAN
		do
			if not is_required_width_up_to_date then
				l_tokens := tokens
				if not l_tokens.is_empty then
					l_cursor := l_tokens.cursor
					l_overriden_font_used := is_overriden_font_set
					from
						l_tokens.start
					until
						l_tokens.after
					loop
						l_token := l_tokens.item
						if l_token.is_new_line then
							if l_cur_line_width > l_max_line_width then
								l_max_line_width := l_cur_line_width
							end
							l_cur_line_width := 0
						else
							if l_overriden_font_used then
								l_cur_line_width := l_cur_line_width + overriden_font.width * l_token.image.count
							else
								l_cur_line_width := l_cur_line_width + l_token.width
							end
						end
						l_tokens.forth
					end
					if l_cur_line_width > l_max_line_width then
						l_max_line_width := l_cur_line_width
					end
					internal_required_width := l_max_line_width
					is_required_width_up_to_date := True
				end
			end
			Result := internal_required_width
		end

	required_height: INTEGER is
			-- Required width in pixel to fully display `tokens'
		require
			tokens_attached: tokens /= Void
		local
			l_tokens: like tokens
			l_token: EDITOR_TOKEN
			l_cursor: CURSOR
			x, y: INTEGER
			l_overriden_font_used: BOOLEAN
			l_wrapped: BOOLEAN
			l_width, l_height: INTEGER
			l_line_height: INTEGER
			l_token_in_current_line: INTEGER
			l_is_max_width_set: BOOLEAN
			l_is_text_wrapped: BOOLEAN
		do
			l_tokens := tokens
			if not l_tokens.is_empty then
				l_cursor := l_tokens.cursor
				l_overriden_font_used := is_overriden_font_set
				l_wrapped := is_text_wrap_enabled
				l_line_height := actual_line_height
				l_is_max_width_set := is_maximum_width_set
				l_is_text_wrapped := is_text_wrap_enabled
				from
					x := x_offset
					y := y_offset
					l_tokens.start
					l_token_in_current_line := 0
				until
					l_tokens.after
				loop
					l_token := l_tokens.item
					if l_overriden_font_used then
						l_width := overriden_font.width * l_token.image.count
						l_height := overriden_font.height
					else
						l_width := l_token.width
						l_height := l_token.font.height
					end
					if
						not l_token.is_new_line and then
						(l_is_max_width_set and l_is_text_wrapped and x + l_width > maximum_width and l_token_in_current_line > 0)
					then
						x := 0
						y := y + l_line_height
						l_token_in_current_line := 0
					end
					x := x + l_width
					if l_token.is_new_line then
						y := y + l_line_height
						x := 0
						l_token_in_current_line := 0
					else
						l_token_in_current_line := l_token_in_current_line + 1
					end
					l_tokens.forth
				end
				l_tokens.go_to (l_cursor)
			end
			Result := y
			if l_token_in_current_line > 0 then
				Result := Result + l_line_height
			end
		end

feature{NONE} -- Display

	display_token (x, y: INTEGER; a_token: EDITOR_TOKEN; a_drawable: EV_DRAWABLE) is
			-- Display `a_token' at position (x, y) using `a_drawable'.
		require
			a_token_attached: a_token /= Void
			a_drawable_attached: a_drawable /= Void
		do
			a_drawable.set_font (actual_token_font (a_token))
			a_drawable.set_foreground_color (a_token.text_color)
			a_drawable.draw_text_top_left (x, y, a_token.image)
		end

	display_selected_token (x, y: INTEGER; a_token: EDITOR_TOKEN; a_focus: BOOLEAN; a_drawable: EV_DRAWABLE) is
			-- Display `a_token' at position (x, y) in its selected state.
			-- `a_focus' indicates whether `a_token' has focus or not.
		require
			a_token_attached: a_token /= Void
			a_drawable_attached: a_drawable /= Void
		local
			l_font: EV_FONT
		do
			if a_focus then
				a_drawable.set_background_color (a_token.selected_background_color)
				a_drawable.set_foreground_color (a_token.selected_text_color)
			else
				a_drawable.set_background_color (a_token.focus_out_selected_background_color)
				a_drawable.set_foreground_color (a_token.text_color)
			end
			l_font := actual_token_font (a_token)
			a_drawable.set_font (l_font)
			a_drawable.clear_rectangle (x, y, l_font.string_width (a_token.image), actual_line_height)--l_font.height)
			a_drawable.draw_text_top_left (x, y, a_token.image)
		end

	display_part_selected_token (x ,y: INTEGER; a_token: EDITOR_TOKEN; a_select_start, a_select_end: INTEGER; a_focus: BOOLEAN; a_drawable: EV_DRAWABLE) is
			-- Display `a_token' at position (x, y) in its partly selected state
			-- Selection region is from `a_select_start' to `a_select_end'.
			-- `a_focus' indicates whether `a_token' has focus or not.
		require
			a_token_attached: a_token /= Void
			a_drawable_attached: a_drawable /= Void
			selection_position_valid: a_select_start >= 1 and a_select_end <= a_token.image.count and a_select_start <= a_select_end
		local
			l_first_image: STRING
			l_selected_image: STRING
			l_last_image: STRING
			l_image: STRING
			l_x: INTEGER
			l_font: EV_FONT
			l_width: INTEGER
		do
			l_font := actual_token_font (a_token)
			a_drawable.set_font (l_font)
			l_image := a_token.image
			if a_select_start > 1 then
				l_first_image := l_image.substring (1, a_select_start - 1)
			end
			l_selected_image := l_image.substring (a_select_start, a_select_end)
			if a_select_end < l_image.count then
				l_last_image := l_image.substring (a_select_end + 1, l_image.count)
			end
			l_x := x
			if l_first_image /= Void then
				a_drawable.set_foreground_color (a_token.text_color)
				a_drawable.draw_text_top_left (l_x, y, l_first_image)
				l_x := l_x + l_font.string_width (l_first_image)
			end
			if l_image /= Void then
				if a_focus then
					a_drawable.set_background_color (a_token.selected_background_color)
					a_drawable.set_foreground_color (a_token.selected_text_color)
				else
					a_drawable.set_background_color (a_token.focus_out_selected_background_color)
					a_drawable.set_foreground_color (a_token.text_color)
				end
				l_width := l_font.string_width (l_image)
				a_drawable.clear_rectangle (l_x, y, l_width, l_font.height)
				a_drawable.draw_text_top_left (x, y, l_image)
				l_x := l_x + l_width
			end
			if l_last_image /= Void then
				a_drawable.set_foreground_color (a_token.text_color)
				a_drawable.draw_text_top_left (l_x, y, l_last_image)
			end
		end

feature{NONE} -- Implementation

	actual_token_font (a_token: EDITOR_TOKEN): EV_FONT is
			-- Actual used font for `a_token'.
			-- Will take `overriden_font' into account.
		require
			a_token_attached: a_token /= Void
		do
			if is_overriden_font_set then
				Result := overriden_font
			else
				Result := a_token.font
			end
		ensure
			result_set:
				(is_overriden_font_set implies Result = overriden_font) and
				(not is_overriden_font_set implies Result = a_token.font)
		end

	internal_tokens: like tokens
			-- Internal tokens

	internal_token_position: like token_position
			-- Internal token position list

	internal_required_width: INTEGER
			-- Internal `required_width'

	update_position is
			-- Update width information and relative position in every token in `tokens'.
		require
			tokens_attached: tokens /= Void
		local
			l_tokens: like tokens
			l_pos: like token_position
			l_token: EDITOR_TOKEN
			l_cursor: CURSOR
			x, y: INTEGER
			l_overriden_font_used: BOOLEAN
			l_wrapped: BOOLEAN
			l_width, l_height: INTEGER
			l_line_height: INTEGER
			l_token_in_current_line: INTEGER
			l_is_max_width_set: BOOLEAN
			l_is_text_wrapped: BOOLEAN
		do
			l_tokens := tokens
			if not l_tokens.is_empty then
				l_pos := token_position
				l_pos.wipe_out
				l_cursor := l_tokens.cursor
				l_overriden_font_used := is_overriden_font_set
				l_wrapped := is_text_wrap_enabled
				l_line_height := actual_line_height
				l_is_max_width_set := is_maximum_width_set
				l_is_text_wrapped := is_text_wrap_enabled
				from
					x := x_offset
					y := y_offset
					l_tokens.start
					l_token_in_current_line := 0
				until
					l_tokens.after
				loop
					l_token := l_tokens.item
					if l_overriden_font_used then
						l_width := overriden_font.width * l_token.image.count
						l_height := overriden_font.height
					else
						l_width := l_token.width
						l_height := l_token.font.height
					end
					if
						not l_token.is_new_line and then
						(l_is_max_width_set and l_is_text_wrapped and x + l_width > maximum_width and l_token_in_current_line > 0)
					then
						x := x_offset
						y := y + l_line_height
						l_token_in_current_line := 0
					end
					l_pos.extend (create {EV_RECTANGLE}.make (x, y, l_width, l_line_height))
					x := x + l_width
					if l_token.is_new_line then
						y := y + l_line_height
						x := x_offset
						l_token_in_current_line := 0
					else
						l_token_in_current_line := l_token_in_current_line + 1
					end
					l_tokens.forth
				end
				l_tokens.go_to (l_cursor)
			end
			is_position_up_to_date := True
		ensure
			position_up_to_date: is_position_up_to_date
			token_position_set: token_position.count = tokens.count
		end

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
