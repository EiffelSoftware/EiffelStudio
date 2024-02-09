note
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

	EB_CONSTANTS

create
	default_create,
	make_from_editor_line

feature{NONE} -- Initialization

	make_from_editor_line (a_line: EIFFEL_EDITOR_LINE)
			-- Initialize `tokens' with `a_line'.
		require
			a_line_attached: a_line /= Void
		do
			set_tokens (a_line.content)
		end

feature -- Token operation

	set_tokens (a_tokens: LIST [EDITOR_TOKEN])
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

	enable_text_wrap
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

	disable_text_wrap
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

	set_overriden_font (a_font: like overriden_fonts; a_height: INTEGER)
			-- Set `overriden_fonts' with `a_font' and the according height in pixel.
		require
			a_font_attached: a_font /= Void
		do
			lock_update
			overriden_fonts := a_font
			is_position_up_to_date := False
			is_required_width_up_to_date := False
			set_overriden_line_height (a_height)
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_font_set: overriden_fonts = a_font
		end

	remove_overriden_font
			-- Remove `overriden_fonts'.
		do
			lock_update
			overriden_fonts := Void
			is_position_up_to_date := False
			is_required_width_up_to_date := False
			remove_overriden_line_height
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_font_removed: overriden_fonts = Void
		end

	set_overriden_line_height (a_line_height: like overriden_line_height)
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

	remove_overriden_line_height
			-- Remove `overriden_line_height'.
		do
			lock_update
			overriden_line_height := 0
			is_overriden_line_height_set := False
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			overriden_line_height_removed: overriden_line_height = 0 and not is_overriden_line_height_set
		end

	set_overriden_selection_colors (a_focus_color, a_unfocus_color: EV_COLOR)
			-- Set override background colors for selection
		require
			a_focus_color_attached: a_focus_color /= Void
			not_a_focus_color_is_destoryed: not a_focus_color.is_destroyed
			a_unfocus_color_attached: a_unfocus_color /= Void
			not_a_unfocus_color_is_destoryed: not a_unfocus_color.is_destroyed
		do
			focused_selection_color := a_focus_color
			unfocused_selection_color := a_unfocus_color
		ensure
			focused_selection_color_set: focused_selection_color = a_focus_color
			unfocused_selection_color_set: unfocused_selection_color = a_unfocus_color
		end

	remove_overriden_selection_colors
			-- Removed any set overriden selection background colors
		do
			focused_selection_color := Void
			unfocused_selection_color := Void
		ensure
			focused_selection_color_detached: focused_selection_color = Void
			unfocused_selection_color_detached: unfocused_selection_color = Void
		end

	set_maximum_width (a_width: INTEGER)
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

	set_maximum_height (a_height: INTEGER)
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

	set_maximum_size (a_width: INTEGER; a_height: INTEGER)
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

	set_x_offset (a_offset: INTEGER)
			-- Set `x_offset' with `a_offset'.			
		do
			lock_update
			x_offset := a_offset
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			x_offset_set: x_offset = a_offset
		end

	set_y_offset (a_offset: INTEGER)
			-- Set `y_offset' with `a_offset'.			
		do
			lock_update
			y_offset := a_offset
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			y_offset_set: y_offset = a_offset
		end

	set_x_y_offset (a_x_offset, a_y_offset: INTEGER)
			-- Set `x_offset' with `a_x_offset' and `y_offset' with `a_y_offset'.
		do
			lock_update
			x_offset := a_x_offset
			y_offset := a_y_offset
			is_position_up_to_date := False
			unlock_update
			try_call_setting_change_actions
		ensure
			x_offset_set: x_offset = a_x_offset
			y_offset_set: y_offset = a_y_offset
		end

	invalidate
			-- Invalidate current so position recalculation is forced.
		do
			is_position_up_to_date := False
		ensure
			not_is_position_up_to_date: not is_position_up_to_date
		end

feature -- Status report

	is_overriden_font_set: BOOLEAN
			-- Will `overriden_fonts' be used instead of those fonts which are stored in editor tokens?
		do
			Result := overriden_fonts /= Void
		ensure
			good_result: (Result implies overriden_fonts /= Void) and (not Result implies overriden_fonts = Void)
		end

	is_overriden_line_height_set: BOOLEAN
			-- Will `overriden_line_height' be used?

	is_text_wrap_enabled: BOOLEAN
			-- Is text wrap enabled?
			-- Has effect if `maximum_width' is set and some lines in `tokens' needs more room than `maximum_width'.

	is_maximum_width_set: BOOLEAN
			-- Is `maximum_width' set?
		do
			Result := maximum_width > 0
		ensure
			good_result: (Result implies maximum_width > 0) and (not Result implies maximum_width = 0)
		end

	is_maximum_height_set: BOOLEAN
			-- Is `maximum_height' set?
		do
			Result := maximum_height > 0
		ensure
			good_result: (Result implies maximum_height > 0) and (not Result implies maximum_height = 0)
		end

	is_text_truncated: BOOLEAN
			-- Was text of current truncated because of lack of space the last time when it is displayed?

feature -- Display

	display_within_region (x, y, a_width, a_height: INTEGER; a_drawable: EV_DRAWABLE; a_selected_token_index: INTEGER; a_focus: BOOLEAN)
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
			l_last_available_line: INTEGER
			l_need_ell: BOOLEAN
			done: BOOLEAN
			l_line_height: INTEGER
		do
			if not is_position_up_to_date then
				update_position
			end
			l_tokens := adapted_tokens
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

	display (x, y: INTEGER; a_drawable: EV_DRAWABLE; a_selected_token_index: INTEGER; a_focus: BOOLEAN)
			-- Display `tokens' at position (x, y) using `a_drawable'.
			-- `a_selected_token_index' indicates that token should be displayed in its selected status.
			-- `a_focus' indicates whether `tokens' has focus or not.
		require
			a_drawable_attached: a_drawable /= Void
			a_selected_token_index_non_negative: a_selected_token_index >= 0
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
			l_tokens := adapted_tokens
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
					if a_selected_token_index < 0 or l_index = a_selected_token_index then
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

	display_selected (x, y: INTEGER; a_drawable: EV_DRAWABLE; a_focus: BOOLEAN)
			-- Display `tokens' at position (x, y) using `a_drawable' in selected mode.
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
			l_tokens := adapted_tokens
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
					display_selected_token (x + l_pos.item.x, y + l_pos.item.y, l_token, a_focus, a_drawable)
					l_index := l_index + 1
					l_tokens.forth
					l_pos.forth
				end
				l_tokens.go_to (l_cursor)
				l_pos.go_to (l_pos_cursor)
			end
		end

	display_on_editor (a_editor: attached EB_CLICKABLE_EDITOR)
			-- Display text on editor
		local
			l_tokens: like adapted_tokens
			l_pos: like token_position
			l_cursor: LINKED_LIST_CURSOR [EDITOR_TOKEN]
			l_pos_cursor: LINKED_LIST_CURSOR [EV_RECTANGLE]
			l_token: EDITOR_TOKEN
		do
			a_editor.handle_before_processing (False)
			if not is_position_up_to_date then
				update_position
			end
			l_tokens := adapted_tokens
			if not l_tokens.is_empty then
				l_pos := token_position
				l_cursor := l_tokens.cursor
				l_pos_cursor := l_pos.cursor
				from
					l_tokens.start
					l_pos.start
				until
					l_tokens.after
				loop
					l_token := l_tokens.item
					if not l_token.is_new_line then
						a_editor.text_displayed.append_token (l_token)
					else
						a_editor.text_displayed.add_new_line
					end
					l_tokens.forth
					l_pos.forth
				end
				l_tokens.go_to (l_cursor)
				l_pos.go_to (l_pos_cursor)
			end
			a_editor.handle_after_processing
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

	overriden_fonts: SPECIAL [EV_FONT]
			-- Overriden fonts.
			-- If it's Void, default fonts which are defined in editor tokens will be used to display tokens.
			-- If it's not Void, given an editor token `a_token', font at position `a_token.font_id' will be used
			-- to display that token.

	overriden_line_height: INTEGER
			-- Line height in pixel

	focused_selection_color: EV_COLOR
			-- Overriden focused selection color

	unfocused_selection_color: EV_COLOR
			-- Overriden unfocused selection color

	tokens: LINKED_LIST [EDITOR_TOKEN]
			-- `tokens' stored in list
		do
			if internal_tokens = Void then
				create internal_tokens.make
			end
			Result := internal_tokens
		ensure
			result_attached: Result /= Void
		end

	token_position: LINKED_LIST [EV_RECTANGLE]
			-- Position information of every token in `tokens'
		do
			if internal_token_position = Void then
				create internal_token_position.make
			end
			Result := internal_token_position
		ensure
			result_attached: Result /= Void
		end

	string_representation: STRING_32
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
				if attached {EDITOR_TOKEN_EOL} l_tokens.item as l_eol then
					Result.append_character ('%N')
				else
					Result.append (l_tokens.item.wide_image)
				end
				l_tokens.forth
			end
			if l_cursor /= Void then
				l_tokens.go_to (l_cursor)
			end
		ensure
			result_attached: Result /= Void
		end

feature -- Measure

	actual_line_height: INTEGER
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

	required_width: INTEGER
			-- Required width in pixel to fully display `tokens'
		require
			tokens_attached: tokens /= Void
		local
			l_cur_line_width: INTEGER
			l_max_line_width: INTEGER
			l_cursor: CURSOR
			l_tokens: like tokens
			l_token: EDITOR_TOKEN
		do
			if not is_required_width_up_to_date then
				l_tokens := tokens
				if not l_tokens.is_empty then
					l_cursor := l_tokens.cursor
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
							l_cur_line_width := l_cur_line_width + token_width (l_token, l_token.wide_image)
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

	required_height: INTEGER
			-- Required width in pixel to fully display `tokens'
		require
			tokens_attached: tokens /= Void
		local
			l_tokens: like tokens
			l_token: EDITOR_TOKEN
			l_cursor: CURSOR
			x, y: INTEGER
			l_wrapped: BOOLEAN
			l_width: INTEGER
			l_line_height: INTEGER
			l_token_in_current_line: INTEGER
			l_is_max_width_set: BOOLEAN
			l_is_text_wrapped: BOOLEAN
			l_max_width: INTEGER
			l_should_go_forward: BOOLEAN
		do
			l_tokens := tokens
			if not l_tokens.is_empty then
				l_cursor := l_tokens.cursor
				l_wrapped := is_text_wrap_enabled
				l_line_height := actual_line_height
				l_is_max_width_set := is_maximum_width_set
				l_is_text_wrapped := is_text_wrap_enabled
				l_max_width := maximum_width
				from
					x := x_offset
						-- Required height does not include the `y_offset', otherwise it causes the bug#18606.
						-- bug#18606 was actually exposed by rev#88278 where we enlarged the minimum row height.
						-- Because in {EB_GRID_EDITOR_TOKEN_ITEM}.`vertical_starting_position',
						-- computation of left space was enlarged by 2. This makes positive result possible
						-- when divided by alignment value (2), while there was no left space to be divided previously.
						-- The result value, usually 1 or 2, which contributes to {EB_EDITOR_TOKEN_TEXT}.`required_height'
						-- and later being used to compute `vertical_starting_position' again. The y position to draw text
						-- changes back and forth on every call, plus it redraws twice on every key stroke in the completion
						-- window because of selecting. Thus the effect of shifting up and down.
					y := 0
					l_tokens.start
					l_token_in_current_line := 0
				until
					l_tokens.after
				loop
					l_token := l_tokens.item
					l_width := token_width (l_token, l_token.wide_image)
					if l_token.is_new_line or else (l_is_max_width_set and then x + l_width > l_max_width and then l_wrapped) then
						x := 0
						y := y + l_line_height
						l_should_go_forward := l_token.is_new_line or else l_token_in_current_line = 0
						l_token_in_current_line := 0
					else
						x := x + l_width
						l_token_in_current_line := l_token_in_current_line + 1
						l_should_go_forward := True
					end
					if l_should_go_forward then
						l_tokens.forth
					end
				end
				l_tokens.go_to (l_cursor)
			end
			Result := y
			if l_token_in_current_line > 0 then
				Result := Result + l_line_height
			end
		end

	token_index_at_position (x, y: INTEGER): INTEGER
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
				if l_pos.item.has_x_y (x, y) then
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

	pebble (a_index: INTEGER): detachable ANY
			-- Pebble of item at position `a_index'.
		do
			if a_index >= 1 and a_index <= adapted_tokens.count then
				Result := adapted_tokens.i_th (a_index).pebble
			end
		end

