note
	description: "Objects that represents a enhanced GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID

inherit
	EV_GRID
		redefine
			create_interface_objects,
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

	SHARED_BENCH_NAMES
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization

	create_interface_objects
		do
			create auto_resized_columns.make
			auto_resized_columns.compare_objects
			create manually_resized_columns.make (0)
		end

	initialize
		local
			l_resizing_behavior: like resizing_behavior
		do
			Precursor {EV_GRID}

			build_delayed_columns_auto_resizing

			enable_solid_resizing_divider
			set_separator_color (color_separator)
			set_tree_node_connector_color (color_tree_node_connector)
			header.item_pointer_button_press_actions.extend (agent on_header_item_clicked)
			header.pointer_double_press_actions.extend
				(agent (x, y, b: INTEGER_32; x_tilt, y_tilt, p: REAL_64; s_x, s_y: INTEGER_32)
					do
						on_header_auto_width_resize
					end)

			header.item_resize_start_actions.extend (agent on_header_resize_start)
			header.item_resize_end_actions.extend (agent on_header_resize_end)

			create scrolling_behavior.make (Current)
			create l_resizing_behavior.make (Current)
			l_resizing_behavior.enable_column_resizing
			l_resizing_behavior.header_resize_end_actions.extend (agent on_header_manually_resized)
			resizing_behavior := l_resizing_behavior

			key_press_actions.extend (agent on_key_pressed)

			build_delayed_last_column_auto_resizing

			resize_actions.extend (agent on_resize_events)
			dpi_changed_actions.extend (agent on_dpi_resize_events)
			virtual_size_changed_actions.extend (agent on_resize_events (0,0, ?,?))
			last_column_use_all_width_enabled := True

			cleaning_delay := 500
			set_selected_rows_function (agent selected_rows_in_grid)

			header.item_resize_end_actions.extend (agent (a_item: EV_HEADER_ITEM)
					-- Called to set last moved header item.
				do
					last_resized_grid_header := a_item
				end)

				-- Add default row expand and collapse handling.
			row_expand_actions.extend (agent on_row_expand)
			row_collapse_actions.extend (agent on_row_collapse)
		end

	color_separator: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (210, 210, 210)
		end

	color_tree_node_connector: EV_COLOR
		once
			create Result.make_with_8_bit_rgb (0, 0, 0)
		end

feature -- Access

	auto_size_best_fit_column: INTEGER
			-- Column index automatically resized to ensure all columns fit in view.
			-- Note: 0 indicates no best-fitting

feature {NONE} -- Access

	last_resized_grid_header: detachable EV_HEADER_ITEM
			-- Last resized header

feature -- Status report

	use_auto_size_best_fit: BOOLEAN
			-- Indicates if there a column that will be automatically resized to fit the visible width
		do
			Result := auto_size_best_fit_column > 0
		end

	last_column_use_all_width_enabled: BOOLEAN
			-- Indicates if the last column width should be automatically ajusted

