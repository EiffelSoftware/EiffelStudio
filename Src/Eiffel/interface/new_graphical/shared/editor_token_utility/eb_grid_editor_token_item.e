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

	EB_SHARED_PREFERENCES
		undefine
			copy,
			is_equal,
			default_create
		end

	EB_SHARED_WRITER
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
			set_spacing (2)
			expose_actions.extend (agent perform_redraw)
			setting_change_actions.extend (agent safe_redraw)
			on_pointer_button_pressed_agent := agent on_pointer_button_pressed
			on_pointer_double_press_agent := agent on_pointer_double_pressed
			on_pointer_move_agent := agent on_pointer_move
			on_pointer_leave_agent := agent on_pointer_leave
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

	set_overriden_fonts (a_fonts: SPECIAL [EV_FONT]) is
			-- Set fonts of current tokens with `a_fonts'.
			-- If `a_fonts' is Void, tokens will be displayed in default editor token fonts.
		do
			lock_update
			editor_token_text.set_overriden_font (a_fonts)
			unlock_update
			try_call_setting_change_actions
		end

	set_trailer_spacing (a_spacing: INTEGER_32)
			-- Set `trailer_spacing' with `a_spacing'.
		do
			lock_update
			trailer_spacing := a_spacing
			unlock_update
			try_call_setting_change_actions
		ensure
			trailer_spacing_set: trailer_spacing = a_spacing
		end

	set_trailer_padding (a_padding: INTEGER_32)
			-- Set `trailer_padding' with `a_padding'.
		do
			lock_update
			trailer_padding := a_padding
			unlock_update
			try_call_setting_change_actions
		ensure
			trailer_padding_set: trailer_padding = a_padding
		end

	insert_trailer (a_trailer: EB_GRID_EDITOR_TOKEN_ITEM_TRAILER; a_index: INTEGER_32)
			-- Insert `a_trailer' at 1-based position indexed by `a_index' in `trailers'.
		require
			a_trailer_valid: a_trailer /= Void and then not a_trailer.is_parented
			a_index_valid: a_index >= 1 and then a_index <= trailer_count + 1
		local
			l_trailers: like trailers
		do
			lock_update
			a_trailer.attach (Current)
			if a_index <= trailer_count then
				l_trailers := trailers
				l_trailers.go_i_th (a_index)
				l_trailers.put_left (a_trailer)
			else
				trailers.extend (a_trailer)
			end
			unlock_update
			try_call_setting_change_actions
			install_trailer_actions
		ensure
			trailer_inserted:
				trailers.has (a_trailer) and then a_trailer.is_parented and then a_trailer.grid_item = Current and then
				trailer_count = old trailer_count + 1
		end

	remove_trailer (a_index: INTEGER_32)
			-- Remove trail from `trailers' at position indexed by `a_index'.
		require
			a_index_valid: a_index >= 1 and a_index <= trailer_count
		local
			l_trailers: like trailers
		do
			lock_update
			l_trailers := trailers
			l_trailers.go_i_th (a_index)
			l_trailers.item.detach
			l_trailers.remove
			unlock_update
			try_call_setting_change_actions
			if l_trailers.is_empty then
				uninstall_trailer_actions
			end
		ensure
			trailer_removed: trailer_count = old trailer_count - 1
		end

	enable_adhesive_trailer
			-- Enable adhesive trailer.
		do
			lock_update
			is_trailer_adhesive_enabled := True
			unlock_update
			try_call_setting_change_actions
		ensure
			adhesive_trailer_enabled: is_trailer_adhesive_enabled
		end

	disable_adhesive_trailer
			-- Disable adhesive trailer.
		do
			lock_update
			is_trailer_adhesive_enabled := False
			unlock_update
			try_call_setting_change_actions
		ensure
			adhesive_trailer_disabled: not is_trailer_adhesive_enabled
		end

	ensure_trailer_display is
			-- Ensure display of `trailers'.
			-- See `is_trailer_display_ensured' for more information.
		do
			is_trailer_display_ensured := True
		ensure
			trailer_display_ensured: is_trailer_display_ensured
		end

	ensure_text_display is
			-- Ensure display of `editor_token_text'.
			-- See `is_trailer_display_ensured' for more information.
		do
			is_trailer_display_ensured := False
		ensure
			text_display_ensured: not is_trailer_display_ensured
		end

	set_general_tooltip (a_tooltip: like general_tooltip) is
			-- Set `general_tooltip' with `a_tooltip' and enable it at the same time.
			-- Note: If `trailers' is not empty and pointer is over a trailer area, this tooltip won't be displayed.
		require
			a_tooltip_attached: a_tooltip /= Void
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
			end
			general_tooltip := a_tooltip
			if not general_tooltip.veto_tooltip_display_functions.has (veto_general_tooltip_agent) then
				general_tooltip.veto_tooltip_display_functions.extend (veto_general_tooltip_agent)
			end
			general_tooltip.enable_tooltip
		ensure
			general_tooltip_set: general_tooltip = a_tooltip
		end

	remove_general_tooltip is
			-- Remove `general_tooltip'.
		do
			if general_tooltip /= Void then
				general_tooltip.disable_tooltip
				if general_tooltip.veto_tooltip_display_functions.has (veto_general_tooltip_agent) then
					general_tooltip.veto_tooltip_display_functions.prune_all (veto_general_tooltip_agent)
				end
			end
			general_tooltip := Void
		ensure
			general_tooltip_removed: general_tooltip = Void
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Image displayed to left of `tokens'.

	spacing: INTEGER
			-- Spacing between `text' and `pixmap' in pixels.
			-- If both are not visible, this value does not affect appearance of `Current'.

	text: STRING is
			-- Text of current item.
		do
			Result := editor_token_text.string_representation
		ensure
			result_attached: Result /= Void
		end

	token_at_position (a_pos: INTEGER): EDITOR_TOKEN is
			-- Token at `a_pos' in `editor_token_text'
		require
			a_pos_positive: a_pos > 0
		do
			if a_pos <= editor_token_text.tokens.count then
				Result := editor_token_text.tokens.i_th (a_pos)
			end
		end

	trailer_spacing: INTEGER_32
			-- Space in pixel between text and the first trailer

	trailer_padding: INTEGER_32
			-- Space in pixel between two trailers

	trailer_count: INTEGER_32
			-- Number of trailers attached to Current
		do
			Result := trailers.count
		ensure
			good_result: Result = trailers.count
		end

	trailer (a_index: INTEGER_32): EB_GRID_EDITOR_TOKEN_ITEM_TRAILER
			-- Trailer in `trailers' at position indexed by 1-based `a_index'
		require
			a_index_valid: a_index >= 1 and a_index <= trailer_count
		do
			Result := trailers.i_th (a_index)
		ensure
			result_attached: Result /= Void
		end

	general_tooltip: EVS_GENERAL_TOOLTIP
			-- General tooltip used to display information
			-- Use this tooltip if normal tooltip provided cannot satisfy,
			-- for example, you want to be able to pick and drop from/to tooltip.