feature{NONE} -- Display

	display_token (x, y: INTEGER; a_token: EDITOR_TOKEN; a_drawable: EV_DRAWABLE)
			-- Display `a_token' at position (x, y) using `a_drawable'.
		require
			a_token_attached: a_token /= Void
			a_drawable_attached: a_drawable /= Void
		do
			if not a_token.is_tabulation and then not a_token.is_blank then
					-- Do not draw the token image because it will be rendered too large
				a_drawable.set_font (actual_token_font (a_token))
				a_drawable.set_foreground_color (a_token.text_color)
				a_drawable.draw_text_top_left (x, y, a_token.wide_image)
			end
		end

	display_selected_token (x, y: INTEGER; a_token: EDITOR_TOKEN; a_focus: BOOLEAN; a_drawable: EV_DRAWABLE)
			-- Display `a_token' at position (x, y) in its selected state.
			-- `a_focus' indicates whether `a_token' has focus or not.
		require
			a_token_attached: a_token /= Void
			a_drawable_attached: a_drawable /= Void
		local
			l_font: EV_FONT
			l_color: EV_COLOR
		do
			if a_focus then
				l_color := focused_selection_color
				if l_color = Void then
					a_drawable.set_background_color (a_token.selected_background_color)
				else
					a_drawable.set_background_color (l_color)
				end
				a_drawable.set_foreground_color (a_token.selected_text_color)
			else
				l_color := unfocused_selection_color
				if l_color = Void then
					a_drawable.set_background_color (a_token.focus_out_selected_background_color)
				else
					a_drawable.set_background_color (l_color)
				end
				a_drawable.set_foreground_color (a_token.text_color)
			end
			l_font := actual_token_font (a_token)
			a_drawable.set_font (l_font)
			a_drawable.clear_rectangle (x, y, l_font.string_width (a_token.wide_image), actual_line_height)--l_font.height)
			if not a_token.is_tabulation and then not a_token.is_blank then
				a_drawable.draw_text_top_left (x, y, a_token.wide_image)
			end
		end

