indexing
	description: "Editable editor token grid item."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_GRID_LISTABLE_CHOICE_ITEM

inherit
	ES_GRID_LIST_ITEM
		redefine
			activate_action,
			deactivate,
			display,
			safe_redraw
		end

	ES_SHARED_FONTS_AND_COLORS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	default_create

feature -- Element change

	set_item_components (a_item_components: like item_components) is
			-- Set each item in `Current' to the list of tokens referenced in `a_item_components'.
		require
			a_item_components_not_void: a_item_components /= Void
		do
			item_components := a_item_components
			if choice_list /= Void and then not choice_list.is_destroyed then
				set_tokens
			end
		ensure
			item_components_set: item_components = a_item_components
		end

	set_list_item (a_item: !EB_GRID_LISTABLE_CHOICE_ITEM_ITEM) is
			-- Set current as `a_item'
		local
			i, l_count: INTEGER
		do
			from
				i := 1
				l_count := component_count
			until
				i > l_count
			loop
				remove_component (1)
				i := i + 1
			end
			a_item.item_components.do_all (
				agent (aa_component: ES_GRID_ITEM_COMPONENT)
					do
						aa_component.set_grid_item (Void)
						append_component (aa_component)
					end)
			selected_item_internal := a_item
		end

	set_context_menu_factory (a_factory: EB_CONTEXT_MENU_FACTORY) is
			-- Context menu factory
		do
			context_menu_factory := a_factory
		ensure
			context_menu_factory_set: context_menu_factory = a_factory
		end

	set_selection_changing_action (a_action: like selection_changing_action) is
			-- Set `selection_changing_action' with `a_action'
		do
			selection_changing_action := a_action
		ensure
			selection_changing_action_set: selection_changing_action = a_action
		end

feature -- Access

	item_components: INDEXABLE [EB_GRID_LISTABLE_CHOICE_ITEM_ITEM, INTEGER]
		-- Item tokens used to make up the list.

	selected_item: ?EB_GRID_LISTABLE_CHOICE_ITEM_ITEM is
			-- Selected item.
		local
			l_list: !ARRAYED_LIST [ES_GRID_ITEM_COMPONENT]
		do
			if selected_item_internal = Void then
				create l_list.make (0)
				create Result.make (l_list)
			else
				Result := selected_item_internal
			end
		end

	selection_changing_action: ?FUNCTION [ANY, TUPLE [EB_GRID_LISTABLE_CHOICE_ITEM_ITEM], BOOLEAN]
			-- Called on selected value changing
			-- Result indicate if the real change should be conducted.
			-- If not set, value will always be changed.

feature {NONE} -- Implementation

	choice_list: ES_GRID
		-- Text field used to edit `Current' on `activate'
		-- Void when `Current' isn't being activated.

	set_tokens is
			-- Update `choice_list' with `item_components'.
		require
			choice_list_not_void: choice_list /= Void
			choice_list_not_destroyed: not choice_list.is_destroyed
		local
			l_item: ES_GRID_LIST_ITEM
			i, j, nb: INTEGER
			l_interval: INTEGER_INTERVAL
			l_text, l_selected_text: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM
		do
			choice_list.wipe_out
			if item_components /= Void then
				from
					l_interval := item_components.index_set
					j := 1
					i := l_interval.lower
					nb := l_interval.upper
					l_selected_text := selected_item
				until
					i > nb
				loop
					l_text := item_components.item (i)
					create l_item
					l_item.set_component_padding (component_padding)
					l_item.set_data (l_text)
					l_text.item_components.do_all (
						agent (aa_component: ES_GRID_ITEM_COMPONENT; aa_item: ES_GRID_LIST_ITEM)
							do
								aa_component.set_grid_item (Void)
								aa_item.append_component (aa_component)
							end (?, l_item))
					i := i + 1
					choice_list.set_item (1, j, l_item)
					j := j + 1
					if l_text.is_equal (l_selected_text) then
						l_item.set_background_color (colors.grid_editor_token_choice_selected_background_color)
						l_item.enable_select
					end
				end
			end
		end

	has_user_selected_item: BOOLEAN
		-- Did the user select an entry in the list?

	activate_action (popup_window: EV_POPUP_WINDOW) is
			-- `Current' has been requested to be updated via `popup_window'.
		local
			l_vbox: EV_VERTICAL_BOX
			l_maximum_height, l_maximum_width: INTEGER
			l_screen: EV_SCREEN_IMP
			l_support: EB_EDITOR_TOKEN_GRID_SUPPORT
		do
			l_screen ?= (create {EV_SCREEN}).implementation
			check l_screen_not_void: l_screen /= Void end
			create choice_list
			choice_list.hide_header
			choice_list.enable_single_row_selection
			choice_list.enable_selection_key_handling
			choice_list.enable_row_height_fixed
			choice_list.set_minimum_height (choice_list.row_height)

			create l_support.make_with_grid (choice_list)
			l_support.enable_grid_item_pnd_support
			l_support.enable_ctrl_right_click_to_open_new_window
			l_support.synchronize_scroll_behavior_with_editor
