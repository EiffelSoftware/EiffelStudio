indexing
	description: "[
		EV_GRID support class to process default user interface interfactions, such as wheel mouse,
		page up/down and expanding trees with left and right cursor keys.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DEFAULT_UI_PROCESSOR

inherit
	ANY
	
	EV_KEY_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end	
		
	EV_SHARED_APPLICATION
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
		end	

create
	make

feature {NONE} -- Initialization

	make (a_grid: EV_GRID) is
			-- Create and initialize a `EV_GRID' default user interface processor
		require
			a_grid_not_void: a_grid /= Void
		do
			a_grid.mouse_wheel_actions.extend (agent on_grid_mouse_wheel_recieved (a_grid, ?))
			a_grid.key_release_actions.extend (agent on_grid_key_released (a_grid, ?))
			a_grid.key_press_actions.extend (agent on_grid_key_pressed (a_grid, ?))
			a_grid.row_select_actions.extend (agent on_grid_row_selected)
		end

feature {NONE} -- Agent Handlers

	on_grid_mouse_wheel_recieved (a_grid: EV_GRID; a_delta: INTEGER) is
			-- Called when user scrolls `grid_output' using the mouse wheel
		local
			l_move_by: INTEGER
		do
			l_move_by := (- a_delta) * 5			
			a_grid.set_virtual_position (a_grid.virtual_x_position, (a_grid.virtual_y_position + (a_grid.row_height * l_move_by)).min (a_grid.maximum_virtual_y_position).max (0))
		end

	on_grid_key_released (a_grid: EV_GRID; a_key: EV_KEY) is
			-- Called when user releases a key when output gird has focus.
		require
			a_grid_not_void: a_grid /= Void
			a_key_not_void: a_key /= Void
		do
			inspect a_key.code
					
			when key_left, key_numpad_subtract then
				on_shift_selection_left (a_grid)
			when key_right, key_numpad_add, key_numpad_multiply then
				on_shift_selection_right (a_grid)
			when key_home then
				if ev_application.ctrl_pressed then
					on_ctrl_home (a_grid)
				end
			when key_end then
				if ev_application.ctrl_pressed then
					on_ctrl_end (a_grid)
				end
			when key_a then
				if ev_application.ctrl_pressed then
					on_select_all (a_grid)
				end
			else
				--| Do nothing...	
			end
		end
		
	on_grid_key_pressed (a_grid: EV_GRID; a_key: EV_KEY) is
			-- Called when user presses a key when output gird has focus.
		require
			a_grid_not_void: a_grid /= Void
			a_key_not_void: a_key /= Void
		do
			inspect a_key.code
			
			when key_page_up then
				on_page_up (a_grid)
			when key_page_down then
				on_page_down (a_grid)
			else
				--| Do nothing...
			end
		end
		
	on_grid_row_selected (a_row: EV_GRID_ROW) is
			-- Called when a grid row has been selected
		require
			a_row_not_void: a_row /= Void
		do
			last_selected_row := a_row
		end
		
