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

	ES_GRID_LISTABLE_ITEM
		undefine
			copy,
			is_equal,
			default_create
		redefine
			set_last_picked_item,
			required_component_width
		end

	EVS_GRID_SEARCHABLE_ITEM
		undefine
			copy,
			is_equal,
			default_create
		end

create
	default_create,
	make_with_text

feature{NONE} -- Initialization

	make_with_text (a_text: like text) is
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
			enable_full_select
			expose_actions.extend (agent perform_redraw)
			setting_change_actions.extend (agent safe_redraw)
			initialize_item
			Precursor
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Image displayed to left of `tokens'.

	spacing: INTEGER
			-- Spacing between `text' and `pixmap' in pixels.
			-- If both are not visible, this value does not affect appearance of `Current'.

	text: STRING_32 is
			-- Text of current item.
		do
			Result := editor_token_text.string_representation
		ensure
			result_attached: Result /= Void
		end

	stone: STONE is
			-- Stone attached to Current item
			-- Result `stone_internal' if `stone_function' is not set,
			-- otherwise invoke `stone_function' to get the actual stone.			
		do
			if stone_function = Void then
				Result := stone_internal
			else
				Result := stone_function.item (Void)
			end
		end

	stone_function: FUNCTION [ANY, TUPLE, STONE]
			-- Function to fetch `stone'.

	component_spacing: INTEGER
			-- Space in pixel between text and the first trailer

	pebble_at_position: ANY is
			-- Pebble at pointer position
			-- Void if no pebble found at that position		
		local
			l_index: INTEGER
			l_component: like component
			l_pos: EV_RECTANGLE
			l_left_corner: EV_COORDINATE
		do
			l_index := token_index_at_current_position
			if l_index > 0 then
				Result ?= editor_token_pebble (l_index)
			else
				l_index := component_index_at_pointer_position
				if l_index > 0 and then l_index <= component_position.count and then l_index <= component_count then
					l_component := component (l_index)
					l_pos := component_position.i_th (l_index)
					l_left_corner := relative_pointer_position (Current)
					Result := l_component.pebble_at_position (l_pos.x - l_left_corner.x, l_pos.y - l_left_corner.y)
				end
			end
		end

	required_width_for_text_and_component: INTEGER_32
			-- Required width in pixel to display text and components.
		do
			Result := editor_token_text.required_width + required_component_width
		ensure
			result_attached: Result >= 0
		end

	required_height_for_text_and_component: INTEGER_32
			-- Required height in pixel to display text and components.	
		do
			Result := editor_token_text.required_height.max (required_component_height)
		ensure
			result_attached: Result >= 0
		end