feature -- Status setting

	enable_last_column_use_all_width
			-- Enables last column with to be automatically adjust to fit the viewable width of the grid
		do
			last_column_use_all_width_enabled := True
			auto_size_best_fit_column := 0
		ensure
			last_column_use_all_width_enabled: last_column_use_all_width_enabled
			not_use_auto_size_best_fit: not use_auto_size_best_fit
		end

	disable_last_column_use_all_width
			-- Disables last column with to be automatically adjust to fit the viewable width of the grid
		do
			last_column_use_all_width_enabled := False
		ensure
			not_last_column_use_all_width_enabled: not last_column_use_all_width_enabled
		end

	enable_auto_size_best_fit_column (a_column: INTEGER)
			-- Enabled auto sizing of column `a_column' to best fit the viewiable area of the grid.
		require
			a_column_positive: a_column > 0
			a_column_small_enough: a_column <= column_count
		do
			auto_size_best_fit_column := a_column
			last_column_use_all_width_enabled := False
		ensure
			not_last_column_use_all_width_enabled: not last_column_use_all_width_enabled
			use_auto_size_best_fit: use_auto_size_best_fit
			auto_size_best_fit_column_set: auto_size_best_fit_column = a_column
		end

	disable_auto_size_best_fit_column
			-- Disables auto sizing of a specified column so the columns will no longer auto-fit the grid's viewable width.
		do
			auto_size_best_fit_column := 0
		ensure
			not_use_auto_size_best_fit: not use_auto_size_best_fit
		end

	reset_manually_resized_columns
			-- Resize manually resized columns
		do
			manually_resized_columns.wipe_out
		end

feature -- properties

	border_enabled: BOOLEAN
			-- Is border enabled ?
			-- i.e: the pre draw cell's border, alias cell separators

	scrolling_behavior: detachable ES_GRID_SCROLLING_BEHAVIOR

	resizing_behavior: detachable ES_GRID_RESIZING_BEHAVIOR

	selected_rows_function: FUNCTION [LIST [EV_GRID_ROW]]
			-- Selected rows.
			-- Use `selected_rows' by default.
		do
			if attached selected_rows_function_internal as agt then
				Result := agt
			else
				Result := agent selected_rows
			end
		ensure
			result_attached: Result /= Void
		end

	selected_rows_function_internal: detachable like selected_rows_function
			-- Implementation of `selected_rows_function'

feature -- Change

	disable_resize_column (a_column: INTEGER)
			-- Disable resize for `a_column'.
		do
			if attached resizing_behavior as agt then
				agt.disable_resize_on_column (a_column)
			end
		end

	enable_resize_column (a_column: INTEGER)
			-- Enable resize for `a_column'.
		do
			if attached resizing_behavior as agt then
				agt.enable_resize_on_column (a_column)
			end
		end

	enable_border
			-- enabled the cell's borders
		do
			set_border_enabled (True)
		end

	disable_border
			-- enabled the cell's borders
		do
			set_border_enabled (False)
		end

	set_mouse_wheel_scroll_size (i: INTEGER)
		do
			if attached scrolling_behavior as agt then
				agt.set_mouse_wheel_scroll_size (i)
			end
		end

	set_mouse_wheel_scroll_full_page (b: BOOLEAN)
		do
			if attached scrolling_behavior as agt then
				agt.set_mouse_wheel_scroll_full_page (b)
			end
		end

	set_scrolling_common_line_count (i: INTEGER)
		do
			if attached scrolling_behavior as agt then
				agt.set_scrolling_common_line_count (i)
			end
		end

	set_selected_rows_function (a_function: like selected_rows_function)
			-- Set `selected_rows_function' with `a_function'.
		do
			selected_rows_function_internal := a_function
		ensure
			selected_rows_function_set: selected_rows_function = a_function
		end

	enable_default_tree_navigation_behavior (a_expand, a_expand_recursive, a_collapse, a_collapse_recursive: BOOLEAN)
			-- Enable default tree navigation behavior.
			-- `a_expand' indicates if expanding a node should be enabled.
			-- `a_expand_recursive' indicates if expanding a node recursively should be enabled.
			-- `a_collapse' indicates if collapsing a node should be enabled.
			-- `a_collapse_recursive' indicates if collapsing a node recursively should be enabled.
		local
			l_agent: like expand_selected_rows_agent
		do
			if a_expand then
				l_agent := expand_selected_rows_agent
				if l_agent = Void then
					l_agent := agent expand_rows (False)
					set_expand_selected_rows_agent (l_agent)
				end
				default_expand_rows_shortcuts.do_all (agent register_shortcut (?, l_agent))
			end
			if a_expand_recursive then
				l_agent := expand_selected_rows_recursive_agent
				if l_agent = Void then
					l_agent := agent expand_rows (True)
					set_expand_selected_rows_recursive_agent (l_agent)
				end
				default_expand_rows_recursive_shortcuts.do_all (agent register_shortcut (?, l_agent))
			end
			if a_collapse then
				l_agent := collapse_selected_rows_agent
				if l_agent = Void then
					l_agent := agent collapse_rows (False)
					set_collapse_selected_rows_agent (l_agent)
				end
				default_collapse_rows_shortcuts.do_all (agent register_shortcut (?, l_agent))
			end
			if a_collapse_recursive then
				l_agent := collapse_selected_rows_recursive_agent
				if l_agent = Void then
					l_agent := agent collapse_rows (True)
					set_collapse_selected_rows_recursive_agent (l_agent)
				end
				default_collapse_rows_recursive_shortcuts.do_all (agent register_shortcut (?, l_agent))
			end
		end

