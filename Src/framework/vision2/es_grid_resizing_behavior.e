note
	description: "Resize columns using vertical separator line, and header separators."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_RESIZING_BEHAVIOR

inherit
	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Resizing : initialization

	make (g: like grid)
			-- Initialize Current
		require
			g_attached: g /= Void
		do
			grid := g
			edge_size := 3
			create disabled_resize_columns.make (g.column_count)
			create header_resize_start_actions
			create header_resize_end_actions
		end

feature -- Properties

	edge_size: INTEGER
			-- Size of the column separator line

	grid: EV_GRID
			-- Associated EV_GRID

	resizing_column_enabled: BOOLEAN
			-- Allow to resize column using the column separator?

	disabled_resize_columns: ARRAYED_SET [INTEGER]
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
			disabled_resize_columns.extend (a_column)
		ensure
			disabled: disabled_resize_columns.has (a_column)
		end

	enable_resize_on_column (a_column: INTEGER)
			-- Enable resize for `a_column'.
		do
			disabled_resize_columns.prune (a_column)
		ensure
			enabled: not disabled_resize_columns.has (a_column)
		end

feature {NONE} -- Actions

	motion_resize_agent: detachable PROCEDURE [INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
	press_resize_agent, release_resize_agent: detachable PROCEDURE [INTEGER, INTEGER, INTEGER, DOUBLE, DOUBLE, DOUBLE, INTEGER, INTEGER]
	leave_resize_agent: detachable PROCEDURE

	set_grid_separator_resizer (a_enabling: BOOLEAN)
		local
			g: like grid
			l_motion_act: like motion_resize_agent
			l_pointer_act: like press_resize_agent
			l_leave_act: like leave_resize_agent
		do
			g := grid
			if a_enabling then
				if release_resize_agent = Void then
					release_resize_agent := agent release_resize
				end
				if leave_resize_agent = Void then
					leave_resize_agent := agent leave_resize
				end
				if motion_resize_agent = Void then
					l_motion_act := agent motion_resize
					motion_resize_agent := l_motion_act
					g.pointer_motion_actions.extend (l_motion_act)
				end
				if press_resize_agent = Void then
					l_pointer_act := agent press_resize
					press_resize_agent := l_pointer_act
					g.pointer_button_press_actions.extend (l_pointer_act)
				end
			else
				l_motion_act := motion_resize_agent
				if l_motion_act /= Void then
					g.pointer_motion_actions.prune_all (l_motion_act)
					motion_resize_agent := Void
				end
				l_pointer_act := press_resize_agent
				if l_pointer_act /= Void then
					g.pointer_button_press_actions.prune_all (l_pointer_act)
					press_resize_agent := Void
				end
				l_pointer_act := release_resize_agent
				if l_pointer_act /= Void then
					g.pointer_button_release_actions.prune_all (l_pointer_act)
					release_resize_agent := Void
				end
				l_leave_act := leave_resize_agent
				if l_leave_act /= Void then
					g.pointer_leave_actions.prune_all (l_leave_act)
					leave_resize_agent := Void
				end
			end
		end

	motion_resize (x_pos, y_pos: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; x_screen, y_screen: INTEGER)
			-- Check if we reach a border and should enable column resizing.
		local
			g: like grid
			start_x: INTEGER
			column_index: INTEGER
			l_near_border: BOOLEAN
			l_new_width, l_new_neighbor, l_x_pos: INTEGER
			l_resize, l_neighbor: detachable EV_GRID_COLUMN
			over_grid_content: BOOLEAN
			l_visible_height: INTEGER
			h,vscroll,hscroll: EV_WIDGET
		do
			g := grid
			if resizing_column_enabled and then g.activated_item = Void then
				l_x_pos := x_pos + g.virtual_x_position
				vscroll := g.vertical_scroll_bar
				hscroll := g.horizontal_scroll_bar
				over_grid_content := True
				if g.is_header_displayed then
					h := g.header
					if h /= Void then
						over_grid_content := (y_screen > (h.screen_y + h.height))
					end
				end
				over_grid_content := over_grid_content and
						(vscroll = Void or else x_screen < vscroll.screen_x) and
						(hscroll = Void or else y_screen < hscroll.screen_y)
				if over_grid_content then
					if not is_resize_mode then
						l_visible_height := g.viewable_height
						if g.is_header_displayed then
							 l_visible_height := l_visible_height + grid.header.height
						end

						if l_x_pos >= 0 and l_x_pos < g.virtual_width then
							l_resize := g.column_at_virtual_position (l_x_pos)
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
							g.set_pointer_style (Stock_cursors.sizewe_cursor)
							resize_index := column_index
						elseif is_near_border and not l_near_border then
							is_near_border := False
							g.set_pointer_style (Stock_cursors.standard_cursor)
						end
					else
						l_resize := g.column (resize_index)
						l_neighbor := g.column (resize_index + 1)
						l_new_width := l_x_pos - l_resize.virtual_x_position
						l_new_neighbor := l_neighbor.virtual_x_position + l_neighbor.width - l_x_pos
						if l_new_width > edge_size and l_new_neighbor > edge_size then
							l_resize.set_width (l_new_width.max (l_resize.minimum_width))
							l_neighbor.set_width (l_new_neighbor.max (l_neighbor.minimum_width))
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

	clicked_item: detachable EV_GRID_ITEM

	start_resizing (x_pos, y_pos: INTEGER_32)
		local
			vx,vy: INTEGER_32
			hi: detachable EV_HEADER_ITEM
			i: like clicked_item
			g: like grid
		do
			is_resize_mode := True
			g := grid

			vx := g.virtual_x_position + x_pos
			vy := g.virtual_y_position + y_pos
			if
				vx >= 0 and vx <= g.virtual_width
				and vy >= 0 and vy <= g.virtual_height
			then
				i := g.item_at_virtual_position (vx, vy)
				clicked_item := i
				if i /= Void then
					i.pointer_button_press_actions.block
				end
			end

			g.pointer_button_press_item_actions.block
			g.pointer_button_press_actions.block
			if attached release_resize_agent as agt_r then
				g.pointer_button_release_actions.extend (agt_r)
			end
			if attached leave_resize_agent as agt_l then
				g.pointer_leave_actions.extend (agt_l)
			end

			if resize_index > 0 and resize_index < g.header.count then
				hi := g.header.i_th (resize_index)
			end
			if hi /= Void then
				header_resize_start_actions.call ([hi])
			end
		end

	end_resizing
		local
			g: like grid
			i: like resize_index
		do
			g := grid
			if attached release_resize_agent as agt_r then
				g.pointer_button_release_actions.prune_all (agt_r)
			end
			if attached leave_resize_agent as agt_l then
				g.pointer_leave_actions.prune_all (agt_l)
			end

			if attached clicked_item as l_clicked_item then
				l_clicked_item.pointer_button_press_actions.resume
				clicked_item := Void
			end
			g.pointer_button_press_item_actions.resume
			g.pointer_button_press_actions.resume
			is_resize_mode := False

			i := resize_index
			if i >= 1 and i < g.header.count then
				if attached g.header.i_th (i) as hi then
					header_resize_end_actions.call ([hi])
				end
			end
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
	grid_attached: grid /= Void
	disabled_resize_columns_not_void: disabled_resize_columns /= Void
	header_resize_start_actions_attached: header_resize_start_actions /= Void
	header_resize_end_actions_attached: header_resize_end_actions /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
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
