indexing
	description: "Object that represents a grid item in which pick-and-dropable editor tokens are displayed"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_EDITOR_TOKEN_ITEM

inherit
	EV_GRID_DRAWABLE_ITEM
		redefine
			initialize
		end

	EVS_TEXT_ALIGNABLE
		undefine
			copy,
			is_equal,
			default_create
		end

	EVS_BORDERED
		export
			{NONE}all
		undefine
			copy,
			is_equal,
			default_create
		end

create
	default_create,
	make_with_text

feature{NONE} -- Initialization

	make_with_text (a_text: STRING) is
			-- Create `Current' and assign `a_text' to `text'
		require
			a_text_attached: a_text /= Void
		do
			default_create
			set_text (a_text)
		ensure
			text_set: text.is_equal (a_text)
		end

	initialize is
		do
			align_text_left
			align_text_vertically_center
			set_left_border (1)
			set_right_border (1)
			set_top_border (1)
			set_bottom_border (1)
			set_spacing (0)
			expose_actions.extend (agent perform_redraw)
			setting_change_actions.extend (agent safe_redraw)
			Precursor
		end

feature -- Setting

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Display image of `a_pixmap' on `Current'.
		require
			not_destroyed: not is_destroyed
			pixmap_not_void: a_pixmap /= Void
		do
			lock_update
			pixmap := a_pixmap
			unlock_update
			try_call_setting_change_actions
		ensure
			pixmap_set: pixmap = a_pixmap
		end

	remove_pixmap is
			-- Remove image displayed on `Current'.
		require
			not_destroyed: not is_destroyed
		do
			lock_update
			pixmap := Void
			unlock_update
			try_call_setting_change_actions
		ensure
			pixmap_removed: pixmap = Void
		end

	set_spacing (a_spacing: INTEGER) is
			-- Assign `a_spacing' to `spacing'.
		require
			not_destroyed: not is_destroyed
			a_spacing_non_negative: a_spacing >= 0
		do
			lock_update
			spacing := a_spacing
			unlock_update
			try_call_setting_change_actions
		ensure
			spacing_set: spacing = a_spacing
		end

	set_text_with_tokens (a_tokens: LIST [EDITOR_TOKEN]) is
			-- Set `tokens' with `a_tokens'.
		do
			lock_update
			if a_tokens = Void or else a_tokens.is_empty then
				editor_token_text.set_tokens (create{ARRAYED_LIST [EDITOR_TOKEN]}.make (0))
			else
				editor_token_text.set_tokens (a_tokens)
			end
			unlock_update
			try_call_setting_change_actions
		end

	set_text (a_text: STRING) is
			-- Set `text' with `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_writer: like token_writer
		do
			lock_update
			l_writer := token_writer
			l_writer.new_line
			l_writer.add (a_text)
			set_text_with_tokens (l_writer.last_line.content)
			unlock_update
			try_call_setting_change_actions
		ensure
			text_set: text.is_equal (a_text)
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Image displayed to left of `tokens'.

	spacing: INTEGER
			-- Spacing between `text' and `pixmap' in pixels.
			-- If both are not visible, this value does not affect appearance of `Current'.

	editor_token_text: EB_EDITOR_TOKEN_TEXT is
			-- Editor token text
		require
			not_destroyed: not is_destroyed
		do
			if editor_token_text_internal = Void then
				create editor_token_text_internal
			end
			Result := editor_token_text_internal
		ensure
			result_attached: Result /= Void
		end

	text: STRING is
			-- Text of current item.
		do
			Result := editor_token_text.string_representation
		ensure
			result_attached: Result /= Void
		end

feature{NONE} -- Redraw

	black_color: EV_COLOR is
			--
		local
			l_colors: EV_STOCK_COLORS
		once
			create l_colors
			Result := l_colors.black
		end

	gray_color: EV_COLOR is
			--
		local
			l_colors: EV_STOCK_COLORS
		once
			create l_colors
			Result := l_colors.gray
		end

	focused_selected_border_color: EV_COLOR is
			-- Border color of a focused and selected item
		do
			Result := black_color
		ensure
			result_attached: Result /= Void
		end

	non_focused_selected_border_color: EV_COLOR is
			-- Border color of a non-focused selected item
		do
			Result := gray_color
		ensure
			result_attached: Result /= Void
		end

	perform_redraw (a_drawable: EV_DRAWABLE) is
			-- Draw current in `a_drawable'.
		require
			not_destroyed: not is_destroyed
			a_drawable_not_void: a_drawable /= Void
			parented: is_parented
		local
			l_pixmap_x, l_pixmap_y: INTEGER
			l_border_line_width: INTEGER
			l_text_x, l_text_y: INTEGER
			l_y_space_left: INTEGER
			l_x_space_left: INTEGER
			l_spacing: INTEGER
			l_x_offset: INTEGER
			l_pixmap_width: INTEGER
			l_editor_token: like editor_token_text
			l_parent: EV_GRID
			l_focused: BOOLEAN
		do
			l_parent := parent
			l_focused := l_parent.has_focus
				-- Clear item region
			if row.background_color /= Void then
				a_drawable.set_foreground_color (row.background_color)
			else
				a_drawable.set_foreground_color (l_parent.background_color)
			end
			a_drawable.fill_rectangle (0, 0, width, height)

				-- Draw border
			if is_selected then
					-- We always use focused selection color because use non-focused selection color
					-- to draw a border rectangle is not obvious enough.
				a_drawable.set_foreground_color (l_parent.focused_selection_color)
				a_drawable.set_line_width (1)
				a_drawable.draw_rectangle (0, 0, width, height)
			end
				-- Draw pixmap
			if pixmap /= Void then
				l_pixmap_x := l_border_line_width + left_border
				l_pixmap_y := ((height - pixmap.height) - border_line_width * 2 - top_border - bottom_border) // 2
				if l_pixmap_y < 0 then
					l_pixmap_y := 0
				end
				a_drawable.draw_pixmap (l_pixmap_x, l_pixmap_y, pixmap)
				l_spacing := spacing
				l_pixmap_width := pixmap.width
			end
				-- Draw text
			l_editor_token := editor_token_text
			if not l_editor_token.tokens.is_empty then
				l_text_x := l_pixmap_width + l_spacing + border_line_width + left_border
				if not is_left_aligned then
					l_x_space_left := width - l_pixmap_width - l_spacing - border_line_width * 2 - left_border - right_border
					l_x_offset := l_x_space_left - l_editor_token.required_width
					if l_x_offset < 0 then
						l_x_offset := 0
					end
					if is_right_aligned then
						l_text_x := l_text_x + l_x_offset
					elseif is_center_aligned then
						l_text_x := l_x_offset // 2
					end
				end
				if is_top_aligned then
					l_text_y := border_line_width + top_border
				elseif is_bottom_aligned then
					l_text_y := height - border_line_width - bottom_border - editor_token_text.actual_line_height
				elseif is_vertically_center_aligned then
					l_y_space_left := height - border_line_width * 2 - bottom_border - top_border - editor_token_text.actual_line_height
					l_text_y := border_line_width + top_border
					if l_y_space_left > 0 then
						l_text_y := l_text_y + l_y_space_left // 2
					end
				end
				if l_text_x /= l_editor_token.x_offset or l_text_y /= l_editor_token.y_offset then
					l_editor_token.set_x_y_offset (l_text_x, l_text_y)
				end
				l_editor_token.display (0, 0, a_drawable, last_picked_token, l_focused)
			end
		end