feature {NONE} -- Grid Events

	on_key_pressed (k: EV_KEY)
			-- Action to be performed when `k' is pressed in Current.
		local
			l_ev_application: like ev_application
			l_shortcut: ES_KEY_SHORTCUT
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
				elseif attached scrolling_behavior as scr then
					inspect k.code
					when {EV_KEY_CONSTANTS}.key_page_up then
						scr.scroll_page (+1)
					when {EV_KEY_CONSTANTS}.key_page_down then
						scr.scroll_page (-1)
					when {EV_KEY_CONSTANTS}.key_home then
						scr.scroll_to_top
					when {EV_KEY_CONSTANTS}.key_end then
						scr.scroll_to_end
					else
					end
				end
			end
			create l_shortcut.make_with_key_combination (
					k,
					l_ev_application.ctrl_pressed,
					l_ev_application.alt_pressed,
					l_ev_application.shift_pressed
				)
			if is_shortcut_registered (l_shortcut) then
				call_shortcut_actions (l_shortcut)
			end
		end

	on_header_item_clicked (hi: detachable EV_HEADER_ITEM; ax, ay, abutton: INTEGER)
		local
			m: EV_MENU
			col: detachable EV_GRID_COLUMN
			lx: INTEGER_32
		do
			if abutton = 3 then
				if attached {EV_GRID_HEADER_ITEM} hi as ghi and then header.pointed_divider_index = 0 then
					if attached ghi.column as col_i then
						col := column (col_i.index)
					end
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

	on_header_auto_width_resize
		local
			div_index: INTEGER
			col: EV_GRID_COLUMN
		do
			div_index := header.pointed_divider_index
			if div_index > 0 and row_count > 0 then
				col := column (div_index)
				check col_not_void: col /= Void end
				resize_column_to_content (col, False, ev_application.shift_pressed)
			end
		end

feature -- Resizing

	resize_column_to_content (col: EV_GRID_COLUMN; include_header_text, only_visible_part: BOOLEAN)
		require
			col_not_void: col /= Void
			grid_not_empty: row_count > 0
		local
			hw, w: INTEGER
			hf: EV_FONT
		do
			if only_visible_part then
				if attached first_visible_row as fvr and attached last_visible_row as lvr then
					w := col.required_width_of_item_span (fvr.index, lvr.index)
				else
						--| Should not occurs since the grid is not empty (see precondition)
					check grid_not_empty: False end
				end
			else
				w := col.required_width_of_item_span (1, row_count)
			end
			w := w + Additional_pixels_for_column_width
			if is_header_displayed and include_header_text then
				hf := header.font
				check header_font_not_void: hf /= Void end
				hw := hf.string_width (col.header_item.text) + Additional_pixels_for_header_item_width
				if col.header_item.pixmap /= Void then
					hw := hw + header.pixmaps_width
				end
				w := w.max (hw)
			end
			if w > 5 then
				if w < col.width and col.index = column_count then
					--| Do not resize smaller if it is last column
				else
					col.set_width (w)
				end
			end
		end

	safe_resize_column_to_content (col: detachable EV_GRID_COLUMN; include_header_text, only_visible_part: BOOLEAN)
			-- similar to resize_column_to_content but check input first
		do
			if col /= Void and row_count > 0 then
				resize_column_to_content (col, include_header_text, only_visible_part)
			end
		end

feature -- Header menu

	header_menu_on_column (col: detachable EV_GRID_COLUMN): EV_MENU
			-- Menu related to `col'.
		local
			mi: EV_MENU_ITEM
			mci: EV_CHECK_MENU_ITEM
			hi: EV_HEADER_ITEM
			gm: EV_MENU
			s: detachable STRING_GENERAL
		do
			create Result
			if col /= Void then
				hi := col.header_item
				s := hi.text
			end
			if s = Void or else s.is_empty then
				s := names.m_grid_menu
			end
			create mi.make_with_text (s)
			mi.disable_sensitive
			Result.extend (mi)

			if col /= Void then
				Result.extend (create {EV_MENU_SEPARATOR})
				create mci.make_with_text (names.m_auto_resize)
				if column_has_auto_resizing (col.index) then
					mci.enable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, False))
				else
					mci.disable_select
					mci.select_actions.extend (agent set_auto_resizing_column (col.index, True))
				end
				Result.extend (mci)

				create mci.make_with_text (names.m_displayed)
				mci.enable_select
				mci.select_actions.extend (agent col.hide)
				Result.extend (mci)
				Result.extend (create {EV_MENU_SEPARATOR})
				create mi.make_with_text (names.m_resize_to_content)
				mi.select_actions.extend (agent safe_resize_column_to_content (col, True, False))
				Result.extend (mi)
				create mi.make_with_text (names.m_resize_to_visible_content)
				mi.select_actions.extend (agent safe_resize_column_to_content (col, True, True))
				Result.extend (mi)
			end

			gm := grid_menu
			if gm /= Void then
				Result.extend (create {EV_MENU_SEPARATOR})
				Result.extend (gm)
			end
		end

	grid_menu: EV_MENU
			-- Menu related to current grid.
		local
			sm: EV_MENU
			mci: EV_CHECK_MENU_ITEM
			c: INTEGER
			s: STRING_GENERAL
			col: EV_GRID_COLUMN
		do
			create Result.make_with_text (names.m_grid_settings)
			from
				c := 1
			until
				c > column_count
			loop
				col := column (c)
				if not col.title.is_empty then
					s := names.m_column_n_title (col.title)
				else
					s := names.m_column_n_index (c.out)
				end
				create sm.make_with_text (s)
				Result.extend (sm)

				create mci.make_with_text (names.m_auto_resize)
				if column_has_auto_resizing (c) then
					mci.enable_select
				end
				mci.select_actions.extend (agent set_auto_resizing_column (c, not column_has_auto_resizing (c)))
				sm.extend (mci)

				create mci.make_with_text (names.m_displayed)
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

