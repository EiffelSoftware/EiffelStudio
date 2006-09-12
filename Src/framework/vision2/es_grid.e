indexing
	description: "Objects that represents a enhanced GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID

inherit
	EV_GRID
		redefine
			initialize,
			destroy
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	EV_GRID_HELPER
		undefine
			default_create, copy
		end

	ES_TREE_NAVIGATOR
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	initialize is
		do
			Precursor {EV_GRID}

			build_delayed_columns_auto_resizing
			create auto_resized_columns.make
			auto_resized_columns.compare_objects

			enable_solid_resizing_divider
			set_separator_color (color_separator)
			set_tree_node_connector_color (color_tree_node_connector)
			header.item_pointer_button_press_actions.extend (agent on_header_item_clicked)
			header.pointer_double_press_actions.force_extend (agent on_header_auto_width_resize)

			create scrolling_behavior.make (Current)
			create resizing_behavior.make (Current)
			resizing_behavior.enable_column_resizing

			key_press_actions.extend (agent on_key_pressed)

			build_delayed_last_column_auto_resizing

			resize_actions.extend (agent on_resize_events)
			virtual_size_changed_actions.extend (agent on_resize_events (0,0, ?,?))
			last_column_use_all_width_enabled := True

			cleaning_delay := 500
			set_selected_rows_function (agent selected_rows)
		end

	color_separator: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
		end

	color_tree_node_connector: EV_COLOR is
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end

feature -- properties

	scrolling_behavior: ES_GRID_SCROLLING_BEHAVIOR

	border_enabled: BOOLEAN
			-- Is border enabled ?
			-- i.e: the pre draw cell's border, alias cell separators

	resizing_behavior: ES_GRID_RESIZING_BEHAVIOR

	selected_rows_function: FUNCTION [ANY, TUPLE, LIST [EV_GRID_ROW]] is
			-- Selected rows.
			-- Use `selected_rows' by default.
		do
			if selected_rows_function_internal = Void then
				Result := agent selected_rows
			else
				Result := selected_rows_function_internal
			end
		ensure
			result_attached: Result /= Void
		end

	selected_rows_function_internal: like selected_rows_function
			-- Implementation of `selected_rows_fucntion'