feature -- Status report

	is_trailer_adhesive_enabled: BOOLEAN
			-- Is trailer adhesive?
			-- Trailer is adhesive means trailer appears right after text.
			-- For example, following is a grid item with non-adhesive trailer:
			-- +--------------------------------+
			-- | Text                    Trailer|
			-- +--------------------------------+
			-- And following is a grid item with adhesive trailer:
			-- +--------------------------------+
			-- | Text Trailer                   |
			-- +--------------------------------+

	is_trailer_display_ensured: BOOLEAN
			-- Is display of `trailers' ensured?
			-- A True value  means that text wil be truncated first to ensure that all (or most) part of `trailers'
			-- can be displayed. A False value means that we first ensure that text is displayed mostly.

	is_text_display_ensured: BOOLEAN is
			-- Is display of `editor_token_text' ensured?
			-- A True value means that all or most part of text in `editor_token_text' will be display first, and then `trailers'.
			-- A False value means we try to display `trailers' first.
		do
			Result := not is_trailer_display_ensured
		ensure
			good_result: Result = not is_trailer_display_ensured
		end

	is_text_truncated: BOOLEAN is
			-- Was text of current truncated because of lack of space the last time when it is displayed?
		do
			Result := editor_token_text.is_text_truncated
		end

feature{NONE} -- Redraw

	perform_redraw (a_drawable: EV_DRAWABLE)
		local
			l_x_offset: INTEGER
			l_required_text_width: INTEGER
			l_required_trailer_width: INTEGER
			l_token_text: like editor_token_text
			l_left_width: INTEGER
			l_text_start_x: INTEGER
			l_trailer_start_x: INTEGER
			l_width_for_text_and_trailer: INTEGER
			l_max_text_width: INTEGER
		do
			prepare_grid_area (a_drawable)
			l_x_offset := border_line_width + left_border
			if pixmap /= Void then
				draw_pixmap (a_drawable, l_x_offset)
				l_x_offset := pixmap.width + spacing
			end
				-- Calculate text position and trailer position.
			l_token_text := editor_token_text
			l_required_text_width := l_token_text.required_width
			l_required_trailer_width := required_trailer_width
			l_left_width := (width - l_x_offset - right_border - border_line_width).max (1)
			l_width_for_text_and_trailer := l_required_text_width + l_required_trailer_width
			if l_required_trailer_width = 0 then
				if is_center_aligned then
					l_text_start_x := ((l_left_width - l_required_text_width) // 2).max (0)
				elseif is_right_aligned then
					l_text_start_x := (l_left_width - l_required_text_width).max (0)
				end
				l_max_text_width := l_left_width.max (1)
			elseif l_left_width >= l_width_for_text_and_trailer then
				l_max_text_width := l_required_text_width
				if is_left_aligned then
					l_text_start_x := 0
					if is_trailer_adhesive_enabled then
						l_trailer_start_x := l_required_text_width
					else
						l_trailer_start_x := (l_left_width - l_required_trailer_width).max (1)
					end
				elseif is_center_aligned then
					l_text_start_x := ((l_left_width - l_width_for_text_and_trailer) // 2).max (0)
					if is_trailer_adhesive_enabled then
						l_trailer_start_x := (l_text_start_x + l_required_text_width).max (1)
					else
						l_trailer_start_x := (l_left_width - l_required_trailer_width).max (1)
					end
				elseif is_right_aligned then
					l_text_start_x := (l_left_width - l_width_for_text_and_trailer).max (0)
					l_trailer_start_x := (l_left_width - l_required_trailer_width).max (1)
				end
			elseif l_width_for_text_and_trailer > l_left_width and then l_left_width >= l_required_text_width  then
				l_text_start_x := 0
				if is_trailer_display_ensured then
					l_trailer_start_x := (l_left_width - l_required_trailer_width).max (1)
					l_max_text_width := l_trailer_start_x
				else
					l_trailer_start_x := l_required_text_width
					l_max_text_width := l_required_text_width
				end
			elseif l_left_width < l_required_text_width then
				l_text_start_x := 0
				if is_trailer_display_ensured then
					l_trailer_start_x := (l_left_width - l_required_trailer_width).max (1)
					l_max_text_width := l_trailer_start_x
				else
					l_max_text_width := l_left_width
					l_trailer_start_x := l_left_width
				end
			else
				check False end
			end
			l_text_start_x := l_text_start_x + l_x_offset
			l_trailer_start_x := l_trailer_start_x + l_x_offset
			draw_text (a_drawable, l_text_start_x, l_max_text_width + l_text_start_x, parent.has_focus)
			if l_required_trailer_width > 0 then
				draw_trailers (a_drawable, l_trailer_start_x)
			end
		end

	prepare_grid_area (a_drawable: EV_DRAWABLE)
			-- Prepare area in `a_drawable' for drawing current item.
			-- i.e., clean area and draw background and draw borders.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_editor_data: EB_EDITOR_DATA
			l_parent: EV_GRID
		do
			l_parent := parent
			if background_color /= Void then
				a_drawable.set_foreground_color (background_color)
			elseif row.background_color /= Void then
				a_drawable.set_foreground_color (row.background_color)
			else
				a_drawable.set_foreground_color (parent.background_color)
			end
			a_drawable.fill_rectangle (0, 0, width, height)
			if is_selected then
				l_editor_data := preferences.editor_data
				if l_parent.has_focus then
					a_drawable.set_foreground_color (l_editor_data.selection_background_color)
				else
					a_drawable.set_foreground_color (l_editor_data.focus_out_selection_background_color)
				end
				a_drawable.fill_rectangle (0, 0, width, height)
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
			l_required_width := border_line_width * 2 + left_border + right_border + editor_token_text.required_width + required_trailer_width
			if pixmap /= Void then
				l_required_width := l_required_width + pixmap.width + spacing
			end
			set_required_width (l_required_width)
			if is_parented then
				redraw
			end
		end

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