feature {NONE} -- Borders drawing

	set_border_enabled (b: BOOLEAN)
		do
			if b /= border_enabled then
				border_enabled := B
				if border_enabled then
					pre_draw_overlay_actions.extend (agent on_draw_borders)
					header.item_resize_actions.extend (agent invalidate_for_border)
				else
					pre_draw_overlay_actions.prune (agent on_draw_borders)
					header.item_resize_actions.prune (agent invalidate_for_border)
				end
			end
		end

	on_draw_borders (drawable: EV_DRAWABLE; grid_item: detachable EV_GRID_ITEM; a_column_index, a_row_index: INTEGER)
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

	invalidate_for_border (header_item: EV_HEADER_ITEM)
			-- resized that has a width greater than 0 as the column border must be updated
			-- in this column.
			-- (export status {NONE})
		local
			header_index: INTEGER
			old_header_index: INTEGER
		do
			if attached header_item.parent as hp then
				header_index := hp.index_of (header_item, 1)
			end
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

	last_width_of_header_during_resize: INTEGER
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

	set_auto_resizing_column (c: INTEGER; auto: BOOLEAN)
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

	request_columns_auto_resizing
		do
			if not auto_resized_columns.is_empty then
				if attached delayed_columns_auto_resizing as d then
					d.request_call
				end
			end
		end

