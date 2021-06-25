note
	description:
		"[
			EV_GRID Text label whose content may be interactively chosen by the user via a list.
			
			`set_item_strings' may be used to set the list items used in the choice list before the item
			is activated.
			
			By default a list containing the strings set from `set_item_strings' is displayed, allowing
			the user to change the text of `Current' by selecting an item within that list.
			
			The default behavior of the activation may be overriden using `activate_actions' or
			`item_activate_actions' (from EV_GRID).
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_CHOICE_ITEM

inherit
	EV_GRID_LABEL_ITEM
		redefine
			initialize,
			activate_action,
			deactivate,
			required_width,
			computed_initial_grid_label_item_layout
		end

create
	default_create,
	make_with_text

feature {EV_ANY} -- Initialization

	initialize
			-- <Precursor>
		do
			Precursor
			set_is_tab_navigatable (True)
		end

feature -- Element change

	set_item_strings (a_string_array: attached like item_strings)
			-- Set each item in `Current' to the strings referenced in `a_string_array'.
		require
			a_string_array_not_void: a_string_array /= Void
		do
			item_strings := a_string_array
			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
				set_strings
			end
			if a_string_array.upper > a_string_array.lower then
				set_pixmap (drop_down_pixmap)
			else
				remove_pixmap
			end
		ensure
			item_strings_set: item_strings = a_string_array
		end