feature -- Change

	disable_resize_column (a_column: INTEGER) is
			-- Disable resize for `a_column'.
		do
			resizing_behavior.disable_resize_on_column (a_column)
		end

	enable_resize_column (a_column: INTEGER) is
			-- Enable resize for `a_column'.
		do
			resizing_behavior.enable_resize_on_column (a_column)
		end

	enable_border is
			-- enabled the cell's borders
		do
			set_border_enabled (True)
		end

	disable_border is
			-- enabled the cell's borders
		do
			set_border_enabled (False)
		end

	set_mouse_wheel_scroll_size (i: INTEGER) is
		do
			scrolling_behavior.set_mouse_wheel_scroll_size (i)
		end

	set_mouse_wheel_scroll_full_page (b: BOOLEAN) is
		do
			scrolling_behavior.set_mouse_wheel_scroll_full_page (b)
		end

	set_scrolling_common_line_count (i: INTEGER) is
		do
			scrolling_behavior.set_scrolling_common_line_count (i)
		end

	on_key_pressed (k: EV_KEY) is
			-- Action to be performed when `k' is pressed in Current.
		local
			l_ev_application: like ev_application
			l_agent: PROCEDURE [ANY, TUPLE]
		do
			l_ev_application := ev_application
			if
				not l_ev_application.shift_pressed
				and not l_ev_application.alt_pressed
			then
				if l_ev_application.ctrl_pressed then
					inspect k.code
					when {EV_KEY_CONSTANTS}.key_a then
						if is_multiple_row_selection_enabled then
							select_all_rows
						end
					else
					end
				else
					inspect k.code
					when {EV_KEY_CONSTANTS}.key_page_up then
						scrolling_behavior.scroll_page (+1)
					when {EV_KEY_CONSTANTS}.key_page_down then
						scrolling_behavior.scroll_page (-1)
					else
					end
				end
			end
			l_agent := key_action_with_shortcut (create {ES_KEY_SHORTCUT}.make_with_key_combination (k, l_ev_application.ctrl_pressed, l_ev_application.alt_pressed, l_ev_application.shift_pressed))
			if l_agent /= Void then
				l_agent.call ([])
			end
		end

	on_header_item_clicked (hi: EV_HEADER_ITEM; ax, ay, abutton: INTEGER) is
		local
			m: EV_MENU
			col: EV_GRID_COLUMN
			ghi: EV_GRID_HEADER_ITEM
			lx: INTEGER_32
		do
			if abutton = 3 then
				ghi ?= hi
				if ghi /= Void and then header.pointed_divider_index = 0 then
					col := column (ghi.column.index)
						--| Col is the pointed header
				end
				m := header_menu_on_column (col)
				lx := ax
				if hi /= Void then
					lx := lx + header.item_x_offset (hi)
				end
				m.show_at (header, lx, ay)
			end
		end

	header_menu_on_column (col: EV_GRID_COLUMN): EV_MENU is
			-- Menu related to `col'.
		local
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			hi: EV_HEADER_ITEM
			gm: EV_MENU
		do
			create Result
			if col /= Void then
				hi := col.header_item
				create mi.make_with_text (hi.text)
			else
				create mi.make_with_text ("Grid menu")
			end
			mi.disable_sensitive
			Result.extend (mi)


			if col /= Void then
				Result.extend (create {EV_MENU_SEPARATOR})
				create mci.make_with_text ("Auto resize")
				if column_has_auto_resizing (col.index) then
					mci.enable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, False))
				else
					mci.disable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, True))
				end
				Result.extend (mci)

				create mci.make_with_text ("Displayed")
				mci.enable_select
				mci.select_actions.extend (agent col.hide)
				Result.extend (mci)
			end

			gm := grid_menu
			if gm /= Void then
				Result.extend (create {EV_MENU_SEPARATOR})
				Result.extend (gm)
			end
		end

	grid_menu: EV_MENU is
			-- Menu related to current grid.
		local
			sm: EV_MENU
			mci: EV_CHECK_MENU_ITEM
			c: INTEGER
			s: STRING
			col: EV_GRID_COLUMN
		do
			create Result.make_with_text ("Grid settings")
			from
				c := 1
			until
				c > column_count
			loop
				col := column (c)
				if not col.title.is_empty then
					s := "Column %"" + col.title + "%""
				else
					s := "Column #" + c.out
				end
				create sm.make_with_text (s)
				Result.extend (sm)

				create mci.make_with_text ("Auto resize")
				if column_has_auto_resizing (c) then
					mci.enable_select
				end
				mci.select_actions.extend (agent set_auto_resizing_column (c, not column_has_auto_resizing (c)))
				sm.extend (mci)

				create mci.make_with_text ("Displayed")
				if col.is_displayed then
					mci.enable_select
					mci.select_actions.extend (agent col.hide)
				else
					mci.select_actions.extend (agent col.show)
				end
				sm.extend (mci)
				c := c + 1
			end
		end

	on_header_auto_width_resize is
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := header.pointed_divider_index
			if div_index > 0 then
				col := column (div_index)
				if row_count > 0 then
					if ev_application.shift_pressed then
						col.set_width (col.required_width_of_item_span (first_visible_row.index, last_visible_row.index) + Additional_pixels_for_column_width)
					else
						col.set_width (col.required_width_of_item_span (1, col.parent.row_count) + Additional_pixels_for_column_width)
					end
				end
			end
		end

	set_selected_rows_function (a_function: like selected_rows_function) is
			-- Set `selected_rows_function' with `a_function'.
		do
			selected_rows_function_internal := a_function
		ensure
			selected_rows_function_set: selected_rows_function = a_function
		end

	enable_default_tree_navigation_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: BOOLEAN) is
			-- Enable default tree navigation behavior.
			-- `a_expand' indicates if expanding a node should be enabled.
			-- `a_expand_recursive' indicates if expanding a node recursively should be enabled.
			-- `a_collapse' indicates if collapsing a node should be enabled.
			-- `a_collapse_recursive' indicates if collapsing a node recursively should be enabled.
		do
			if a_expand then
				if expand_selected_rows_agent = Void then
					set_expand_selected_rows_agent (agent expand_rows (False))
				end
				default_expand_rows_shortcuts.do_all (agent add_key_shortcut (expand_node_action_index, ?))
			end
			if a_expand_recursive then
				if expand_selected_rows_recursive_agent = Void then
					set_expand_selected_rows_recursive_agent (agent expand_rows (True))
				end
				default_expand_rows_recursive_shortcuts.do_all (agent add_key_shortcut (expand_node_recursive_action_index, ?))
			end
			if a_collapse then
				if collapse_selected_rows_agent = Void then
					set_collapse_selected_rows_agent (agent collapse_rows (False))
				end
				default_collapse_rows_shortcuts.do_all (agent add_key_shortcut (collapse_node_action_index, ?))
			end
			if a_collapse_recursive then
				if collapse_selected_rows_recursive_agent = Void then
					set_collapse_selected_rows_recursive_agent (agent collapse_rows (True))
				end
				default_collapse_rows_recursive_shortcuts.do_all (agent add_key_shortcut (collapse_node_recursive_action_index, ?))
			end
		end

