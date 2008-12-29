note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_RESIZING_BEHAVIOR

inherit
	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Resizing : initialization

	make (g: EV_GRID)
		do
			grid := g
			edge_size := 3
			create disabled_resize_columns.make_default
			create header_resize_start_actions
			create header_resize_end_actions
		end

feature -- Properties

	edge_size: INTEGER

	grid: EV_GRID

	resizing_column_enabled: BOOLEAN

	disabled_resize_columns: DS_HASH_SET [INTEGER]
			-- Columns that don't allow resizing.

	header_resize_start_actions: ACTION_SEQUENCE [TUPLE [EV_HEADER_ITEM]]
			-- Actions to be performed when resize starts

	header_resize_end_actions: ACTION_SEQUENCE [TUPLE [EV_HEADER_ITEM]]
			-- Actions to be performed when resize ends

feature -- Change

	disable_column_resizing
		do
			resizing_column_enabled := False
			if not resizing_column_enabled then
				set_grid_separator_resizer (False)
			end
		end

	enable_column_resizing
		do
			if not resizing_column_enabled then
				set_grid_separator_resizer (True)
			end
			resizing_column_enabled := True
		end

	disable_resize_on_column (a_column: INTEGER)
			-- Disable resize for `a_column'.
		do
			disabled_resize_columns.force (a_column)
		ensure
			disabled: disabled_resize_columns.has (a_column)
		end

	enable_resize_on_column (a_column: INTEGER)
			-- Enable resize for `a_column'.
		do
			disabled_resize_columns.remove (a_column)
		ensure
			enabled: not disabled_resize_columns.has (a_column)
		end