feature -- Access

	item_strings: detachable INDEXABLE [READABLE_STRING_GENERAL, INTEGER]
			-- Item strings used to make up combo box list.

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
				-- If there is a pixmap set, we use that pixmap, otherwise we
				-- take into account the size of `drop_down_pixmap' even if it is not shown.
			if pixmap = Void then
				pixmap := drop_down_pixmap
				Result := implementation.required_width
				pixmap := Void
			else
				Result := implementation.required_width
			end
		end

feature -- Actions

	deactivate
			-- Cleanup from previous call to activate.
		local
			l_item: detachable EV_GRID_LABEL_ITEM
		do
			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
				l_choice_list.focus_out_actions.wipe_out

				l_choice_list.key_press_actions.wipe_out
				l_choice_list.pointer_button_press_item_actions.wipe_out
				l_choice_list.pointer_button_release_item_actions.wipe_out
				l_choice_list.pointer_motion_actions.wipe_out

				if has_user_selected_item and then l_choice_list.has_selected_row then
					l_item ?= l_choice_list.selected_rows.first.item (1)
					if l_item /= Void then
						set_text (l_item.text)
					end
				end
				choice_list := Void
			end
			Precursor {EV_GRID_LABEL_ITEM}
		end

feature {NONE} -- Implementation

	choice_list: detachable EV_GRID
			-- Text field used to edit `Current' on `activate'
			-- Void when `Current' isn't being activated.

	initial_position: detachable EV_COORDINATE
			-- Initial pointer position when `choice_list' is first shown.
			--| This is to avoid a spurious `on_mouse_move' callback that occurs on Windows
			--| even if the pointer hasn't moved, because the window underneath the pointer has moved

	set_strings
			-- Update `choice_list' with `item_strings'.
		require
			choice_list_not_destroyed: attached choice_list as l_c_list and then not l_c_list.is_destroyed
		local
			l_item: EV_GRID_LABEL_ITEM
			j: INTEGER
			l_text, l_selected_text: READABLE_STRING_GENERAL
			l_font, l_selected_font: detachable EV_FONT
			l_choice_list: like choice_list
		do
			l_choice_list := choice_list
			check l_choice_list /= Void then end

				-- Reset choice list to a 1x1 grid with no item
				-- We do not use wipeout as this has the side effect of resizing any previously set column widths.
			l_choice_list.set_row_count_to (1)
			l_choice_list.set_column_count_to (1)
			l_choice_list.set_item (1, 1, Void)

			l_font := font
			if attached item_strings as l_item_strings then
				across
					l_item_strings as c
				from
					j := 1
					l_selected_text := text
				loop
					l_text := c
					create l_item.make_with_text (l_text)
					l_choice_list.set_item (1, j, l_item)
					j := j + 1
					if l_selected_font = Void and then l_text.same_string (l_selected_text) then
						if l_font /= Void then
							l_selected_font := l_font.twin
						else
							create l_selected_font
						end
						l_selected_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
						l_item.set_font (l_selected_font)
						l_item.enable_select
					else
						if l_font /= Void then
								-- All non selected items should be regular.
							if l_font.weight /= {EV_FONT_CONSTANTS}.weight_regular then
								l_font := l_font.twin
								l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
							end
							l_item.set_font (l_font)
						end
					end
						-- Ensure that the text we insert is nicely surrounded
						-- so that it does not touch the border.
					l_item.set_left_border (default_left_border)
					l_item.set_right_border (default_left_border)
						-- Make sure that the content alignment matches the current alignment
					set_alignment (l_item)
				end
			else
					-- Add `text' is there are no strings set.
				create l_item.make_with_text (text)
				if l_font /= Void then
					l_item.set_font (l_font)
				end
					-- Ensure that the text we insert is nicely surrounded
					-- so that it does not touch the border.
				l_item.set_left_border (default_left_border)
				l_item.set_right_border (default_left_border)
					-- Make sure that the content alignment matches the current alignment
				set_alignment (l_item)
				l_choice_list.set_item (1, 1, l_item)
			end

		end

	set_alignment (a_item: EV_GRID_LABEL_ITEM)
			-- Set alignment of `a_item' according to current alignment.
		do
			if is_left_aligned then
				a_item.align_text_left
			elseif is_right_aligned then
				a_item.align_text_right
			else
				a_item.align_text_center
			end
		end

	has_user_selected_item: BOOLEAN
			-- Did the user select an entry in the list?

	activate_action (a_popup: EV_POPUP_WINDOW)
			-- `Current' has been requested to be updated via `a_popup'.
		local
			l_width, l_height: INTEGER
			l_screen: detachable EV_SCREEN_IMP
			l_choice_list: EV_GRID
			l_x_coord, l_y_coord, l_x_offset, l_y_offset, l_scroll_width, l_content_width: INTEGER
			l_parent: like parent
			l_vbox: EV_VERTICAL_BOX
			l_box_border, l_item_border_width, l_item_border_height: INTEGER
			l_layout: like grid_label_item_layout
			l_rect: EV_RECTANGLE
			l_mouse: EV_COORDINATE
		do
			l_parent := parent
			check l_parent /= Void then end

			l_screen ?= (create {EV_SCREEN}).implementation
			check l_screen_not_void: l_screen /= Void then end
				-- We limit our positionning on the current monitor, where the click occurred,
				-- for better user experience.
			l_mouse := l_screen.pointer_position
			l_rect := l_screen.working_area_from_position (l_mouse.x, l_mouse.y)

			create l_choice_list
			choice_list := l_choice_list

				-- We hide the horizontal scrollbar and headers since we only want to show
				-- one column with many items in it. We keep the vertical scrollbar in the event
				-- there are too many items to show.
			l_choice_list.hide_header
			l_choice_list.hide_horizontal_scroll_bar

			create l_vbox
			l_vbox.set_background_color ((create {EV_STOCK_COLORS}).black)
				-- By default our drop down will always have a border of 1 pixel around the grid.
			l_box_border := 1
			l_vbox.set_border_width (l_box_border)
				-- Initial border width and height for the box containing the grid, taking into account
				-- the user settings (2 for 2 x 1-pixel border).
				-- Due to the drawing hack for text which assumes that text is by default drawing
				-- {EV_GRID_LABEL_ITEM}.default_left_border pixels to the right, we need to check
				-- if user has set `left_border' or not.
			if internal_left_border >= 0 then
				l_item_border_width := 2 + left_border + right_border
			else
				l_item_border_width := 2 + right_border
			end
			l_item_border_height := 2 + top_border + bottom_border

			l_vbox.extend (l_choice_list)

				-- Set the item strings.
			set_strings

			l_layout := computed_initial_grid_label_item_layout (width, height)
			if attached layout_procedure as l_layout_procedure then
				l_layout_procedure.call ([Current, l_layout])
			end

				-- Compute location and size of `popup_window' and `choice_list' so that we can see most of
				-- the items at once.
				-- 1) Get the actual position of the left border
			if internal_left_border >= 0 then
				l_x_coord := a_popup.x_position + left_border
			else
				l_x_coord := a_popup.x_position
			end
				-- 2) If the left hand side is offscreen on the left, calculate how many pixels we need to
				--    shift to the right to show the content without cropping the content of `choice_list'.
			l_x_offset := (l_rect.x - l_x_coord).max (0)
				-- 3) Adjust `l_x_coord' to take into account the potential cropping.
			l_x_coord := l_x_coord + l_x_offset

				-- 1) Get the actual position of the top border. We try to align the top with the text
				-- by removing 1 pixel for the border and 1 pixel for the spacing to the top of the font
				-- (note this is empirical and depending on the font/platform it could perform more or less
				-- well).
			l_y_coord := a_popup.y_position + l_layout.text_y - 2
				-- 2) If the top hand side is offscreen on the top, calculate how many pixels we need to
				--    shift to the bottom to show the content without cropping the content of `choice_list'.
			l_y_offset := (l_rect.y - l_y_coord).max (0)
				-- 3) Adjust `l_y_coord' to take into account the potential cropping.
			l_y_coord := l_y_coord + l_y_offset

				-- Initially the width and height of `choice_list' match the size of the item in the grid
				-- and potentially shrinked even more of part of the item was offscreen.
			l_width := a_popup.width - l_x_offset - l_item_border_width
			l_height := a_popup.height - l_y_offset - l_item_border_height

			if l_choice_list.column_count > 0 and then l_choice_list.row_count > 0 then
					-- Calculate the ideal width and height of `choice_list', that is to say the
					-- size it needs to show all its content.
				l_height := l_choice_list.virtual_height
					-- If scrollbar is visible then we need to take into account the width of the
					-- scrollbar.
				if l_height >= l_rect.height then
					l_scroll_width := l_choice_list.vertical_scroll_bar.width
				end
					-- Here is the content width that is necessary to display all the strings
					-- without truncation.
				l_content_width := l_scroll_width +
					l_choice_list.column (1).required_width_of_item_span (1, l_choice_list.row_count)
					-- Here is our needed width.
				l_width := l_width.max (l_content_width)

					-- Check if the right hand side of the `choice_list' is still visible on screen.
				l_x_offset := (l_x_coord + l_width) - l_rect.right
				if l_x_offset > 0 then
						-- It is too big, we are going to shift `l_x_coord' to the left by
						-- at most `l_x_offset' pixels until the right hand side is visible without
						-- obscuring the left hand side (in which case we will shrink the
						-- content as to not put the left hand side offscreen). But if we can reduce
						-- the width without truncating the content we go for it.
					if (l_width - l_x_offset) > l_content_width then
							-- Nothing to change, the content still fits, however we will need to
							-- ensure that right hand side is visible
						l_width := l_width - l_x_offset
					else
							-- Left hand side needs to move to the left, we only do it for what
							-- is necessary and no bigger than the whole screen,
						l_width := l_content_width
						l_x_coord := l_rect.right - l_content_width
						if l_x_coord < l_rect.x then
								-- Content is actually larger than the screen
								-- To avoid putting the left hand side offscreen,
								-- we adjust accordingly the x coordinate and
								-- shrink the content to fit the screen.
							l_width := l_rect.width
							l_x_coord := l_rect.x
						end
					end
				end

					-- Check if the top hand side of the `choice_list' is still visible on screen.
				l_y_offset := (l_y_coord + l_height) - l_rect.bottom
				if l_y_offset > 0 then
						-- It is too big, we are going to shift `l_y_coord' to the top by
						-- at most `l_y_offset' pixels until the bottom hand side is visible without
						-- obscuring the top hand side (in which case we will shrink the
						-- content as to not put the top hand side offscreen).
						-- Unlike the x coordinates computation where the initial width
						-- was potentially bigger than needed, this is not the case here
						-- thus the different way to shift the top.
					l_y_coord := l_y_coord - l_y_offset
					if l_y_coord < l_rect.y then
							-- We would be putting the top hand side offscreen, we adjust accordingly
							-- the y coordinate and shrink the content to fit the screen.
						l_height := l_height - (l_rect.y - l_y_coord)
						l_y_coord := l_rect.y
					end
				end

				l_choice_list.set_minimum_height (l_height)
				l_choice_list.column (1).set_width (l_width - l_scroll_width)
				l_choice_list.set_minimum_width (l_width)
			end

			a_popup.set_x_position (l_x_coord)
			a_popup.set_y_position (l_y_coord)
			a_popup.set_height (l_height + 2 * l_box_border)
			a_popup.set_width (l_width + 2 * l_box_border)

			l_choice_list.enable_single_row_selection
			l_choice_list.enable_selection_key_handling
			l_choice_list.set_background_color (implementation.displayed_background_color)
			a_popup.set_background_color (implementation.displayed_background_color)
			l_choice_list.set_foreground_color (implementation.displayed_foreground_color)
			l_choice_list.set_focused_selection_color (l_parent.focused_selection_color)
			l_choice_list.set_focused_selection_text_color (l_parent.focused_selection_text_color)

			a_popup.extend (l_vbox)

				-- Initialize action sequences when `Current' is shown.
			a_popup.show_actions.extend (agent initialize_actions)
		end

	initialize_actions
			-- Setup the action sequences when the item is shown.
		do
				-- No selection yet.
			has_user_selected_item := False

			if attached choice_list as l_choice_list and then not l_choice_list.is_destroyed then
					-- Initialize actions.
				if l_choice_list.is_displayed and then l_choice_list.is_sensitive then
					l_choice_list.set_focus
				end
				initial_position := (create {EV_SCREEN}).pointer_position
				l_choice_list.focus_out_actions.extend (agent deactivate)
				l_choice_list.pointer_button_press_item_actions.extend (agent on_mouse_press)
				l_choice_list.pointer_button_release_item_actions.extend (agent on_mouse_release)
				l_choice_list.pointer_motion_actions.extend (agent on_mouse_move)
				l_choice_list.key_press_actions.extend (agent on_key)
			else
					-- Something wrong occurred, we should deactivate if possible.
				if not is_destroyed and is_parented then
					deactivate
				end
			end
		end

	on_mouse_move (a_x, a_y: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle mouse moving actions.
		local
			l_item: detachable EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
		do
			if attached choice_list as l_choice_list then
					-- If `initial_position' of the mouse has been set (it means we just activated items),
					-- then we will only select an item if the new mouse position is of by one pixel in
					-- any directions.
				if
					not attached initial_position as l_pos or else
					(l_pos.x /= l_choice_list.screen_x + a_x and then l_pos.y /= l_choice_list.screen_y + a_y)
				then
					initial_position := Void

					l_item := l_choice_list.item_at_virtual_position (l_choice_list.virtual_x_position + a_x,
							l_choice_list.virtual_y_position + a_y)
					if l_item /= Void then
						l_list := l_choice_list.selected_items
						if not l_list.is_empty and then l_list.first /= l_item then
							l_choice_list.remove_selection
							l_item.enable_select
						end
						has_user_selected_item := True
					end
				end
			else
				check choice_list /= Void end
			end
		end

	on_mouse_press (a_x, a_y, a_button: INTEGER; a_item: detachable EV_GRID_ITEM)
			-- Handle mouse press actions.
		local
			l_item: detachable EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
		do
			if a_button = 1 then
				if attached choice_list as l_choice_list then
					l_item := l_choice_list.item_at_virtual_position (l_choice_list.virtual_x_position + a_x,
							l_choice_list.virtual_y_position + a_y)
					if l_item /= Void then
						l_list := l_choice_list.selected_items
						if not l_list.is_empty and then l_list.first /= l_item then
							l_choice_list.remove_selection
							l_item.enable_select
						end
						has_user_selected_item := True
					end
				else
					check choice_list /= Void end
				end
			end
		end

	on_mouse_release (a_x, a_y, a_button: INTEGER; a_item: detachable EV_GRID_ITEM)
			-- Handle mouse release actions.
		do
			if has_user_selected_item then
				deactivate
			end
		end

	on_key (a_key: EV_KEY)
			-- Handle key action on `choice_list'.
		local
			l_propagate_tab_key, l_deactivate: BOOLEAN
		do
			inspect
				a_key.code
			when {EV_KEY_CONSTANTS}.key_enter, {EV_KEY_CONSTANTS}.key_tab then
				has_user_selected_item := a_key.code = {EV_KEY_CONSTANTS}.key_enter
					-- Tab or enter key should propagate to the next item if `is_item_tab_navigation_enabled'.
				l_propagate_tab_key := attached parent as l_parent and then l_parent.is_item_tab_navigation_enabled
				l_deactivate := True
			when {EV_KEY_CONSTANTS}.key_escape then
				l_deactivate := True
			else
					-- Do nothing
			end
			if l_deactivate and then attached parent as l_parent then
				if l_propagate_tab_key then
					l_parent.propagate_key_press (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_tab))
				end
					-- Make sure that `Current' is deactivated if not already done so by the key propagation.
				if l_parent.activated_item = Current then
					deactivate
				end
			end
		end

	drop_down_pixmap: EV_PIXMAP
			-- Drop drawn pixmap
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (9, 7)
			Result.draw_segment (1, 2, 7, 2)
			Result.draw_segment (2, 3, 6, 3)
			Result.draw_segment (3, 4, 5, 4)
			Result.draw_segment (4, 5, 4, 5)

			create l_mask.make_with_size (9, 7)
			l_mask.clear_rectangle (0, 0, 9, 7)
			l_mask.draw_segment (0, 1, 8, 1)
			l_mask.draw_segment (0, 2, 8, 2)
			l_mask.draw_segment (1, 3, 7, 3)
			l_mask.draw_segment (2, 4, 6, 4)
			l_mask.draw_segment (3, 5, 5, 5)
			l_mask.draw_segment (4, 6, 4, 6)

			Result.set_mask (l_mask)
		ensure
			drop_down_pixmap_not_void: Result /= Void
		end

	computed_initial_grid_label_item_layout (a_width, a_height: INTEGER_32): EV_GRID_LABEL_ITEM_LAYOUT
		do
			Result := Precursor (a_width, a_height)
			if attached pixmap as l_pixmap then
					-- We simply shift the computation of `x' to the left by
					-- the size occuppied by the pixmap and separation between
					-- text and pixmap
				Result.set_text_x (Result.text_x - l_pixmap.width - spacing)
					-- We have the pixmap enabled, let's compute the position
					-- of the `text' and `pixmap' so that `text' appears at the very left
					-- and `pixmap' at the very right minus 2 pixels for cosmetic reasons.
				Result.set_pixmap_x (Result.text_x.max (width - l_pixmap.width - right_border - 2))
				Result.set_has_text_pixmap_overlapping (False)
			end
		end

invariant
	choice_list_parented_during_activation: attached choice_list as l_choice_list implies l_choice_list.parent /= Void

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
