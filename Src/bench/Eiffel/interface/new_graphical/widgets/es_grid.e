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
			initialize
		end

	EV_SHARED_APPLICATION
		undefine
			default_create, copy
		end

	EV_GRID_HELPER
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
			header.pointer_button_press_actions.extend (agent on_header_clicked)
			header.pointer_double_press_actions.force_extend (agent on_header_auto_width_resize)

			create scrolling_behavior.make (Current)
			key_press_actions.extend (agent on_key_pressed)

			build_delayed_last_column_auto_resizing
			resize_actions.force_extend (agent delayed_last_column_auto_resizing.request_call)
			virtual_size_changed_actions.extend (agent on_virtual_size_changed_action)
			last_column_use_all_width_enabled := True

			cleaning_delay := 500
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

feature -- Change

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

feature {NONE} -- Actions implementation

	on_key_pressed (k: EV_KEY) is
		do
			if
				not ev_application.shift_pressed
				and not ev_application.alt_pressed
			then
				if ev_application.ctrl_pressed then
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
		end

	on_header_clicked (ax, ay, abutton: INTEGER; ax_tilt, ay_tilt, apressure: DOUBLE; ascreen_x, ascreen_y: INTEGER) is
		local
			m: EV_MENU
			col: EV_GRID_COLUMN
			hi: EV_HEADER_ITEM
			c: INTEGER
			l_x: INTEGER
		do
			if abutton = 3 then
				fixme ("[
						we use this hack, because on linux/GTK,
						the `ax' is related to the current header item's widget
						and not as for windows, related to the full header's widget.
						This way, we have a portable solution.
					]")
				l_x := ascreen_x - header.screen_x

					--| Find the column whom header is clicked
				from
					header.start
				until
					header.after or hi /= Void
				loop
					hi := header.item
					if header.has (hi) then
						if header.item_x_offset (hi) > l_x and header.first /= hi then
							header.back
							hi := header.item
							header.forth
						elseif header.last = hi then
							-- keep loop's col value
						else
							hi := Void
						end
					else
						hi := Void
					end
					header.forth
				end
				if hi /= Void then
					from
						c := 1
					until
						c > column_count or col /= Void
					loop
						if column (c).header_item = hi then
							col := column (c)
						end
						c := c + 1
					end
				end
				if col /= Void then
						--| Col is the pointed header
					m := header_menu_on_column (col)
					m.show_at (header, l_x, ay)
				end
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
			hi := col.header_item
			create Result
			create mi.make_with_text (hi.text)
			mi.disable_sensitive
			Result.extend (mi)

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

			gm := grid_menu
			if gm /= Void then
				Result.extend (create {EV_MENU_SEPARATOR})
				Result.extend (gm)
			end
		end

	grid_menu: EV_MENU is
			-- Menu related to current grid.
		do
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
							column (c).is_displayed or c = 0
						loop
							c := c - 1
						end
						if c > 0 then
							last_col := column (c)
							last_col_minimal_width := last_col.required_width_of_item_span (1, row_count)
							col_left_x := (last_col.virtual_x_position - virtual_x_position)
							if col_left_x + last_col_minimal_width < viewable_width then
								resize_actions.block
								virtual_size_changed_actions.block
								last_col.set_width (viewable_width - col_left_x)
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
									50
							)
			end
		end

	on_virtual_size_changed_action (w,h: INTEGER) is
		do
			delayed_last_column_auto_resizing.request_call
		end

	Additional_pixels_for_column_width: INTEGER is 5
			-- Additional width to add the column's content width during resizing
			-- for better reading.

	process_columns_auto_resizing is
		local
			col: EV_GRID_COLUMN
			c: INTEGER
			w: INTEGER
		do
			if row_count > 0 then
				from
					auto_resized_columns.start
				until
					auto_resized_columns.after
				loop
					c:= auto_resized_columns.item
					if c > 0 and c <= column_count then
						col := column (c)
						if col /= Void then
							w := col.required_width_of_item_span (1, row_count) + Additional_pixels_for_column_width
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

feature {NONE} -- Implementation

	cleaning_delay: INTEGER

	delayed_cleaning: ES_DELAYED_ACTION;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
