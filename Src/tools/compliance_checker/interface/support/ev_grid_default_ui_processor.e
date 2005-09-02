indexing
	description: "[
		EV_GRID support class to process default user interface interfactions, such as wheel mouse,
		page up/down and expanding trees with left and right cursor keys.
	]"
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
			a_grid_is_single_row_selection_enabled: a_grid.is_single_row_selection_enabled
		do
			a_grid.mouse_wheel_actions.extend (agent on_grid_mouse_wheel_recieved (a_grid, ?))
			a_grid.key_release_actions.extend (agent on_grid_key_released (a_grid, ?))
			a_grid.key_press_actions.extend (agent on_grid_key_pressed (a_grid, ?))
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
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
		do
			inspect a_key.code
					
			when key_left, key_numpad_subtract then
				l_rows := a_grid.selected_rows
				if l_rows.count > 0 then
					l_row := l_rows[1]
					if l_row.is_expanded then
						l_row.collapse
					elseif l_row.parent_row /= Void then
						l_row.disable_select
						l_row := l_row.parent_row
						l_row.enable_select
					end
					l_row.ensure_visible
				end
			when key_right, key_numpad_add, key_numpad_multiply then
				l_rows := a_grid.selected_rows
				if l_rows.count > 0 then
					l_row := l_rows[1]
					if not l_row.is_expanded and l_row.is_expandable then
						l_row.expand
					elseif l_row.subrow_count > 0 then
						l_row.disable_select
						l_row := l_row.subrow (1)
						l_row.enable_select
					end
					l_row.ensure_visible
				end
			when key_home then
				if ev_application.ctrl_pressed then
					l_rows := a_grid.selected_rows
					if l_rows.count > 0 then
						(l_rows[1]).disable_select
						l_row := a_grid.row (1)
						l_row.enable_select
						l_row.ensure_visible
					end
				end
			when key_end then
				if ev_application.ctrl_pressed then
					l_rows := a_grid.selected_rows
					if l_rows.count > 0 then
						(l_rows[1]).disable_select
						l_row := a_grid.row (a_grid.row_count)
						if l_row.parent_row /= Void then
							if not l_row.parent_row_root.is_expanded then
								l_row := l_row.parent_row_root	
							end
						end
						l_row.enable_select
						l_row.ensure_visible
					end
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
		local
			l_rows: ARRAY [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			i: INTEGER
		do
			inspect a_key.code
			
			when key_page_up then
				l_rows := a_grid.selected_rows
				if l_rows.count > 0 then
					l_row := l_rows[1]
					i := l_row.index
					if i > 1 then
						l_row.disable_select
						i := (l_row.index - (a_grid.visible_row_indexes.count - 1)).max (1)
						l_row := a_grid.row (i)
						l_row.enable_select
					end
					l_row.ensure_visible
				end
			when key_page_down then
				l_rows := a_grid.selected_rows
				if l_rows.count > 0 then
					l_row := l_rows[1]
					i := l_row.index
					if i < a_grid.row_count then
						l_row.disable_select
						i := (l_row.index + (a_grid.visible_row_indexes.count - 1)).min (a_grid.row_count)
						l_row := a_grid.row (i)
						l_row.enable_select
					end
					l_row.ensure_visible
				end
			else
				--| Do nothing...
			end
		end

end -- class EV_GRID_DEFAULT_UI_PROCESSOR