feature {NONE} -- column resizing impl

	ensure_auto_size_best_fit
			-- Automatically resized a selected column to fit the grid's viewable area
		local
			l_index: INTEGER
			l_columns: ARRAYED_LIST [EV_GRID_COLUMN]
			l_col: EV_GRID_COLUMN
			l_count, i: INTEGER
			l_total_width: INTEGER
			l_new_width: INTEGER
		do
			if use_auto_size_best_fit then
				l_index := auto_size_best_fit_column
				if last_resized_grid_header /= Void and then last_resized_grid_header = header.i_th (l_index) and then header.count > l_index then
						-- Small hack that pretends the next column is auto-resized. This fixes an issue that prevents the
						-- adjecent column from being resized correctly.
					last_resized_grid_header := Void
					auto_size_best_fit_column := l_index + 1
					ensure_auto_size_best_fit
					auto_size_best_fit_column := l_index
				else
						-- Do normal resizing
					if not implementation.is_header_item_resizing then
						debug
							print (generator + ".ensure_last_column_use_all_width %N")
						end
						l_index := auto_size_best_fit_column
						if column_count > l_index then
							if column (l_index).is_displayed then
								from
									i := 1
									l_count := column_count
									create l_columns.make (l_count)
								until
									i > l_count
								loop
									l_col := column (i)
									if l_col.is_displayed then
										l_columns.extend (l_col)
										if i /= l_index then
												-- Ingore the width of the column we want to change
											l_total_width := l_total_width + l_col.width
										end
									end
									i := i + 1
								end

								if not l_columns.is_empty then
									l_col := column (l_index)
									l_new_width := viewable_width - l_total_width
									if l_new_width /= l_col.width then
										if l_new_width < 0 then
											l_new_width := 0
										end
										if manually_resized_columns.has (l_index) implies l_col.required_width_of_item_span (1, row_count) < l_new_width then
											resize_actions.block
											virtual_size_changed_actions.block
											l_col.set_width (l_new_width)
											virtual_size_changed_actions.resume
											resize_actions.resume
										end
									end
								end
							else
									-- Use last, if possible
								if last_column_use_all_width_enabled then
									ensure_last_column_use_all_width
								end
							end
						end
					end
				end
			end
		end

	ensure_last_column_use_all_width
			-- Ensures the last column width fits the containing grid.
		local
			c: INTEGER
			last_col: EV_GRID_COLUMN
			last_col_minimal_width, col_left_x: INTEGER
			l_new_width: INTEGER
		do
			if last_column_use_all_width_enabled then
				if
					not implementation.is_header_item_resizing
				then
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
							col_left_x := (last_col.virtual_x_position - virtual_x_position)
							l_new_width := viewable_width - col_left_x
							if
								l_new_width > 0
								and then last_col.width /= l_new_width --| Don't change the width, and it is already ok
							then
								last_col_minimal_width := last_col.required_width_of_item_span (1, row_count)
								if
									last_col_minimal_width < l_new_width
									or else	(last_col.width < last_col_minimal_width and last_col.width < l_new_width)
								then
									resize_actions.block
									virtual_size_changed_actions.block
									if is_header_displayed then
										last_col.set_width (l_new_width.max (last_col.header_item.minimum_width))
									else
										last_col.set_width (l_new_width)
									end

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
		end


	delayed_columns_auto_resizing: detachable ES_DELAYED_ACTION

	build_delayed_columns_auto_resizing
		do
			if delayed_columns_auto_resizing = Void then
				create delayed_columns_auto_resizing.make (
									agent process_columns_auto_resizing,
									500
							)
			end
		end

	delayed_last_column_auto_resizing: detachable ES_DELAYED_ACTION

	build_delayed_last_column_auto_resizing
		do
			if delayed_last_column_auto_resizing = Void then
				create delayed_last_column_auto_resizing.make (
									agent
										do
											if use_auto_size_best_fit then
												ensure_auto_size_best_fit
											elseif last_column_use_all_width_enabled then
												ensure_last_column_use_all_width
											end
										end,
									100
							)
			end
		end

	Additional_pixels_for_column_width: INTEGER = 5
			-- Additional width to add the column's content width during resizing
			-- for better reading.

	Additional_pixels_for_header_item_width: INTEGER = 20
			-- Additional width to add the header item's content width during resizing
			-- for better reading.

	process_columns_auto_resizing
		local
			col: EV_GRID_COLUMN
			c: INTEGER
			w: INTEGER
			l_column_header_width: INTEGER
			l_font: EV_FONT
		do
			if row_count > 0 then
				from
					l_font := header.font
					auto_resized_columns.start
				until
					auto_resized_columns.after
				loop
					c := auto_resized_columns.item
					if c > 0 and c <= column_count then
						col := column (c)
						if col /= Void then
							w := col.required_width_of_item_span (1, row_count) + Additional_pixels_for_column_width
							l_column_header_width := l_font.string_width (col.header_item.text) + 20
							if col.pixmap /= Void then
								l_column_header_width := l_column_header_width + header.pixmaps_width
							end
							w := w.max (l_column_header_width)
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
				if attached delayed_last_column_auto_resizing as d then
					d.request_call
				end
			end
		end

	column_has_auto_resizing (c: INTEGER): BOOLEAN
		do
			Result := auto_resized_columns.has (c)
		end

	auto_resized_columns: LINKED_LIST [INTEGER]

	manually_resized_columns: ARRAYED_LIST [INTEGER]
			-- Record of all manually rezied columns

	header_resize_started: BOOLEAN
			-- Header resize started?