feature {NONE} -- Actions

	motion_resize_agent:   PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
	press_resize_agent, release_resize_agent:   PROCEDURE [ANY, TUPLE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]]
	leave_resize_agent:   PROCEDURE [ANY, TUPLE]

	set_grid_separator_resizer (a_enabling: BOOLEAN)
		do
			if a_enabling then
				if release_resize_agent = Void then
					release_resize_agent := agent release_resize
				end
				if leave_resize_agent = Void then
					leave_resize_agent := agent leave_resize
				end
				if motion_resize_agent = Void then
					motion_resize_agent := agent motion_resize
					grid.pointer_motion_actions.extend (motion_resize_agent)
				end
				if press_resize_agent = Void then
					press_resize_agent := agent press_resize
					grid.pointer_button_press_actions.extend (press_resize_agent)
				end
			else
				if motion_resize_agent /= Void then
					grid.pointer_motion_actions.prune_all (motion_resize_agent)
					motion_resize_agent := Void
				end
				if press_resize_agent /= Void then
					grid.pointer_button_press_actions.prune_all (press_resize_agent)
					press_resize_agent := Void
				end
				if release_resize_agent /= Void then
					grid.pointer_button_release_actions.prune_all (release_resize_agent)
					release_resize_agent := Void
				end
				if leave_resize_agent /= Void then
					grid.pointer_leave_actions.prune_all (leave_resize_agent)
					leave_resize_agent := Void
				end
			end
		end

	screen: EV_SCREEN
			-- Once access to EV_SCREEN object.
		once
			create Result
		end

	motion_resize (x_pos, y_pos: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; x_screen, y_screen: INTEGER)
			-- Check if we reach a border and should enable column resizing.
		local
			start_x: INTEGER
			column_index: INTEGER
			l_near_border: BOOLEAN
			l_new_width, l_new_neighbor, l_x_pos: INTEGER
			l_resize, l_neighbor: EV_GRID_COLUMN
			over_grid_content: BOOLEAN
			l_draw: EV_DRAWING_AREA
			l_visible_height: INTEGER
		do
			if resizing_column_enabled and then grid.activated_item = Void then
				l_x_pos := x_pos + grid.virtual_x_position
				l_draw ?= Screen.widget_at_mouse_pointer
				over_grid_content := l_draw /= Void
				if over_grid_content then
					if not is_resize_mode then
						l_visible_height := grid.viewable_height
						if grid.is_header_displayed then
							 l_visible_height := l_visible_height + grid.header.height
						end

						if l_x_pos >= 0 and l_x_pos < grid.virtual_width then
							l_resize := grid.column_at_virtual_position (l_x_pos)
						end
						if l_resize /= Void and then (y_pos < l_visible_height) then
							column_index := l_resize.index
							start_x := l_resize.virtual_x_position
							if column_index > 1 and then l_x_pos < start_x + edge_size then
								column_index := column_index - 1
								l_near_border := True
							elseif column_index < grid.column_count and then l_x_pos > start_x + l_resize.width - edge_size  then
								l_near_border := True
							end
						end
						if
							not is_near_border and l_near_border
							and not (
								disabled_resize_columns.has (column_index)
								or disabled_resize_columns.has (column_index + 1)
								) then
							is_near_border := True
							grid.set_pointer_style (Stock_cursors.sizewe_cursor)
							resize_index := column_index
						elseif is_near_border and not l_near_border then
							is_near_border := False
							grid.set_pointer_style (Stock_cursors.standard_cursor)
						end
					else
						l_resize := grid.column (resize_index)
						l_neighbor := grid.column (resize_index + 1)
						l_new_width := l_x_pos - l_resize.virtual_x_position
						l_new_neighbor := l_neighbor.virtual_x_position + l_neighbor.width - l_x_pos
						if l_new_width > edge_size and l_new_neighbor > edge_size then
							l_resize.set_width (l_new_width)
							l_neighbor.set_width (l_new_neighbor)
						end
					end
				else
					if is_resize_mode then
						end_resizing
					end
				end
			end
		end

	press_resize (x_pos, y_pos, a_button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; x_screen, y_screen: INTEGER)
			-- If we are near a resizable border, enable column resizing moveing.
		do
			if is_near_border and a_button = 1 then
				start_resizing (x_pos, y_pos)
			end
		end

	release_resize (x_pos, y_pos, a_button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; x_screen, y_screen: INTEGER)
			-- If we were in `is_resize_mode' we loose the mode.
		do
			end_resizing
		end

	leave_resize
			-- If we were in `is_resize_mode' we loose the mode.
		do
			end_resizing
		end

	clicked_item: EV_GRID_ITEM

	start_resizing (x_pos, y_pos: INTEGER_32)
		local
			vx,vy: INTEGER_32
			l_header: EV_HEADER_ITEM
		do
			is_resize_mode := True

			vx := grid.virtual_x_position + x_pos
			vy := grid.virtual_y_position + y_pos
			if
				vx >= 0 and vx <= grid.virtual_width
				and vy >= 0 and vy <= grid.virtual_height
			then
				clicked_item := grid.item_at_virtual_position (vx, vy)
				if clicked_item /= Void then
					clicked_item.pointer_button_press_actions.block
				end
			end

			grid.pointer_button_press_item_actions.block
			grid.pointer_button_press_actions.block
			grid.pointer_button_release_actions.extend (release_resize_agent)
			grid.pointer_leave_actions.extend (leave_resize_agent)

			if resize_index > 0 and resize_index < grid.header.count then
				l_header := grid.header.i_th (resize_index)
			end
			header_resize_start_actions.call ([l_header])
		end

	end_resizing
		local
			l_header: EV_HEADER_ITEM
		do
			grid.pointer_button_release_actions.prune_all (release_resize_agent)
			grid.pointer_leave_actions.prune_all (leave_resize_agent)
			if clicked_item /= Void then
				clicked_item.pointer_button_press_actions.resume
				clicked_item := Void
			end
			grid.pointer_button_press_item_actions.resume
			grid.pointer_button_press_actions.resume
			is_resize_mode := False

			if resize_index > 0 and resize_index < grid.header.count then
				l_header := grid.header.i_th (resize_index)
			end
			header_resize_end_actions.call ([l_header])
		end

feature -- Status

	is_resize_mode: BOOLEAN
			-- Are we in resize mode?

feature {NONE} -- Implementation

	is_near_border: BOOLEAN
			-- Are we near a border, that we can resize?

	resize_index: INTEGER
			-- Column to resize.

	Stock_cursors: EV_STOCK_PIXMAPS
		once
			create {EV_STOCK_PIXMAPS} Result
		end

invariant
	disabled_resize_columns_not_void: disabled_resize_columns /= Void
	header_resize_start_actions_attached: header_resize_start_actions /= Void
	header_resize_end_actions_attached: header_resize_end_actions /= Void

note
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