feature -- Status report

	is_full_select_enabled: BOOLEAN
			-- Does selection highlighting fill complete area of `Current'?
			-- If `False', highlighting is only applied to area of `text'.

	is_component_adhesive_enabled: BOOLEAN
			-- Is component adhesive?
			-- component is adhesive means component appears right after text.
			-- For example, following is a grid item with non-adhesive component:
			-- +--------------------------------+
			-- | Text                    component|
			-- +--------------------------------+
			-- And following is a grid item with adhesive component:
			-- +--------------------------------+
			-- | Text component                   |
			-- +--------------------------------+

	is_component_display_ensured: BOOLEAN
			-- Is display of `components' ensured?
			-- A True value  means that text wil be truncated first to ensure that all (or most) part of `components'
			-- can be displayed. A False value means that we first ensure that text is displayed mostly.

	is_text_display_ensured: BOOLEAN is
			-- Is display of `editor_token_text' ensured?
			-- A True value means that all or most part of text in `editor_token_text' will be display first, and then `components'.
			-- A False value means we try to display `components' first.
		do
			Result := not is_component_display_ensured
		ensure
			good_result: Result = not is_component_display_ensured
		end

	is_text_truncated: BOOLEAN is
			-- Was text of current truncated because of lack of space the last time when it is displayed?
		do
			Result := editor_token_text.is_text_truncated
		end

feature -- Setting

	enable_full_select
			-- Ensure `is_full_select_enabled' is `True'.
		do
			lock_update
			is_full_select_enabled := True
			unlock_update
			try_call_setting_change_actions
		ensure
			is_full_select_enabled: is_full_select_enabled
		end

	disable_full_select
			-- Ensure `is_full_select_enabled' is `False'.
		do
			lock_update
			is_full_select_enabled := False
			unlock_update
			try_call_setting_change_actions
		ensure
			not_is_full_select_enabled: not is_full_select_enabled
		end

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

	set_text (a_text: like text) is
			-- Set `text' with `a_text'.
		require
			a_text_attached: a_text /= Void
		local
			l_writer: like token_writer
			l_mode: BOOLEAN
		do
			lock_update
			l_writer := token_writer

				-- Alter mulitline state according to the passed text.
			l_mode := l_writer.is_multiline_mode
			if a_text.occurrences ('%N') > 0 then
				if not l_mode then
					l_writer.enable_multiline
				end
			elseif l_mode then
				l_writer.disable_multiline
			end

			l_writer.wipe_out_lines
			l_writer.add (a_text)
			if l_writer.is_multiline_mode then
					-- Add new line to retrieve the last line. This is a bug in the token generator API.
				l_writer.add_new_line
			end
			set_text_with_tokens (l_writer.tokens (0))

			if l_mode /= l_writer.is_multiline_mode then
					-- Reset mode
				if l_mode then
					l_writer.enable_multiline
				else
					l_writer.disable_multiline
				end
			end

			unlock_update
			try_call_setting_change_actions
		ensure
			text_set: text.is_equal (a_text)
		end

    set_text_wrap (a_wrap: BOOLEAN) is
            -- If `a_wrap' is True, enable text wrap, otherwise disable text wrap.
        do
            if a_wrap then
                editor_token_text.enable_text_wrap
            else
                editor_token_text.disable_text_wrap
            end
        ensure
            text_wrap_set: editor_token_text.is_text_wrap_enabled = a_wrap
        end

	set_overriden_fonts (a_fonts: SPECIAL [EV_FONT]; a_height: INTEGER) is
			-- Set fonts of current tokens with `a_fonts' and according height.
			-- If `a_fonts' is Void, tokens will be displayed in default editor token fonts.
		do
			lock_update
			editor_token_text.set_overriden_font (a_fonts, a_height)
			unlock_update
			try_call_setting_change_actions
		end

	set_component_spacing (a_spacing: INTEGER_32)
			-- Set `component_spacing' with `a_spacing'.
		do
			lock_update
			component_spacing := a_spacing
			unlock_update
			try_call_setting_change_actions
		ensure
			component_spacing_set: component_spacing = a_spacing
		end

	enable_adhesive_component
			-- Enable adhesive component.
		do
			lock_update
			is_component_adhesive_enabled := True
			unlock_update
			try_call_setting_change_actions
		ensure
			adhesive_component_enabled: is_component_adhesive_enabled
		end

	disable_adhesive_component
			-- Disable adhesive component.
		do
			lock_update
			is_component_adhesive_enabled := False
			unlock_update
			try_call_setting_change_actions
		ensure
			adhesive_component_disabled: not is_component_adhesive_enabled
		end

	ensure_component_display is
			-- Ensure display of `components'.
			-- See `is_component_display_ensured' for more information.
		do
			is_component_display_ensured := True
		ensure
			component_display_ensured: is_component_display_ensured
		end

	ensure_text_display is
			-- Ensure display of `editor_token_text'.
			-- See `is_component_display_ensured' for more information.
		do
			is_component_display_ensured := False
		ensure
			text_display_ensured: not is_component_display_ensured
		end

	set_stone (a_stone: like stone) is
			-- Set `stone' with `a_stone'.
		do
			stone_internal := a_stone
		ensure
			stone_set: stone_internal = a_stone
		end

	set_stone_function (a_function: like stone_function) is
			-- Set `stone_function' with `a_function'.
		do
			stone_function := a_function
		ensure
			stone_function_set: stone_function = a_function
		end

feature -- Searchable

	set_image (a_image: like image) is
			-- Set `image' with `a_image'.
		require
			a_image_attached: a_image /= Void
		do
			create image_internal.make_from_string (a_image)
		ensure
			image_set: image /= Void and then image.is_equal (a_image)
		end

	image: STRING_32 is
			-- Image of current used in search
		do
			Result := image_internal
			if Result = Void then
				Result := ""
			end
		end

feature{NONE} -- Implementation

	image_internal: like image
			-- Implementation of `image'

	internal_replace (original, new: like image) is
			-- Replace every occurrence of `original' with `new' in `image'.
		do
		end

	required_component_width: INTEGER_32
			-- Required width in pixel for displaying all attached `components'
		do
			Result := Precursor + component_spacing
		end