feature {NONE} -- Auto Events

	header_item_column (a_header_item: EV_HEADER_ITEM): detachable EV_GRID_COLUMN
		local
			i, n: INTEGER
		do
			from
				i := 1
				n := column_count
			until
				Result /= Void
			loop
				if attached column (i) as col and then col.header_item = a_header_item then
					Result := col
				end
				i := i + 1
			end
		end

	on_header_resize_start (a_header_item: EV_HEADER_ITEM)
			-- Call when the column header resizing starts.
		do
			header_resize_started := True
		end

	on_header_resize_end (a_header_item: EV_HEADER_ITEM)
			-- Call when the column header resizing ends.
		require
			a_header_item_attached: a_header_item /= Void
		do
			if header_resize_started then
				on_header_manually_resized (a_header_item)
				header_resize_started := False
			end
		end

	on_header_manually_resized (a_header_item: EV_HEADER_ITEM)
			-- Call when the column header has been manually resized.
		require
			a_header_item_attached: a_header_item /= Void
		local
			l_index: INTEGER
			l_columns: like manually_resized_columns
		do
			if attached header_item_column (a_header_item) as col then
				l_columns := manually_resized_columns
				l_index := col.index
				if not l_columns.has (l_index) then
					l_columns.extend (l_index)
				end
			end
		end

	on_resize_events (ax, ay, aw, ah: INTEGER)
		do
			last_resized_grid_header := Void
			if not is_destroyed then
				if attached delayed_last_column_auto_resizing as d then
					d.request_call
				end
			end
		end

	on_dpi_resize_events (a_dpi: NATURAL_32; ax, ay, aw, ah: INTEGER)
		do
			on_resize_events (ax, ay, aw, ah)
		end