feature {NONE} -- Borders drawing

	set_border_enabled (b: BOOLEAN) is
		do
			if b /= border_enabled then
				border_enabled := True
				if border_enabled then
					pre_draw_overlay_actions.extend (agent on_draw_borders)
					header.item_resize_actions.extend (agent invalidate_for_border)
				else
					pre_draw_overlay_actions.wipe_out
					header.item_resize_actions.wipe_out
				end
			end
		end

	on_draw_borders (drawable: EV_DRAWABLE; grid_item: EV_GRID_ITEM; a_column_index, a_row_index: INTEGER) is
		local
			current_column_width, current_row_height: INTEGER
			all_remaining_columns_minimized: BOOLEAN
		do
			drawable.set_foreground_color (separator_color)
			current_column_width := column (a_column_index).width
			if is_row_height_fixed then
				current_row_height := row_height
			else
				current_row_height := row (a_row_index).height
			end
			if a_column_index > 1 then
				drawable.draw_segment (0, 0, 0, current_row_height - 1)
			end
			if a_column_index < column_count then
				if column (a_column_index + 1).virtual_x_position = column (column_count).virtual_x_position + column (column_count).width then
					all_remaining_columns_minimized := True
				end
			end
			if a_column_index = column_count or all_remaining_columns_minimized then
				drawable.draw_segment (current_column_width - 1, 0, current_column_width - 1, current_row_height - 1)
			end
			drawable.draw_segment (0, current_row_height - 1, current_column_width, current_row_height - 1)
		end

	invalidate_for_border (header_item: EV_HEADER_ITEM) is
			-- resized that has a width greater than 0 as the column border must be updated
			-- in this column.
			-- (export status {NONE})
		local
			header_index: INTEGER
			old_header_index: INTEGER
		do
			header_index := header_item.parent.index_of (header_item, 1)
			old_header_index := header_index
			if (last_width_of_header_during_resize = 0 and header_item.width > 0) or last_width_of_header_during_resize_internal > 0 and header_item.width = 0 then
				if header_index > 1 then
					from
						header_index := header_index - 1
					until
						header_index = 1 or column (header_index).width > 0
					loop
						header_index := header_index - 1
					end
				end
				if header_index < old_header_index then
					column (header_index).redraw
				end
			end
		end

	last_width_of_header_during_resize: INTEGER is
			-- The last width of the header item that is currently being
			-- resized. Used to determine if we must refresh the column to
			-- the left of the current one as it could cause the border to
			-- need to be drawn on the previous column if it is the final
			-- column that current has a width greater than 0.
		do
			Result := last_width_of_header_during_resize_internal
		ensure
			result_non_negative: Result >= 0
		end

	last_width_of_header_during_resize_internal: INTEGER
			-- Storage for `last_width_of_header_during_resize'.

feature -- column resizing access

	enable_last_column_use_all_width is
		do
			last_column_use_all_width_enabled := True
		end

	disable_last_column_use_all_width is
		do
			last_column_use_all_width_enabled := False
		end

	set_auto_resizing_column (c: INTEGER; auto: BOOLEAN) is
		do
			if column_has_auto_resizing (c) then
				if not auto then
					auto_resized_columns.prune_all (c)
					request_columns_auto_resizing
				end
			elseif auto then
				auto_resized_columns.extend (c)
				request_columns_auto_resizing
			end
		end

	request_columns_auto_resizing is
		do
			if not auto_resized_columns.is_empty then
				delayed_columns_auto_resizing.request_call
			end
		end

feature {NONE} -- column resizing impl

	last_column_use_all_width_enabled: BOOLEAN

	ensure_last_column_use_all_width is
		local
			c: INTEGER
			last_col: EV_GRID_COLUMN
			last_col_minimal_width, col_left_x: INTEGER
		do
			if last_column_use_all_width_enabled then
				if not implementation.is_header_item_resizing then
					debug
						print (generator + ".ensure_last_column_use_all_width %N")
					end
					if row_count > 0 and column_count > 0 then
						from
							c := column_count
						until
							c = 0 or else column (c).is_displayed
						loop
							c := c - 1
						end
						if c > 0 then
							last_col := column (c)
							last_col_minimal_width := last_col.required_width_of_item_span (1, row_count)
							col_left_x := (last_col.virtual_x_position - virtual_x_position)
							if
								viewable_width > col_left_x
								and then (
									col_left_x + last_col_minimal_width < viewable_width
									or else	(last_col.width < last_col_minimal_width and col_left_x + last_col.width < viewable_width)
								)
							then
								resize_actions.block
								virtual_size_changed_actions.block
								last_col.set_width (viewable_width - col_left_x)
									--| IEK This line does not seem to be needed and causes potential
									--| infinite loops during resizing on gtk.
								--implementation.recompute_horizontal_scroll_bar
								virtual_size_changed_actions.resume
								resize_actions.resume
							end
						end
					end
				end
			end
		end

	delayed_columns_auto_resizing: ES_DELAYED_ACTION

	build_delayed_columns_auto_resizing is
		do
			if delayed_columns_auto_resizing = Void then
				create delayed_columns_auto_resizing.make (
									agent process_columns_auto_resizing,
									500
							)
			end
		end

	delayed_last_column_auto_resizing: ES_DELAYED_ACTION

	build_delayed_last_column_auto_resizing is
		do
			if delayed_last_column_auto_resizing = Void then
				create delayed_last_column_auto_resizing.make (
									agent ensure_last_column_use_all_width,
									100
							)
			end
		end

	Additional_pixels_for_column_width: INTEGER is 5
			-- Additional width to add the column's content width during resizing
			-- for better reading.

	process_columns_auto_resizing is
		local
			col: EV_GRID_COLUMN
			c: INTEGER
			w: INTEGER
			l_column_text_width: INTEGER
			l_font: EV_FONT
		do
			if row_count > 0 then
				from
					create l_font
					auto_resized_columns.start
				until
					auto_resized_columns.after
				loop
					c := auto_resized_columns.item
					if c > 0 and c <= column_count then
						col := column (c)
						if col /= Void then
							w := col.required_width_of_item_span (1, row_count) + Additional_pixels_for_column_width
							l_column_text_width := l_font.string_width (col.header_item.text) + 20
							w := w.max (l_column_text_width)
							if w > 5 then
								if w < col.width and col.index = column_count then
									--| Do not resize smaller if it is last column
								else
									col.set_width (w)
								end
							end
						end
					end
					auto_resized_columns.forth
				end
				delayed_last_column_auto_resizing.request_call
			end
		end

	column_has_auto_resizing (c: INTEGER): BOOLEAN is
		do
			Result := auto_resized_columns.has (c)
		end

	auto_resized_columns: LINKED_LIST [INTEGER]

feature {NONE} -- Events

	on_resize_events (ax, ay, aw, ah: INTEGER) is
		do
			if not is_destroyed then
				delayed_last_column_auto_resizing.request_call
			end
		end

feature -- Grid helpers

	front_new_row: EV_GRID_ROW is
		do
			Result := grid_front_new_row (Current)
		end

	extended_new_row: EV_GRID_ROW is
		do
			Result := grid_extended_new_row (Current)
		end

	extended_new_subrow (a_row: EV_GRID_ROW): EV_GRID_ROW is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			Result := grid_extended_new_subrow (a_row)
		end

	remove_and_clear_subrows_from (a_row: EV_GRID_ROW) is
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			grid_remove_and_clear_subrows_from (a_row)
		end

	remove_and_clear_all_rows is
		require
			not is_processing_remove_and_clear_all_rows
		do
			is_processing_remove_and_clear_all_rows := True
			grid_remove_and_clear_all_rows (Current)
			is_processing_remove_and_clear_all_rows := False
		end

	is_processing_remove_and_clear_all_rows: BOOLEAN

	select_all_rows is
			-- Select all rows from the grid
		local
			r: INTEGER
		do
			if row_count > 0 then
				from
					r := 1
				until
					r > row_count
				loop
					select_row (r)
					r := r + 1
				end
			end
		end

	single_selected_row: EV_GRID_ROW is
		require
			is_single_row_selection_enabled: is_single_row_selection_enabled
		local
			l_rows: like selected_rows
		do
			l_rows := selected_rows
			if l_rows.count = 1 then
				Result := l_rows.first
			end
		end

feature -- Delayed cleaning

	delayed_cleaning_exists: BOOLEAN is
		do
			Result := delayed_cleaning /= Void
		end

	request_delayed_clean is
		require
			delayed_cleaning_exists
		do
			delayed_cleaning.request_call
		end

	call_delayed_clean is
		require
			delayed_cleaning_exists
		do
			delayed_cleaning.call
		end

	cancel_delayed_clean is
		require
			delayed_cleaning_exists
		do
			delayed_cleaning.cancel_request
		end

	set_cleaning_delay (v: INTEGER) is
		require
			v_positive_or_zero: v >= 0
		do
			cleaning_delay := v
			if delayed_cleaning /= Void then
				delayed_cleaning.set_delay (cleaning_delay)
			end
		end

	build_delayed_cleaning is
		do
			if delayed_cleaning = Void then
				create delayed_cleaning.make (
									agent default_clean,
									cleaning_delay
							)
				delayed_cleaning.set_on_request_start_action (agent disable_sensitive)
				delayed_cleaning.set_on_request_end_action (agent enable_sensitive)
			end
		end

	default_clean is
		do
			remove_and_clear_all_rows
		end

	set_delayed_cleaning_action (v: PROCEDURE [ANY, TUPLE]) is
		require
			delayed_cleaning_exists
		do
			delayed_cleaning.set_delayed_action (v)
		end

feature -- Commands

	destroy is
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor {EV_GRID}

			if delayed_columns_auto_resizing /= Void then
				delayed_columns_auto_resizing.cancel_request
			end
			if delayed_last_column_auto_resizing /= Void then
				delayed_last_column_auto_resizing.cancel_request
			end
			if delayed_cleaning /= Void then
				delayed_cleaning.cancel_request
			end
		end

feature {NONE} -- Implementation

	cleaning_delay: INTEGER

	delayed_cleaning: ES_DELAYED_ACTION

feature {NONE} -- Actions

	on_expand_rows (a_recursive: BOOLEAN) is
			-- Action to be performed when expanding rows.
		do
			if not a_recursive then
				if expand_selected_rows_agent /= Void then
					expand_selected_rows_agent.call ([])
				end
			else
				if expand_selected_rows_recursive_agent /= Void then
					expand_selected_rows_recursive_agent.call ([])
				end
			end
		end

	on_collapse_rows (a_recursive: BOOLEAN) is
			-- Action to be performed when collapsing rows.
		do
			if not a_recursive then
				if collapse_selected_rows_agent /= Void then
					collapse_selected_rows_agent.call ([])
				end
			else
				if collapse_selected_rows_recursive_agent /= Void then
					collapse_selected_rows_recursive_agent.call ([])
				end
			end
		end

feature {NONE} -- Tree view behavior

	expand_row (a_row: EV_GRID_ROW; a_recursive: BOOLEAN) is
			-- Expand `a_row'.
			-- If `a_recursive' is True, recursively expand all subrows of `a_row'.
		require
			tree_enabled: is_tree_enabled
			a_row_parented: a_row.parent = Current
		local
			i, c: INTEGER
		do
			if a_row.is_expandable and then not a_row.is_expanded then
				a_row.expand
				c := a_row.subrow_count
				if a_recursive and then c > 0 then
					from
						i := 1
					until
						i > c
					loop
						expand_row (a_row.subrow (i), a_recursive)
						i := i + 1
					end
				end
			end
		end

	collapse_row (a_row: EV_GRID_ROW; a_recursive: BOOLEAN) is
			-- Collapse `a_row'.
			-- If `a_recursive' is True, recursively collapse all subrows of `a_row'.
		require
			tree_enabled: is_tree_enabled
			a_row_parented: a_row.parent = Current
		local
			i, c: INTEGER
		do
			if a_row.is_expandable and then a_row.is_expanded then
				a_row.collapse
				c := a_row.subrow_count
				if a_recursive and then c > 0 then
					from
						i := 1
					until
						i > c
					loop
						collapse_row (a_row.subrow (i), a_recursive)
						i := i + 1
					end
				end
			end
		end

	expand_rows (a_recursive: BOOLEAN) is
			-- Expand all rows returned by `selected_rows_function'.
			-- If `a_recursive' is True, expand those rows recursively.
		local
			l_rows: LIST [EV_GRID_ROW]
		do
			l_rows := selected_rows_function.item ([])
			if l_rows /= Void and then not l_rows.is_empty then
				if a_recursive then
					remove_unnecessary_rows (l_rows)
				end
				l_rows.do_all (agent expand_row (?, a_recursive))
			end
		end

	collapse_rows (a_recursive: BOOLEAN) is
			-- Collapse all rows returned by `selected_rows_function'.
			-- If `a_recursive' is True, collapse those rows recursively.
		local
			l_rows: LIST [EV_GRID_ROW]
		do
			l_rows := selected_rows_function.item ([])
			if l_rows /= Void and then not l_rows.is_empty then
				if a_recursive then
					remove_unnecessary_rows (l_rows)
				end
				l_rows.do_all (agent collapse_row (?, a_recursive))
			end
		end

	remove_unnecessary_rows (a_rows: LIST [EV_GRID_ROW]) is
			-- Remove unnecessary rows in `a_rows' for recursive expansion or collapsion.
		require
			a_rows_attached: a_rows /= Void
		local
			l_row_tbl: HASH_TABLE [EV_GRID_ROW, INTEGER]
			l_parent_row: EV_GRID_ROW
			l_current_row: EV_GRID_ROW
			done: BOOLEAN
		do
			create l_row_tbl.make (a_rows.count)
			from
				a_rows.start
			until
				a_rows.after
			loop
				l_row_tbl.put (a_rows.item, a_rows.item.index)
				a_rows.forth
			end

			from
				a_rows.start
			until
				a_rows.after
			loop
				l_current_row := a_rows.item
				l_parent_row := a_rows.item.parent_row
				done := False
				if l_parent_row /= Void then
					from until
						l_parent_row = Void or done
					loop
						if l_row_tbl.has (l_parent_row.index) then
							a_rows.remove
							l_row_tbl.remove (l_current_row.index)
							done := True
						else
							l_parent_row := l_parent_row.parent_row
						end
					end
				end
				if not done then
					a_rows.forth
				end
			end
		end

invariant
	selected_rows_agent_attached: selected_rows_function /= Void

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