--			l_support.synchronize_color_or_font_change_with_editor
			if context_menu_factory /= Void then
				l_support.set_context_menu_factory_function (agent context_menu_factory)
			end

			create l_vbox
			l_vbox.set_border_width (1)
			l_vbox.set_background_color ((create {EV_STOCK_COLORS}).black)
			l_vbox.extend (choice_list)
			popup_window.extend (l_vbox)

			set_tokens

				-- Compute location and size of `popup_window' and `choice_list' so that we can see most
				-- of the items at once.
			l_maximum_height := (l_screen.virtual_height - popup_window.y_position).max (0)
			l_maximum_width := (l_screen.virtual_width - popup_window.x_position).max (0)
			choice_list.column (1).set_width (left_border + l_maximum_width.min (
				(popup_window.width - 2).max (choice_list.column (1).required_width_of_item_span (1, choice_list.row_count))))
				-- +2 to take into account 2 pixels border of the vertical box.
			popup_window.set_height (2 + l_maximum_height.min (choice_list.row_count * choice_list.row_height))
			popup_window.set_width (popup_window.width.max (2 + choice_list.column (1).width))

			choice_list.set_background_color (implementation.displayed_background_color)
			popup_window.set_background_color (implementation.displayed_background_color)
			choice_list.set_foreground_color (implementation.displayed_foreground_color)

				-- Initialize action sequences when `Current' is shown.
			popup_window.show_actions.extend (agent initialize_actions)
		end

	initialize_actions is
			-- Setup the action sequences when the item is shown.
		do
				-- No selection yet.
			has_user_selected_item := False

			if choice_list /= Void and then not choice_list.is_destroyed then
					-- Initialize actions.
				choice_list.set_focus
				choice_list.focus_out_actions.extend (agent deactivate)
				choice_list.pointer_button_press_item_actions.extend (agent on_mouse_click)
				choice_list.pointer_double_press_item_actions.extend (agent on_mouse_click)
				choice_list.pointer_motion_actions.force_extend (agent on_mouse_move)
				choice_list.key_press_actions.extend (agent on_key)
				choice_list.hide_horizontal_scroll_bar
			else
					-- Something wrong happend here, we should deactivate if possible.
				if not is_destroyed and is_parented then
					deactivate
				end
			end
		end

	on_mouse_move (a_x, a_y: INTEGER) is
			-- Handle mouse moving actions.
		local
			l_item: EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
			x, y: INTEGER
		do
			x := choice_list.virtual_x_position + a_x
			y := choice_list.virtual_y_position + a_y
			if x >= 0 and then a_x < choice_list.virtual_width and then y >= 0 and then y < choice_list.virtual_height then
				l_item := choice_list.item_at_virtual_position (x, y)
				if l_item /= Void then
					l_list := choice_list.selected_items
					if l_list /= Void and then not l_list.is_empty and then l_list.first /= l_item then
						choice_list.remove_selection
					end
					l_item.enable_select
				end
			end
		end

	on_mouse_click (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Handle mouse actions.
		local
			l_item: EV_GRID_ITEM
			l_list: LIST [EV_GRID_ITEM]
			x, y: INTEGER
		do
			if a_button = 1 then
				x := choice_list.virtual_x_position + a_x
				y := choice_list.virtual_y_position + a_y
				if x >= 0 and then a_x < choice_list.virtual_width and then y >= 0 and then y < choice_list.virtual_height then
					l_item := choice_list.item_at_virtual_position (x, y)
					if l_item /= Void then
						l_list := choice_list.selected_items
						if l_list /= Void and then not l_list.is_empty and then l_list.first /= l_item then
							choice_list.remove_selection
							l_item.enable_select
						end
						has_user_selected_item := True
						deactivate
					end
				end
			end
		end

	on_key (a_key: EV_KEY) is
			-- Handle key action on `choice_list'
		do
			if a_key /= Void then
				if a_key.code = {EV_KEY_CONSTANTS}.key_escape then
					deactivate
				elseif a_key.code = {EV_KEY_CONSTANTS}.key_enter then
					has_user_selected_item := True
					deactivate
				end
			end
		end

	deactivate is
			-- Cleanup from previous call to activate.
		local
			l_item: ES_GRID_LIST_ITEM
		do
			if choice_list /= Void and then not choice_list.is_destroyed then
				choice_list.focus_out_actions.wipe_out
				if has_user_selected_item and then not choice_list.selected_rows.is_empty then
					l_item ?= choice_list.selected_rows.first.item (1)
					if l_item /= Void then
						if {lt_selected_item: EB_GRID_LISTABLE_CHOICE_ITEM_ITEM}l_item.data and then lt_selected_item /= selected_item then
							if selection_changing_action /= Void then
								if selection_changing_action.item ([lt_selected_item]) then
									set_list_item (lt_selected_item)
								end
							else
								set_list_item (lt_selected_item)
							end
						end
					end
				end
				choice_list := Void
			end
			Precursor {ES_GRID_LIST_ITEM}
		end

	safe_redraw is
			-- Redraw Current if parented
		do
			if item_components /= Void and then item_components.index_set.count > 1 then
				set_required_width (required_dimension_for_items.width + drop_down_pixmap.width + component_padding)
			else
				set_required_width (required_dimension_for_items.width)
			end
			if is_parented then
				redraw
			end
		end

	display (a_drawable: EV_DRAWABLE; a_selected: BOOLEAN; a_focused: BOOLEAN) is
			-- Display Current in `a_drawable'.
		local
			x, y: INTEGER
			l_left_width, l_left_height: INTEGER
			l_max_width, l_max_height: INTEGER
			l_items: like components
			l_required_width: INTEGER
			l_required_height: INTEGER
			l_item_width: INTEGER
			l_item: like component_type
			i: INTEGER
			l_count: INTEGER
			l_padding: INTEGER
			l_required_dimension: like required_dimension_for_items
			l_positions: like component_position
			l_dropdown: BOOLEAN
		do
			l_padding := component_padding
			if item_components /= Void and then item_components.index_set.count > 1 then
				l_dropdown := True
			end
			prepare_background_area (a_drawable, 0, 0, width, height)

			a_drawable.set_foreground_color (actual_border_line_color)
			a_drawable.draw_rectangle (0, 0, left_border, height)
			a_drawable.draw_rectangle (0, 0, width, top_border)
			a_drawable.draw_rectangle (0, (height - bottom_border).max (0), width, bottom_border)
			a_drawable.draw_rectangle ((width - right_border).max (0), 1, right_border, height)

			l_left_width := (width - left_border - right_border - border_line_width * 2).max (1)
			if l_dropdown then
				l_left_width := (l_left_width - drop_down_pixmap.width - l_padding).max (1)
			end
			l_left_height := (height - top_border - bottom_border - border_line_width * 2).max (1)
			l_required_dimension := required_dimension_for_items
			l_required_width := l_required_dimension.width
			l_required_height := l_required_dimension.height

			x := left_border + border_line_width
			if is_center_aligned then
				x := x + ((l_left_width - l_required_width).max (0)) // 2
			elseif is_right_aligned then
				x := x + (l_left_width - l_required_width).max (0)
			end
			y := top_border + border_line_width
			if is_vertically_center_aligned then
				y := y + ((l_left_height - l_required_height).max (0)) // 2
			elseif is_bottom_aligned then
				y := y + (l_left_height - l_required_height).max (0)
			end
			l_max_height := (l_left_height - y).max (1)
			l_max_width := (l_left_width - x).max (1)
			from
				l_items := components
				l_count := l_items.count
				i := 1
				l_positions := component_position
				l_positions.wipe_out
				l_items.start
			until
				l_items.after or l_max_width = 0
			loop
				l_item := l_items.item
				l_item.display (a_drawable, x, y, l_max_width, l_max_height)
				l_item_width := (l_item.required_width).min (l_max_width)
				l_positions.extend (create {EV_RECTANGLE}.make (x, y, l_item_width, l_max_height))
				if i < l_count then
					l_max_width := (l_max_width - l_item_width - l_padding).max (0)
				end
				x := x + l_item_width + l_padding
				l_items.forth
				i := i + 1
			end
			if l_dropdown then
					-- Draw drop down button
				a_drawable.draw_pixmap ((width - border_line_width - right_border - drop_down_pixmap.width).max (1), ((height - drop_down_pixmap.height) // 2).max (1), drop_down_pixmap)
			end
		end

	selected_item_internal: ?EB_GRID_LISTABLE_CHOICE_ITEM_ITEM

	context_menu_factory: EB_CONTEXT_MENU_FACTORY
			-- Context menu factory

	drop_down_pixmap: EV_PIXMAP is
			-- Drop drawn pixmap
		local
			l_mask: EV_BITMAP
		once
				-- Draw a drop down triangle.
			create Result.make_with_size (9, 6)
			Result.draw_segment (1, 1, 7, 1)
			Result.draw_segment (2, 2, 6, 2)
			Result.draw_segment (3, 3, 5, 3)
			Result.draw_segment (4, 4, 4, 4)

			create l_mask.make_with_size (9, 6)
			l_mask.draw_segment (0, 0, 8, 0)
			l_mask.draw_segment (0, 1, 8, 1)
			l_mask.draw_segment (1, 2, 7, 2)
			l_mask.draw_segment (2, 3, 6, 3)
			l_mask.draw_segment (3, 4, 5, 4)
			l_mask.draw_segment (4, 5, 4, 5)

			Result.set_mask (l_mask)
		ensure
			drop_down_pixmap_not_void: Result /= Void
		end

invariant
	choice_list_parented_during_activation: choice_list /= Void implies choice_list.parent /= Void

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