feature -- Grid helpers

	front_new_row: EV_GRID_ROW
		do
			Result := grid_front_new_row (Current)
		end

	extended_new_row: EV_GRID_ROW
		do
			Result := grid_extended_new_row (Current)
		end

	extended_new_subrow (a_row: EV_GRID_ROW): EV_GRID_ROW
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			Result := grid_extended_new_subrow (a_row)
		end

	remove_and_clear_subrows_from (a_row: EV_GRID_ROW)
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			grid_remove_and_clear_subrows_from (a_row)
		end

	remove_and_clear_all_rows
		require
			not is_processing_remove_and_clear_all_rows
		do
			is_processing_remove_and_clear_all_rows := True
			grid_remove_and_clear_all_rows (Current)
			is_processing_remove_and_clear_all_rows := False
		end

	is_processing_remove_and_clear_all_rows: BOOLEAN

	select_all_rows
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

	single_selected_row: detachable EV_GRID_ROW
			-- Single selected row
		require
			single_row_selection: is_single_row_selection_enabled or (is_multiple_row_selection_enabled and selected_rows.count <= 1)
		local
			l_rows: like selected_rows
		do
			if has_selected_row then
				l_rows := selected_rows
				if l_rows.count = 1 then
					Result := l_rows.first
				end
			end
		end

	expand_all_rows (rec: BOOLEAN)
			-- Expand all expandable rows.
			-- if `rec' is True then do it recursively.
		require
			tree_enabled: is_tree_enabled
		local
			r: INTEGER
			l_row: EV_GRID_ROW
		do
			from
				r := 1
			until
				r > row_count
			loop
				l_row := row (r)
				if
					not l_row.is_destroyed and
					l_row.is_show_requested and -- not hidden
					l_row.is_expandable and
					not l_row.is_expanded
				then
					expand_row (l_row, rec)
				end
				r := r + 1
			end
		end

	collapse_all_rows (rec: BOOLEAN)
			-- Collapse all expandable rows.
			-- if `rec' is True then do it recursively.
		require
			tree_enabled: is_tree_enabled
		local
			r: INTEGER
			l_row: EV_GRID_ROW
		do
			from
				r := 1
			until
				r > row_count
			loop
				l_row := row (r)
				if
					not l_row.is_destroyed and
					l_row.is_show_requested and -- not hidden
					l_row.is_expandable and
					not l_row.is_expanded
				then
					collapse_row (l_row, rec)
				end
				r := r + 1
			end
		end

feature -- Delayed cleaning

	delayed_cleaning_exists: BOOLEAN
		do
			Result := delayed_cleaning /= Void
		end

	request_delayed_clean
		require
			delayed_cleaning_exists
		do
			if attached delayed_cleaning as d then
				d.request_call
			else
				check delayed_cleaning_attached: False end
			end
		end

	call_delayed_clean
		require
			delayed_cleaning_exists
		do
			if attached delayed_cleaning as d then
				d.call
			else
				check delayed_cleaning_attached: False end
			end
		end

	cancel_delayed_clean
		require
			delayed_cleaning_exists
		do
			if attached delayed_cleaning as d then
				d.cancel_request
			else
				check delayed_cleaning_attached: False end
			end
		end

	set_cleaning_delay (v: INTEGER)
		require
			v_positive_or_zero: v >= 0
		do
			cleaning_delay := v
			if attached delayed_cleaning as d then
				d.set_delay (cleaning_delay)
			end
		end

	build_delayed_cleaning
		local
			d: like delayed_cleaning
		do
			d := delayed_cleaning
			if d = Void then
				create d.make (
									agent default_clean,
									cleaning_delay
							)
				delayed_cleaning := d
				d.set_on_request_start_action (agent disable_sensitive)
				d.set_on_request_end_action (agent enable_sensitive)
			end
		end

	default_clean
		do
			remove_and_clear_all_rows
		end

	set_delayed_cleaning_action (v: PROCEDURE)
		require
			delayed_cleaning_exists
		do
			if attached delayed_cleaning as d then
				d.set_delayed_action (v)
			else
				check delayed_cleaning_attached: False end
			end
		end