feature{NONE} -- Owner actions

	owner_pointer_enter_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer enter actions of owner of current tooltip
			-- Attach this to owner's `pointer_enter_actions'.
		do
			Result := pointer_enter_actions
		end

	owner_pointer_leave_actions: EV_NOTIFY_ACTION_SEQUENCE is
			-- Pointer leave actions of owner of current tooltip
			-- Attach this to owner's `pointer_leave_actions'.			
		do
			Result := pointer_leave_actions
		end

feature{EVS_GENERAL_TOOLTIP_WINDOW} -- Status report

	is_owner_destroyed: BOOLEAN is
			-- If owner destroyed
			-- Attach this to owner's `is_destroyed'.
		do
			Result := is_destroyed
		end

feature{NONE} -- Implementation

	editor_token_text_internal: like editor_token_text
			-- Internal `editor_token_text'

	safe_redraw is
			-- Redraw current item if it's parented
		require
			not_destroyed: not is_destroyed
		local
			l_required_width: INTEGER
		do
			l_required_width := border_line_width * 2 + left_border + right_border + editor_token_text.required_width
			if pixmap /= Void then
				l_required_width := l_required_width + pixmap.width + spacing
			end
			set_required_width (l_required_width)
			if is_parented then
				redraw
			end
		end

	token_writer: EDITOR_TOKEN_WRITER is
			-- Editor token writer used to generate `tokens'
		once
			create {EB_EDITOR_TOKEN_GENERATOR}Result.make
		ensure
			result_attached: Result /= Void
		end

feature -- Pick and drop

	last_picked_token: INTEGER
			-- Index of picked token in `editor_token_text'
			-- 0 means no token is picked.

	set_last_picked_token (a_index: INTEGER) is
			-- Set `last_picked_token' with `a_index'.
		require
			a_index_valid: a_index >= 0 and a_index <= editor_token_text.tokens.count
		do
			last_picked_token := a_index
		ensure
			last_picked_token_set: last_picked_token = a_index
		end

	token_index_at_current_position: INTEGER is
			-- Index of token that is below current pointer
		local
			l_x: INTEGER
			l_y: INTEGER
			l_index: INTEGER
			l_editor_token_text: like editor_token_text
		do
			l_editor_token_text := editor_token_text
			if not l_editor_token_text.tokens.is_empty then
				l_x := parent.pointer_position.x - (virtual_x_position - parent.virtual_x_position )
				l_y := parent.pointer_position.y - (virtual_y_position - parent.virtual_y_position ) - parent.header.height
				Result := l_editor_token_text.token_index_at_position (l_x, l_y)
			end
		end

	editor_token_pebble (a_index: INTEGER): ANY is
			-- Pebble of token item indicated by `a_index'
			-- Void if no pebble available.
		local
			l_editor_token_text: like editor_token_text
		do
			l_editor_token_text := editor_token_text
			if a_index > 0 and then a_index <= l_editor_token_text.tokens.count then
				Result := l_editor_token_text.tokens.i_th (a_index).pebble
			end
		ensure
			good_result: a_index > 0 and then a_index <= editor_token_text.tokens.count implies
				Result = editor_token_text.tokens.i_th (a_index).pebble
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