feature{NONE} -- Implementation

	actual_token_font (a_token: EDITOR_TOKEN): EV_FONT
			-- Actual used font for `a_token'.
			-- Will take `overriden_fonts' into account.
		require
			a_token_attached: a_token /= Void
			overriden_font_valid: is_overriden_font_set implies (a_token.font_id >=0 and then a_token.font_id < overriden_fonts.count and then overriden_fonts.item (a_token.font_id) /= Void)
		do
			if is_overriden_font_set then
				check
					a_token.font_id >= 0
					a_token.font_id < overriden_fonts.count
					overriden_fonts.item (a_token.font_id) /= Void
				end
				Result := overriden_fonts.item (a_token.font_id)
			else
				Result := a_token.font
			end
		ensure
			result_set:
				(is_overriden_font_set implies Result = overriden_fonts.item (a_token.font_id)) and
				(not is_overriden_font_set implies Result = a_token.font)
		end

	internal_tokens: like tokens
			-- Internal tokens

	internal_token_position: like token_position
			-- Internal token position list

	internal_required_width: INTEGER
			-- Internal `required_width'

	adapted_tokens: like tokens
			-- Adapted tokens for ellipsis display
		do
			if adapted_tokens_internal = Void then
				create adapted_tokens_internal.make
			end
			Result := adapted_tokens_internal
		ensure
			result_attached: Result /= Void
		end

	adapted_tokens_internal: like adapted_tokens
			-- Implementation of `adapted_tokens'

	update_position
			-- Update width information and relative position in every token in `tokens'.
		local
			l_tokens: like tokens
			l_adapted_tokens: like adapted_tokens
			l_position: like token_position
			l_cursor: CURSOR
			x, y: INTEGER
			l_is_max_width_set: BOOLEAN
			l_is_max_height_set: BOOLEAN
			l_max_width: INTEGER
			l_max_height: INTEGER
			l_is_text_wrap_enabled: BOOLEAN
			l_line_height: INTEGER
			l_width_left: INTEGER
			l_token: EDITOR_TOKEN
			l_ellipsis_width: INTEGER
			l_width: INTEGER
			l_token_in_current_line: INTEGER
			l_should_go_forward: BOOLEAN
			l_done: BOOLEAN
			l_split_token: EDITOR_TOKEN
			l_split_token_pos: EV_RECTANGLE
			l_splited: TUPLE [a_splited_token: EDITOR_TOKEN; a_splited_token_position: EV_RECTANGLE; a_ellipsis_position: EV_RECTANGLE]
			l_finished: BOOLEAN
			l_ell_pos: EV_RECTANGLE
			l_x_offset: INTEGER
			l_ellipsis_token: like ellipsis_token
		do
			l_tokens := tokens
			is_text_truncated := False
			if not l_tokens.is_empty then
					-- Clean tokens calculated before.
				l_adapted_tokens := adapted_tokens
				l_adapted_tokens.wipe_out

					-- Clean positions calculated before.
				l_position := token_position
				l_position.wipe_out

					-- Flags setup.
				l_ellipsis_token := ellipsis_token
				l_ellipsis_width := token_width (l_ellipsis_token, l_ellipsis_token.wide_image)
				l_is_text_wrap_enabled := is_text_wrap_enabled
				l_line_height := actual_line_height
				l_is_max_width_set := is_maximum_width_set
				l_is_max_height_set := is_maximum_height_set
				l_x_offset := x_offset
				if l_is_max_height_set then
					l_max_height := maximum_height
				end
				if l_is_max_width_set then
					l_max_width := maximum_width
				end
				l_is_text_wrap_enabled := is_text_wrap_enabled

					-- Update positions.
				l_cursor := l_tokens.cursor
				from
					x := l_x_offset
					y := y_offset
					l_width_left := l_max_width - l_x_offset
					l_tokens.start
					l_should_go_forward := False
				until
					l_tokens.after or l_finished
				loop
					l_token := l_tokens.item
					l_width := token_width (l_token, l_token.wide_image)

					if is_maximum_width_set and then l_width > l_width_left then
						is_text_truncated := True
						check not l_token.is_new_line end
						if
							l_is_text_wrap_enabled and then
							(l_token_in_current_line > 0 and then (l_is_max_height_set implies ((y + 2 * l_line_height) <= l_max_height)))
						then
								-- Place current token `l_token' in a new line.
							 y := y + l_line_height
							 x := l_x_offset
							 l_token_in_current_line := 0
							 l_width_left := l_max_width - l_x_offset

							 	-- Because current token `l_token' has not been positioned, we dont' step forward.
							 l_should_go_forward := False
						else
								-- Current token `l_token' must be placed in current line.
							if x + l_ellipsis_width > l_max_width and then l_token_in_current_line > 0 then
									-- If there is not enough space for display any part of current token plus
									-- ellipsis, we search backward to find a token to adapt.
								from
									l_position.finish
									l_adapted_tokens.finish
									l_done := False
								until
									l_done or else l_position.before
								loop
									l_split_token_pos := l_position.item
										-- We found the token which will be splited.
									l_done := l_position.item.x + l_ellipsis_width <= l_max_width or else l_position.item.x = 0
										-- Store the token regardless, even if not `l_done' that way
										-- we still return the last token in case we do not find a match, this happens
										-- when the previous token is a small string, i.e. smaller than `l_ellipsis_width'.
									l_split_token := l_adapted_tokens.item

									l_position.back
									l_adapted_tokens.back
									l_adapted_tokens.remove_right
									l_position.remove_right
								end
							else
									-- If left space is enough for display part of current token and ellipsis,
									-- or current token is the only token in that line, we just chop current
									-- token apart and display ellipsis after the left part.
								l_split_token := l_token
								create l_split_token_pos.make (x, y, l_width, l_line_height)
							end
								-- Insert splited token and ellipsis.
							l_splited := splited_token_with_ellipsis (l_split_token, l_split_token_pos, l_max_width)
							l_ell_pos := l_splited.a_ellipsis_position
							if l_splited.a_splited_token /= Void then
								l_adapted_tokens.extend (l_splited.a_splited_token)
								l_position.extend (l_splited.a_splited_token_position)
							end
							l_adapted_tokens.extend (ellipsis_token)
							l_position.extend (l_ell_pos)
							if l_is_text_wrap_enabled and then (l_is_max_height_set implies (y + 2 * l_line_height <= l_max_height)) then
								x := l_x_offset
								y := y + l_line_height
								l_token_in_current_line := 0
								l_width_left := l_max_width - l_x_offset
							else
								x := x + l_ell_pos.x + l_ell_pos.width - 1
								l_finished := not (l_is_max_height_set implies (y + 2 * l_line_height <= l_max_height))
							end
							l_should_go_forward := True
						end
					else
						l_adapted_tokens.extend (l_token)
						l_position.extend (create {EV_RECTANGLE}.make (x, y, l_width, l_line_height))
						l_should_go_forward := True
						if l_token.is_new_line then
							if l_is_max_height_set implies (y + 2 * l_line_height <= l_max_height) then
								x := l_x_offset
								y := y + l_line_height
								l_token_in_current_line := 0
								l_width_left := l_max_width - l_x_offset
							else
								l_finished := True
							end
						else
							x := x + l_width
							l_width_left := l_width_left - l_width
							l_token_in_current_line := l_token_in_current_line + 1
						end
					end
					if l_should_go_forward then
						l_tokens.forth
					end
				end
				l_tokens.go_to (l_cursor)
			end
			is_position_up_to_date := True
		ensure
			position_is_up_to_date: is_position_up_to_date
			data_valid: token_position.count = adapted_tokens.count
		end

	splited_token_with_ellipsis (a_token: EDITOR_TOKEN; a_position: EV_RECTANGLE; a_max_width: INTEGER): TUPLE [splited_token: EDITOR_TOKEN; splited_token_position: EV_RECTANGLE; ellipsis_token_positon: EV_RECTANGLE]
			-- Split `a_token' into former part and latter part, and remove the latter part
			-- so there is enough space to display ellipsis "..." after the former part
			-- according to position `a_position' for `a_token' and max width allowed `a_max_width'.
			-- Return the former part in `splited_token', its position in `splited_token_position',
			-- and position for ellipsis in `ellipsis_token_positon'.
		require
			a_token_attached: a_token /= Void
			a_position_attached: a_position /= Void
		local
			l_splited_token_position: EV_RECTANGLE
			l_ellipsis_position: EV_RECTANGLE
			l_image: IMMUTABLE_STRING_32
			l_min_count, l_max_count: INTEGER
			l_start_x: INTEGER
			l_ellipsis_width: INTEGER
			l_line_height: INTEGER
			l_token_width: INTEGER
			l_ellipsis_token: like ellipsis_token
			l_mid: INTEGER
		do
			l_start_x := a_position.x
			l_line_height := actual_line_height
			l_ellipsis_token := ellipsis_token
			l_ellipsis_width := token_width (l_ellipsis_token, l_ellipsis_token.wide_image)
			if
				attached {EDITOR_TOKEN_TEXT} a_token.twin as l_editor_token and then
				not l_editor_token.wide_image.is_empty
			then
				l_token_width := token_width (l_editor_token, l_editor_token.wide_image)
				if l_start_x + l_token_width + l_ellipsis_width > a_max_width then
					from
						create l_image.make_from_string_32 (l_editor_token.wide_image)
							-- If this is the first token we always keep its first letter, otherwise
							-- it is ignored.
						if a_position.x = x_offset then
							l_min_count := 2
						else
							l_min_count := 1
						end
						l_max_count := l_image.count
					until
						l_max_count < l_min_count
					loop
						l_mid := (l_min_count + l_max_count) // 2
						l_token_width := token_width (l_editor_token, l_image.shared_substring (1, l_mid))
						if l_start_x + l_token_width + l_ellipsis_width <= a_max_width then
							l_min_count := l_mid + 1
						else
							l_max_count := l_mid - 1
						end
					end
					l_image := l_image.shared_substring (1, l_max_count)
					l_editor_token.set_image (l_image.as_string_32)
					l_token_width := token_width (l_editor_token, l_image)
				end
				create l_splited_token_position.make (l_start_x, a_position.y, l_token_width, l_line_height)
				create l_ellipsis_position.make (l_start_x + l_token_width, a_position.y, l_ellipsis_width, l_line_height)
				Result := [l_editor_token, l_splited_token_position, l_ellipsis_position]
			else
				create l_ellipsis_position.make (l_start_x, a_position.y, l_ellipsis_width, l_line_height)
				Result := [Void, Void, l_ellipsis_position]
			end
		ensure
			result_attached: Result /= Void
			result_valid: (Result.splited_token /= Void implies Result.splited_token_position /= Void) and then
						  (Result.splited_token = Void implies Result.splited_token_position = Void) and then
						  (Result.ellipsis_token_positon /= Void)
		end

	ellipsis_token: EDITOR_TOKEN_SYMBOL
			-- Editor token for "..."
		do
			create Result.make (interface_names.l_ellipsis)
		ensure
			result_attached: Result /= Void
		end

	token_width (a_token: EDITOR_TOKEN; a_image: READABLE_STRING_32): INTEGER
			-- Width in pixel of `a_image' using font in `a_token' or `overriden_fonts' if `is_overriden_font_set'.
		require
			a_token_attached: a_token /= Void
			a_image_attached: a_image /= Void
		do
			if is_overriden_font_set then
				check
					a_token.font_id >= 0
					a_token.font_id < overriden_fonts.count
					overriden_fonts.item (a_token.font_id) /= Void
				end
				if a_token.is_tabulation then
					Result := a_token.editor_preferences.tabulation_spaces * overriden_fonts.item (a_token.font_id).string_width (once " ")
				else
					Result := overriden_fonts.item (a_token.font_id).string_width (a_image)
				end
			elseif not a_token.is_tabulation then
				Result := a_token.font.string_width (a_image)
			else
				Result := a_token.width
			end
		end

note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