feature -- Commands

	destroy
			-- Destroy underlying native toolkit object.
			-- Render `Current' unusable.
		do
			Precursor {EV_GRID}

			if attached delayed_columns_auto_resizing as dr then
				dr.destroy
				delayed_columns_auto_resizing := Void
			end
			if attached delayed_last_column_auto_resizing as dlr then
				dlr.destroy
				delayed_last_column_auto_resizing := Void
			end
			if attached delayed_cleaning as dc then
				dc.destroy
				delayed_cleaning := Void
			end
		end

feature {NONE} -- Implementation

	cleaning_delay: INTEGER

	delayed_cleaning: detachable ES_DELAYED_ACTION

feature {NONE} -- Actions

	on_row_expand (a_row: EV_GRID_ROW)
			-- Default handling when row is expanded
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			request_columns_auto_resizing
		end

	on_row_collapse (a_row: EV_GRID_ROW)
			-- Default handling when row is collapsed.
		require
			a_row /= Void
			row_related_to_current: a_row.parent = Current
		do
			request_columns_auto_resizing
		end

	on_expand_rows (a_recursive: BOOLEAN)
			-- Action to be performed when expanding rows.
		do
			if not a_recursive then
				if attached expand_selected_rows_agent as agt_e then
					agt_e.call (Void)
				end
			else
				if attached expand_selected_rows_recursive_agent as agt_er then
					agt_er.call (Void)
				end
			end
		end

	on_collapse_rows (a_recursive: BOOLEAN)
			-- Action to be performed when collapsing rows.
		do
			if not a_recursive then
				if attached collapse_selected_rows_agent as agt_c then
					agt_c.call (Void)
				end
			else
				if attached collapse_selected_rows_recursive_agent as agt_cr then
					agt_cr.call (Void)
				end
			end
		end

feature {NONE} -- Tree view behavior

	expand_row (a_row: EV_GRID_ROW; a_recursive: BOOLEAN)
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

	collapse_row (a_row: EV_GRID_ROW; a_recursive: BOOLEAN)
			-- Collapse `a_row'.
			-- If `a_recursive' is True, recursively collapse all subrows of `a_row'.
		require
			tree_enabled: is_tree_enabled
			a_row_parented: a_row.parent = Current
		local
			i, c: INTEGER
		do
			if
				not a_row.is_destroyed and then
				a_row.is_expandable and then
				a_row.is_expanded
			then
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

	expand_rows (a_recursive: BOOLEAN)
			-- Expand all rows returned by `selected_rows_function'.
			-- If `a_recursive' is True, expand those rows recursively.
		do
			if attached selected_rows_function.item (Void) as l_rows and then not l_rows.is_empty then
				if a_recursive then
					remove_unnecessary_rows (l_rows)
				end
				l_rows.do_all (agent expand_row (?, a_recursive))
			end
		end

	collapse_rows (a_recursive: BOOLEAN)
			-- Collapse all rows returned by `selected_rows_function'.
			-- If `a_recursive' is True, collapse those rows recursively.
		local
			l_rows: LIST [EV_GRID_ROW]
			l_first_row: EV_GRID_ROW
		do
			l_rows := selected_rows_function.item (Void)
			if l_rows /= Void and then not l_rows.is_empty then
				l_first_row := l_rows.first
				if l_rows.count = 1 and then (not l_first_row.is_expandable or else not l_first_row.is_expanded) then
					if attached l_first_row.parent_row as l_parent_row then
						l_first_row.disable_select
						if not l_parent_row.is_destroyed then
							if l_parent_row.is_selectable then
								l_parent_row.enable_select
							end
							if l_parent_row.is_displayed then
								l_parent_row.ensure_visible
							end
						end
					end
				else
					if a_recursive then
						remove_unnecessary_rows (l_rows)
					end
					l_rows.do_all (agent collapse_row (?, a_recursive))
				end
			end
		end

	remove_unnecessary_rows (a_rows: LIST [EV_GRID_ROW])
			-- Remove unnecessary rows in `a_rows' for recursive expansion or collapsion.
		require
			a_rows_attached: a_rows /= Void
		local
			l_row_tbl: HASH_TABLE [EV_GRID_ROW, INTEGER]
			l_parent_row: detachable EV_GRID_ROW
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

	selected_rows_in_grid: LIST [EV_GRID_ROW]
			-- Selected rows in Current
			-- If `is_single_row_selection_enabled' is True, return selected rows.
			-- If `is_single_item_selection_enabled' is True, return a list of rows in which some items are selected.
		local
			l_selected_items: like selected_items
			l_grid_row: EV_GRID_ROW
		do
			if is_single_row_selection_enabled or is_multiple_row_selection_enabled then
				Result := selected_rows
			else
				l_selected_items := selected_items
				create {LINKED_LIST [EV_GRID_ROW]} Result.make
				from
					l_selected_items.start
				until
					l_selected_items.after
				loop
					l_grid_row := l_selected_items.item.row
					if not Result.has (l_grid_row) then
						Result.extend (l_grid_row)
					end
					l_selected_items.forth
				end
			end
		ensure
			result_attached: Result /= Void
		end

invariant
	selected_rows_agent_attached: selected_rows_function /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