feature -- Pick and drop

	last_picked_token: INTEGER
			-- Index of picked token in `editor_token_text'
			-- 0 means no token is picked.

	set_last_picked_token (a_index: INTEGER) is
			-- Set `last_picked_token' with `a_index'.
		require
			a_index_valid: a_index >= 0
		do
			check a_index <= editor_token_text.tokens.count end
			last_picked_token := a_index
		ensure
			last_picked_token_set: last_picked_token = a_index
		end

	token_index_at_current_position: INTEGER is
			-- Index of token that is current position
			-- 0 if no token is below that position.
		local
			l_editor_token_text: like editor_token_text
			l_relative_position: like relative_pointer_position
		do
			l_editor_token_text := editor_token_text
			if not l_editor_token_text.tokens.is_empty then
				l_relative_position := relative_pointer_position
				Result := l_editor_token_text.token_index_at_position (l_relative_position.x, l_relative_position.y)
			end
		end

	relative_position (a_x, a_y: INTEGER): EV_COORDINATE is
			-- Position relative to top-left corner of current grid item from (`a_x', `a_y')
		local
			l_x: INTEGER
			l_y: INTEGER
			l_header_height: INTEGER
		do
			l_x := a_x - (virtual_x_position - parent.virtual_x_position )
			if parent.is_header_displayed then
				l_header_height := parent.header.height
			end
			l_y := a_y - (virtual_y_position - parent.virtual_y_position ) - l_header_height
			create Result.make (l_x, l_y)
		ensure
			result_attached: Result /= Void
		end

	relative_pointer_position: EV_COORDINATE is
			-- Pointer position relative to top-left corner of current grid item
		local
			l_parent_pointer_position: EV_COORDINATE
		do
			l_parent_pointer_position := parent.pointer_position
			Result := relative_position (l_parent_pointer_position.x, l_parent_pointer_position.y)
		ensure
			result_attached: Result /= Void
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

feature{NONE} -- Implementation

	trailers: ARRAYED_LIST [EB_GRID_EDITOR_TOKEN_ITEM_TRAILER]
			-- List of trails attached to Current item
		do
			if trailers_internal = Void then
				create trailers_internal.make (1)
			end
			Result := trailers_internal
		ensure
			result_attached: Result /= Void
		end

	trailers_internal: like trailers
			-- Implementation of `trailers'

	required_trailer_width: INTEGER_32
			-- Required width in pixel for displaying all attached `trailers'
		local
			l_trailer: like trailers
		do
			l_trailer := trailers
			if not l_trailer.is_empty then
				from
					l_trailer.start
				until
					l_trailer.after
				loop
					Result := Result + l_trailer.item.required_width
					l_trailer.forth
				end
				Result := Result + trailer_spacing + (l_trailer.count - 1) * trailer_padding
			end
		ensure
			result_attached: Result >= 0
		end

	required_trailer_height: INTEGER_32
			-- Required height in pixel to display all attached `trailers'
		local
			l_trailer: like trailers
			l_height: INTEGER_32
		do
			l_trailer := trailers
			if not l_trailer.is_empty then
				from
					l_trailer.start
				until
					l_trailer.after
				loop
					l_height := l_trailer.item.required_height
					if l_height > Result then
						Result := l_height
					end
					l_trailer.forth
				end
			end
		ensure
			result_attached: Result >= 0
		end

	required_width_for_text_and_trailer: INTEGER_32
			-- Required width in pixel to display text and trailers.
		do
			Result := editor_token_text.required_width + required_trailer_width
		ensure
			result_attached: Result >= 0
		end

	required_height_for_text_and_trailer: INTEGER_32
			-- Required height in pixel to display text and trailers.	
		do
			Result := editor_token_text.required_height.max (required_trailer_height)
		ensure
			result_attached: Result >= 0
		end

	draw_pixmap (a_drawable: EV_DRAWABLE; a_start_x: INTEGER_32)
			-- Display `pixmap' in `a_drawable' from `a_start_x'.
			-- Pixmap is always vertically center aligned.
		require
			a_drawable_attached: a_drawable /= Void
			pixmap_attached: pixmap /= Void
		do
			a_drawable.draw_pixmap (a_start_x, vertical_starting_position (pixmap.height, 2, False), pixmap)
		end

	draw_text (a_drawable: EV_DRAWABLE; a_start_x: INTEGER_32; a_max_width: INTEGER_32; a_focused: BOOLEAN)
			-- Draw text in `a_drawable' starting from `a_start_x'.
			-- The maximum width in pixel for text is `a_max_width'.
			-- `a_focused' indicates whether current item is selected.
		require
			a_drawable_attached: a_drawable /= Void
		local
			y: INTEGER_32
			l_token_text: like editor_token_text
			l_should_update: BOOLEAN
		do
			l_token_text := editor_token_text
			if not l_token_text.tokens.is_empty then
				y := vertical_starting_position (l_token_text.required_height, alignment_index, True)
				l_token_text.lock_update
				if a_start_x /= l_token_text.x_offset or y /= l_token_text.y_offset then
					l_token_text.set_x_y_offset (a_start_x, y)
					l_should_update := True
				end
				if a_max_width /= l_token_text.maximum_width then
					l_token_text.set_maximum_width (a_max_width)
					l_should_update := True
				end
				l_token_text.unlock_update
				if l_should_update then
					l_token_text.try_call_setting_change_actions
				end
				if is_selected then
					l_token_text.display_selected (0, 0, a_drawable, a_focused)
				else
					l_token_text.display (0, 0, a_drawable, last_picked_token, a_focused)
				end
			end
		end

	alignment_index: INTEGER_32
			-- Index of alignment
		do
			if is_vertically_center_aligned then
				Result := 2
			elseif is_top_aligned then
				Result := 3
			elseif is_bottom_aligned then
				Result := 1
			end
		ensure
			good_result: Result = 1 or Result = 2 or Result = 3
		end

	draw_trailers (a_drawable: EV_DRAWABLE; a_start_x: INTEGER_32)
			-- Draw `trailers' in `a_drawable' starting from `a_start_x'.
			-- `trailers' are always vertically center aligned.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_trailers: like trailers
			x, y: INTEGER_32
			l_count: INTEGER_32
			l_trailer_padding: INTEGER_32
			l_trailer: EB_GRID_EDITOR_TOKEN_ITEM_TRAILER
			l_trailer_position: like trailer_position
			l_width, l_height: INTEGER
		do
			l_trailers := trailers
			if not l_trailers.is_empty then

			end
			l_trailer_position := trailer_position
			if not l_trailers.is_empty then
				l_trailer_position.wipe_out
				l_trailer_padding := trailer_padding
				from
					x := a_start_x + trailer_spacing
					l_count := l_trailers.count
					l_trailers.start
				until
					l_trailers.after
				loop
					l_trailer := l_trailers.item
					y := vertical_starting_position (l_trailer.required_height, 2, False)
					l_width := l_trailer.required_width
					l_height := l_trailer.required_height
					l_trailer.draw (a_drawable, x, y)
					l_trailer_position.extend (create {EV_RECTANGLE}.make (x, y, l_width, l_height))
					x := x + l_trailer.required_width
					if l_trailers.index < l_count then
						x := x + l_trailer_padding
					end
					l_trailers.forth
				end
			end
		end

	vertical_starting_position (a_required_height: INTEGER_32; a_align: INTEGER_32; a_border_enabled: BOOLEAN): INTEGER_32
			-- Vertical starting position for an object to be displayed which is `a_required_height' pixel high.
			-- `a_align' is vertical alignment policy whose value has the following meaning:
			--   1. Bottom aligned
			--   2. Center aligned
			--   3. Top aligned
			-- If `a_border_enabled' is False, do take `border_line_width' and `top_border' into consideration.
		require
			a_align_valid: a_align = 1 or a_align = 2 or a_align = 3
		local
			l_space_left: INTEGER_32
			l_vertical_base: INTEGER_32
			l_y_offset: INTEGER_32
		do
			if a_border_enabled then
				l_vertical_base := border_line_width + top_border
				l_space_left := height - 2 * border_line_width - top_border - bottom_border
			else
				l_space_left := height
			end
			if l_space_left < 0 or else a_align = 3 then
				Result := l_vertical_base
			else
				l_y_offset := ((l_space_left - a_required_height) // a_align).max (0)
				Result := l_vertical_base + l_y_offset
			end
		end

	trailer_position: LINKED_LIST [EV_RECTANGLE] is
			-- Position area of `trailers'
		do
			if trailer_position_internal = Void then
				create trailer_position_internal.make
			end
			Result := trailer_position_internal
		ensure
			result_attached: Result /= Void
		end

	trailer_position_internal: like trailer_position
			-- Implementation of `trailer_position'

	is_position_in_area (a_x, a_y: INTEGER; a_rec: EV_RECTANGLE): BOOLEAN is
			-- Is position (`a_x', `a_y') in area defined by `a_rec'?
		require
			a_rec_attached: a_rec /= Void
		do
			Result := a_rec.has_x_y (a_x, a_y)
		end

	is_pointer_in_trailer: BOOLEAN
			-- Is pointer in trailer for the moment?

	is_ponter_out_of_trailer: BOOLEAN is
			-- Is pointer out of trailer area?
		do
			Result := not is_pointer_in_trailer
		end

	set_is_pointer_in_trailer (b: BOOLEAN) is
			-- Set `is_ponter_in_trailer' with `b'.
		do
			is_pointer_in_trailer := b
		ensure
			is_pointer_in_trailer_set: is_pointer_in_trailer = b
		end

	veto_general_tooltip_agent: FUNCTION [ANY, TUPLE, BOOLEAN] is
			-- Agent to veto `general_tooltip' display
		do
			if veto_general_tooltip_agent_internal = Void then
				veto_general_tooltip_agent_internal := agent is_ponter_out_of_trailer
			end
			Result := veto_general_tooltip_agent_internal
		ensure
			result_attached: Result /= Void
		end

	veto_general_tooltip_agent_internal: like veto_general_tooltip_agent
			-- Implementation of `veto_general_tooltip_agent'