feature{NONE} -- Redraw

	perform_redraw (a_drawable: EV_DRAWABLE)
		local
			l_x_offset: INTEGER
			l_required_text_width: INTEGER
			l_required_component_width: INTEGER
			l_token_text: like editor_token_text
			l_left_width: INTEGER
			l_text_start_x: INTEGER
			l_component_start_x: INTEGER
			l_width_for_text_and_component: INTEGER
			l_max_text_width: INTEGER
		do
			prepare_grid_area (a_drawable)
			l_x_offset := border_line_width + left_border
			if pixmap /= Void then
				draw_pixmap (a_drawable, l_x_offset)
				l_x_offset := l_x_offset + pixmap.width + spacing
			end
			l_token_text := editor_token_text
			l_token_text.set_overriden_selection_colors (parent.focused_selection_color, parent.non_focused_selection_color)

				-- Calculate text position and component position.
			l_required_text_width := l_token_text.required_width
			l_required_component_width := required_component_width
			l_left_width := (width - l_x_offset - right_border - border_line_width).max (1)
			l_width_for_text_and_component := l_required_text_width + l_required_component_width
			if l_required_component_width = 0 then
				if is_center_aligned then
					l_text_start_x := ((l_left_width - l_required_text_width) // 2).max (0)
				elseif is_right_aligned then
					l_text_start_x := (l_left_width - l_required_text_width).max (0)
				end
				l_max_text_width := l_left_width.max (1)
			elseif l_left_width >= l_width_for_text_and_component then
				l_max_text_width := l_required_text_width
				if is_left_aligned then
					l_text_start_x := 0
					if is_component_adhesive_enabled then
						l_component_start_x := l_required_text_width
					else
						l_component_start_x := (l_left_width - l_required_component_width).max (1)
					end
				elseif is_center_aligned then
					l_text_start_x := ((l_left_width - l_width_for_text_and_component) // 2).max (0)
					if is_component_adhesive_enabled then
						l_component_start_x := (l_text_start_x + l_required_text_width).max (1)
					else
						l_component_start_x := (l_left_width - l_required_component_width).max (1)
					end
				elseif is_right_aligned then
					l_text_start_x := (l_left_width - l_width_for_text_and_component).max (0)
					l_component_start_x := (l_left_width - l_required_component_width).max (1)
				end
			elseif l_width_for_text_and_component > l_left_width and then l_left_width >= l_required_text_width  then
				l_text_start_x := 0
				if is_component_display_ensured then
					l_component_start_x := (l_left_width - l_required_component_width).max (1)
					l_max_text_width := l_component_start_x
				else
					l_component_start_x := l_required_text_width
					l_max_text_width := l_required_text_width
				end
			elseif l_left_width < l_required_text_width then
				l_text_start_x := 0
				if is_component_display_ensured then
					l_component_start_x := (l_left_width - l_required_component_width).max (1)
					l_max_text_width := l_component_start_x
				else
					l_max_text_width := l_left_width
					l_component_start_x := l_left_width
				end
			else
				check False end
			end
			l_text_start_x := l_text_start_x + l_x_offset
			l_component_start_x := l_component_start_x + l_x_offset
			draw_text (a_drawable, l_text_start_x, l_max_text_width + l_text_start_x, parent.has_focus)
			if l_required_component_width > 0 then
				draw_components (a_drawable, l_component_start_x)
			end
		end

	prepare_grid_area (a_drawable: EV_DRAWABLE)
			-- Prepare area in `a_drawable' for drawing current item.
			-- i.e., clean area and draw background and draw borders.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_parent: EV_GRID
			l_gap: INTEGER
		do
			if pixmap /= Void and then not is_full_select_enabled then
					-- Determine selection render gap, and erase background
				l_gap := pixmap.width + left_border + 2
				a_drawable.set_foreground_color (parent.background_color)
				a_drawable.fill_rectangle (0, 0, l_gap, height)
			end

			l_parent := parent
			if is_selected then
				if l_parent.has_focus then
					a_drawable.set_foreground_color (parent.focused_selection_color)
				else
					a_drawable.set_foreground_color (parent.non_focused_selection_color)
				end
			else
				if background_color /= Void then
					a_drawable.set_foreground_color (background_color)
				elseif row.background_color /= Void then
					a_drawable.set_foreground_color (row.background_color)
				else
					a_drawable.set_foreground_color (parent.background_color)
				end
			end
			a_drawable.fill_rectangle (l_gap, 0, width, height)
			if not l_parent.pre_draw_overlay_actions.is_empty then
				l_parent.pre_draw_overlay_actions.call ([a_drawable, Current, column.index, row.index])
			end
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
			l_required_width := border_line_width * 2 + left_border + right_border + editor_token_text.required_width + required_component_width
			if pixmap /= Void then
				l_required_width := l_required_width + pixmap.width + spacing
			end
			set_required_width (l_required_width)
			if is_parented then
				redraw
			end
		end

feature {EB_GRID_EDITOR_TOKEN_ITEM} -- Implementation

	editor_token_text: EB_EDITOR_TOKEN_TEXT is
			-- Editor token text
		require
			not_destroyed: not is_destroyed
		do
			Result := editor_token_text_internal
			if Result = Void then
				create Result
				editor_token_text_internal := Result
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = editor_token_text
		end

feature -- Pick and drop

	set_last_picked_item (a_index: INTEGER) is
			-- Set `last_picked_item' with `a_index'.
		do
			check a_index <= editor_token_text.tokens.count end
			last_picked_item := a_index
			Precursor (a_index)
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
				l_relative_position := relative_pointer_position (Current)
				Result := l_editor_token_text.token_index_at_position (l_relative_position.x, l_relative_position.y)
			end
		end

	editor_token_pebble (a_index: INTEGER): ANY is
			-- Pebble of token item indicated by `a_index'
			-- Void if no pebble available.
		do
			Result := editor_token_text.pebble (a_index)
		end

feature -- Pick and drop

	is_pick_on_text: BOOLEAN
			-- Did last pick happen on `editor_token_text' area?

	set_is_pick_on_text (b: BOOLEAN) is
			-- Set `is_pick_on_text' with `b'.
		do
			is_pick_on_text := b
		ensure
			is_pick_on_text_set: is_pick_on_text = b
		end

	on_pick: ANY is
			-- Action to be performed when pick starts
			-- Return value is the picked pebble if any.
		local
			l_index: INTEGER
			l_stone: STONE
		do
			l_index := token_index_at_current_position
			if l_index > 0 then
				l_stone ?= editor_token_pebble (l_index)
				if l_stone /= Void then
					Result := l_stone
					set_is_pick_on_text (True)
					set_last_picked_item (l_index)
				end
			elseif is_component_pebble_enabled then
				l_index := component_index_at_pointer_position
				if l_index > 0 then
					set_last_picked_item (l_index)
					Result := pick_component (l_index)
					if Result = Void then
						set_last_picked_item (0)
					else
						set_is_pick_on_text (False)
					end
				end
			end
		end

	on_pick_ends is
			-- Action to be performed hwne pick-and-drop finishes
		do
			if not is_pick_on_text then
				if last_picked_item > 0 and then last_picked_item <= component_count then
					component (last_picked_item).on_pick_ended
				end
			end
			set_last_picked_item (0)
		end

feature{NONE} -- Implementation

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
			l_picked_item_index: INTEGER
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
					if is_pick_on_text then
						l_picked_item_index := last_picked_item
					end
					l_token_text.display (0, 0, a_drawable, l_picked_item_index, a_focused)
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

	draw_components (a_drawable: EV_DRAWABLE; a_start_x: INTEGER_32)
			-- Draw `components' in `a_drawable' starting from `a_start_x'.
			-- `components' are always vertically center aligned.
		require
			a_drawable_attached: a_drawable /= Void
		local
			l_components: like components
			x, y: INTEGER_32
			l_count: INTEGER_32
			l_component_padding: INTEGER_32
			l_component: like component_type
			l_component_position: like component_position
			l_width, l_height: INTEGER
		do
			l_components := components
			if not l_components.is_empty then

			end
			l_component_position := component_position
			if not l_components.is_empty then
				l_component_position.wipe_out
				l_component_padding := component_padding
				from
					x := a_start_x + component_spacing
					l_count := l_components.count
					l_components.start
				until
					l_components.after
				loop
					l_component := l_components.item
					y := vertical_starting_position (l_component.required_height, 2, False)
					l_width := l_component.required_width
					l_height := l_component.required_height
					l_component.display (a_drawable, x, y, l_width, l_height)
					l_component_position.extend (create {EV_RECTANGLE}.make (x, y, l_width, l_height))
					x := x + l_component.required_width
					if l_components.index < l_count then
						x := x + l_component_padding
					end
					l_components.forth
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

	stone_internal: like stone
			-- Implementation of `stone' if `stone_function' is not Set.

	grid_item: EV_GRID_ITEM is
			-- EV_GRID item associated with current
		do
			Result := Current
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