feature {NONE} -- Implementation

	on_shift_selection_left (a_grid: EV_GRID) is
			-- Preform a left shift selection.
		require
			a_grid_not_void: a_grid /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
		do			
			l_rows := a_grid.selected_rows
			if l_rows.count = 1 then
				l_row := l_rows[1]
				if l_row.is_expandable and then l_row.is_expanded then
					l_row.collapse
				elseif l_row.parent_row /= Void then
					l_row.disable_select
					l_row := l_row.parent_row
					l_row.enable_select
				end
				l_row.ensure_visible
			end
		end
		
	on_shift_selection_right (a_grid: EV_GRID) is
			-- Preform a right shift selection.
		require
			a_grid_not_void: a_grid /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW			
		do			
			l_rows := a_grid.selected_rows
			if l_rows.count = 1 then
				l_row := l_rows[1]
				if l_row.is_expandable and then not l_row.is_expanded then
					l_row.expand
				elseif l_row.subrow_count > 0 then
					l_row.disable_select
					l_row := l_row.subrow (1)
					l_row.enable_select
				end
				l_row.ensure_visible
			end
		end

	on_ctrl_home (a_grid: EV_GRID) is
			-- Performed when a select all is selected (CTRL+HOME)
		require
			a_grid_not_void: a_grid /= Void
			last_selected_row_not_void: last_selected_row /= Void
		local
			l_row: EV_GRID_ROW
			l_last_row: like last_selected_row
			l_count: INTEGER
		do
			l_count	:= a_grid.row_count
			
			if l_count > 0 then
				l_row := a_grid.row (1)
				if a_grid.is_multiple_row_selection_enabled and ev_application.shift_pressed then
					l_last_row := last_selected_row
					select_range (a_grid, 1, l_last_row.index)
					l_last_row.disable_select
					l_last_row.enable_select
				else
					deselect_all (a_grid)
					l_row.enable_select
				end
				l_row.ensure_visible
			end
		end

	on_ctrl_end (a_grid: EV_GRID) is
			-- Performed when a select all is selected (CTRL+END)
		require
			a_grid_not_void: a_grid /= Void
			last_selected_row_not_void: last_selected_row /= Void
		local
			l_row: EV_GRID_ROW
			l_last_row: like last_selected_row
			l_count: INTEGER	
		do
			l_count	:= a_grid.row_count
			
			if l_count > 0 then
				l_row := a_grid.row (a_grid.row_count)
				if l_row.parent_row /= Void then
					if not l_row.parent_row_root.is_expanded then
						l_row := l_row.parent_row_root	
					end
				end
				if a_grid.is_multiple_row_selection_enabled and ev_application.shift_pressed then
					l_last_row := last_selected_row
					select_range (a_grid, l_last_row.index, l_count)
					l_last_row.disable_select
					l_last_row.enable_select
				else
					deselect_all (a_grid)
					l_row.enable_select
				end
				l_row.ensure_visible	
			end
		end

	on_select_all (a_grid: EV_GRID) is
			-- Performed when a select all is selected (CTRL+A)
		require
			a_grid_not_void: a_grid /= Void
			last_selected_row_not_void: last_selected_row /= Void
		do
			select_range (a_grid, 1, a_grid.row_count)
		end
		
	on_page_up (a_grid: EV_GRID) is
			-- Perform a page up selection
		require
			a_grid_not_void: a_grid /= Void
			last_selected_row_not_void: last_selected_row /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			l_rows := a_grid.selected_rows
			if l_rows.count > 0 then
				i := (last_selected_row.index - (a_grid.visible_row_indexes.count - 1)).max (1)
				l_row := l_rows[1]
				l_row.disable_select
				l_row := a_grid.row (i)
				l_row.enable_select
				l_row.ensure_visible
			end
		end

	on_page_down (a_grid: EV_GRID) is
			-- Perform a page down selection
		require
			a_grid_not_void: a_grid /= Void
			last_selected_row_not_void: last_selected_row /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_expanded_count: INTEGER
			i: INTEGER
		do
			l_rows := a_grid.selected_rows
			if l_rows.count > 0 then
				
				l_row := a_grid.row (a_grid.row_count)
				if l_row.parent_row /= Void then
					if not l_row.parent_row_root.is_expanded then
						l_row := l_row.parent_row_root	
					end
				end
				l_expanded_count := l_row.index
				i := (last_selected_row.index + (a_grid.visible_row_indexes.count - 1)).min (l_expanded_count)
				l_row := l_rows[1]
				l_row.disable_select
				l_row := a_grid.row (i)
				l_row.enable_select
				l_row.ensure_visible
			end
		end
			
	select_range (a_grid: EV_GRID; a_start: INTEGER a_end: INTEGER) is
			-- Selected a range of items from `a_start' to `a_end' in `a_grid'
		require
			a_grid_not_void: a_grid /= Void
			a_start_positive: a_start > 0
			a_end_greater_than_a_start: a_end >= a_start
			a_end_in_range: a_end <= a_grid.row_count
			a_grid_has_multiple_selection: a_grid.is_multiple_row_selection_enabled
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_count: INTEGER
			i: INTEGER
		do
			l_rows := a_grid.selected_rows
			l_count := l_rows.count
			if l_rows.count > 0 then
				a_grid.lock_update
				deselect_all (a_grid)
				if a_start < a_end then
					from
						i := a_start
					until
						i > a_end
					loop
						l_row := a_grid.row (i)
						l_row.enable_select	
						i := i + 1
					end
				else
					l_row := a_grid.row (a_start)
					l_row.enable_select
				end
				a_grid.unlock_update
			end
		ensure
			range_selected: a_grid.selected_rows.count = (a_end - a_start) + 1
		end
		
	deselect_all (a_grid: EV_GRID) is
			-- Deselects all items
		require
			a_grid_not_void: a_grid /= Void
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			l_count: INTEGER
			i: INTEGER
		do
			l_rows := a_grid.selected_rows
			l_count := l_rows.count
			if l_count > 0 then
					-- Deselect items
				from
					i := 1
				until
					i > l_count
				loop
					l_row := l_rows[i]
					l_row.disable_select
					i := i + 1
				end
			end
		ensure
			selected_count_is_zero: a_grid.selected_rows.count = 0	
		end

	last_selected_row: EV_GRID_ROW;
			-- Last selected row

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
end -- class EV_GRID_DEFAULT_UI_PROCESSOR