feature{NONE} -- Action type constants

	pointer_button_pressed_action_type: INTEGER is 1
	pointer_double_press_action_type: INTEGER is 2
	pointer_button_release_action_type: INTEGER is 3

	is_action_type_valid (a_type: INTEGER): BOOLEAN is
			-- Is `a_type' a valid action type?
		do
			Result :=
				a_type = pointer_button_pressed_action_type or
				a_type = pointer_double_press_action_type or
				a_type = pointer_button_release_action_type
		end

feature{NONE} -- Trailer actions maintaining

	install_trailer_actions is
			-- Install actions used for trailers.
		do
			if not pointer_button_press_actions.has (on_pointer_button_pressed_agent) then
				pointer_button_press_actions.extend (on_pointer_button_pressed_agent)
			end
			if not pointer_double_press_actions.has (on_pointer_double_press_agent) then
				pointer_double_press_actions.extend (on_pointer_double_press_agent)
			end
			if not pointer_motion_actions.has (on_pointer_move_agent) then
				pointer_motion_actions.extend (on_pointer_move_agent)
			end
			if not pointer_leave_actions.has (on_pointer_leave_agent) then
				pointer_leave_actions.extend (on_pointer_leave_agent)
			end
			if not pointer_button_release_actions.has (on_pointer_button_releasd_agent) then
				pointer_button_release_actions.extend (on_pointer_button_releasd_agent)
			end
			set_is_pointer_in_trailer (False)
			trailer_position.wipe_out
		end

	uninstall_trailer_actions is
			-- Uninstall actions used for trailers.
		do
			if pointer_button_press_actions.has (on_pointer_button_pressed_agent) then
				pointer_button_press_actions.prune_all (on_pointer_button_pressed_agent)
			end
			if pointer_double_press_actions.has (on_pointer_double_press_agent) then
				pointer_double_press_actions.prune_all (on_pointer_double_press_agent)
			end
			if pointer_motion_actions.has (on_pointer_move_agent) then
				pointer_motion_actions.prune_all (on_pointer_move_agent)
			end
			if pointer_leave_actions.has (on_pointer_leave_agent) then
				pointer_leave_actions.prune_all (on_pointer_leave_agent)
			end
			if pointer_button_release_actions.has (on_pointer_button_releasd_agent) then
				pointer_button_release_actions.prune_all (on_pointer_button_releasd_agent)
			end
			set_is_pointer_in_trailer (False)
		end

	check_trailer_actions (x, y: INTEGER; a_action_type: INTEGER; a_arguments: TUPLE) is
			-- Find a trailer which is under position (`x', `y') and call action whose type is `a_action_type' with arguments `a_arguments'.
			-- (`x', `y') is relative to top-left corner of current grid item.
		require
			a_action_type_valid: is_action_type_valid (a_action_type)
		local
			l_trailer: EB_GRID_EDITOR_TOKEN_ITEM_TRAILER
			l_trailers: like trailers
			l_positions: like trailer_position
			done: BOOLEAN
		do
			l_trailers := trailers
			if not l_trailers.is_empty then
				from
					l_trailers.start
					l_positions := trailer_position
					l_positions.start
				until
					l_positions.after or done
				loop
					l_trailer := l_trailers.item
					if not l_trailer.is_action_blocked then
						if l_positions.item.has_x_y (x, y) then
							call_agent (l_trailer, a_action_type, a_arguments)
							done := True
						end
					end
					l_positions.forth
					l_trailers.forth
				end
			end
		end

	call_agent (a_trailer: EB_GRID_EDITOR_TOKEN_ITEM_TRAILER; a_action_type: INTEGER; a_arguments: TUPLE) is
			-- Call actions of type `a_action_type' from `a_trailer_index'-th trailer in `trailers' with arguments `a_arguments'.
		require
			a_trailer_attached: a_trailer /= Void
			a_action_type_valid: is_action_type_valid (a_action_type)
		local
			l_button_argument: TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]
		do
			inspect
				a_action_type
			when pointer_button_pressed_action_type  then
				l_button_argument ?= a_arguments
				a_trailer.pointer_button_press_actions.call (l_button_argument)
			when pointer_double_press_action_type then
				l_button_argument ?= a_arguments
				a_trailer.pointer_double_press_actions.call (l_button_argument)
			when pointer_button_release_action_type then
				l_button_argument ?= a_arguments
				a_trailer.pointer_button_release_actions.call (l_button_argument)
			end
		end

feature{NONE} -- Actions for trailers

	on_pointer_button_pressed_agent: PROCEDURE [ANY, TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]]
			-- Agent of `on_pointer_button_pressed'

	on_pointer_double_press_agent: PROCEDURE [ANY, TUPLE [INTEGER_32, INTEGER_32, INTEGER_32, REAL_64, REAL_64, REAL_64, INTEGER_32, INTEGER_32]]
			-- Agent of `on_pointer_double_pressed'			

	on_pointer_button_releasd_agent: PROCEDURE [ANY, TUPLE [x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]]
			-- Agent of `on_pointer_button_release'

	on_pointer_leave_agent: PROCEDURE [ANY, TUPLE]
			-- Agent of `on_pointer_leave'

	on_pointer_move_agent: PROCEDURE [ANY, TUPLE [x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER]];
			-- Agent of `on_pointer_move'

	on_pointer_button_pressed (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when pointer pressed
		do
			check_trailer_actions (x, y, pointer_button_pressed_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
		end

	on_pointer_double_pressed (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when pointer pressed
		do
			check_trailer_actions (x, y, pointer_double_press_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
		end

	on_pointer_move (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when pointer moves in current grid
		do
			on_pointer_move_internal (x, y, x_tilt, y_tilt, pressure, screen_x, screen_y, False)
		end

	on_pointer_move_internal (x, y: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER; a_leave: BOOLEAN) is
			-- Action to be performed when pointer moves on current item
			-- `a_leave' means is this aciton called when pointer leaves current item.
		local
			l_trailer: EB_GRID_EDITOR_TOKEN_ITEM_TRAILER
			l_trailers: like trailers
			l_positions: like trailer_position
			l_position: EV_RECTANGLE
			l_pointer_in_trailer: BOOLEAN
		do
			l_trailers := trailers
			if not l_trailers.is_empty then
				l_pointer_in_trailer := is_pointer_in_trailer
				from
					set_is_pointer_in_trailer (False)
					l_trailers.start
					l_positions := trailer_position
					l_positions.start
				until
					l_positions.after
				loop
					l_trailer := l_trailers.item
					l_position := l_positions.item
					if l_position.has_x_y (x, y) then
						if not l_trailer.is_pointer_in then
							l_trailer.set_is_pointer_in (True)
							if not l_trailer.is_action_blocked then
								l_trailer.pointer_enter_actions.call ([l_position.x - x , l_position.y - y, x_tilt, y_tilt, pressure, screen_x, screen_y])
							end
						end
						if not is_pointer_in_trailer then
							set_is_pointer_in_trailer (True)
						end
					else
						if l_trailer.is_pointer_in then
							l_trailer.set_is_pointer_in (False)
							if not l_trailer.is_action_blocked then
								l_trailer.pointer_leave_actions.call ([l_position.x - x , l_position.y - y, x_tilt, y_tilt, pressure, screen_x, screen_y])
							end
						end
					end
					l_positions.forth
					l_trailers.forth
				end
				if not a_leave and then general_tooltip /= Void then
					if l_pointer_in_trailer and then not is_pointer_in_trailer then
						general_tooltip.force_enter
					elseif not l_pointer_in_trailer and then l_pointer_in_trailer then
						general_tooltip.force_leave
					end
				end
			end
		end

	on_pointer_leave is
			-- Action to be performed when pointer leaves current item
		do
			on_pointer_move_internal (-1, -1, 1, 0, 0, 0, 0, True)
		end

	on_pointer_button_release (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Action to be performed when pointer button is released
		do
			check_trailer_actions (x, y, pointer_button_release_action_type, [x, y, button, x_tilt, y_tilt, pressure, screen_x, screen_y])
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
