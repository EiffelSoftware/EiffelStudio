note
	description: "Objects that implemente the scrolling behavior of a GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRID_SCROLLING_BEHAVIOR

inherit

	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Scrolling : initialization

	make (g: EV_GRID)
		do
			grid := g
			mouse_wheel_scroll_size := 3 --| default value
			enable_mouse_wheel
		end

	grid: EV_GRID

feature -- Status

	mouse_wheel_enabled: BOOLEAN
			-- Is mouse wheel enable ?

feature -- Properties

	mouse_wheel_scroll_size: INTEGER
			-- Number of rows to scroll if we are not on a page by page scrolling.

	mouse_wheel_scroll_full_page: BOOLEAN
			-- Should we scroll by page rather by a fixed amount of rows?

	scrolling_common_line_count: INTEGER
			-- On a page by page scrolling, number of rows that will be common
			-- between the two pages.

feature -- change

	enable_mouse_wheel
		require
			mouse_wheel_disabled: not mouse_wheel_enabled
		local
			l_on_mouse_wheel_action_agent: like on_mouse_wheel_action_agent
		do
			l_on_mouse_wheel_action_agent := on_mouse_wheel_action_agent
			if l_on_mouse_wheel_action_agent = Void then
				l_on_mouse_wheel_action_agent := agent on_mouse_wheel_action
				on_mouse_wheel_action_agent := l_on_mouse_wheel_action_agent
			end
			grid.mouse_wheel_actions.extend (l_on_mouse_wheel_action_agent)
			mouse_wheel_enabled := True
		end

	disable_mouse_wheel
		require
			mouse_wheel_enabled: mouse_wheel_enabled
		do
			if attached on_mouse_wheel_action_agent as agt then
				grid.mouse_wheel_actions.prune_all (agt)
			end
			mouse_wheel_enabled := False
		end

	set_mouse_wheel_scroll_full_page (v: BOOLEAN)
			-- Set the mouse wheel scroll page mode
		do
			mouse_wheel_scroll_full_page := v
		ensure
			mouse_wheel_scroll_full_page_set: mouse_wheel_scroll_full_page = v
		end

	set_mouse_wheel_scroll_size (v: like mouse_wheel_scroll_size)
			-- Set the mouse wheel scroll size
		require
			v_positive: v > 0
		do
			mouse_wheel_scroll_size	:= v
		ensure
			mouse_wheel_scroll_size_set: mouse_wheel_scroll_size = v
		end

	set_scrolling_common_line_count (v: like scrolling_common_line_count)
			-- Set `scrolling_common_line_count' with `v'.
		do
			scrolling_common_line_count := v
		ensure
			scrolling_common_line_count_set: scrolling_common_line_count = v
		end

feature -- Scrolling

	scroll_to_top
			-- Scroll to top
		local
			g: EV_GRID
		do
			g := grid
			if g.is_displayed then
				g.set_virtual_position (g.virtual_x_position, 0)
			end
		end

	scroll_to_end
			-- Scroll to end
		local
			g: EV_GRID
		do
			g := grid
			if g.is_displayed then
				g.set_virtual_position (g.virtual_x_position, g.maximum_virtual_y_position)
			end
		end

	scroll_page (a_step: INTEGER)
			-- Scroll `a_step' pages
		do
			scroll_rows (a_step, True)
		end

	scroll_rows (a_step: INTEGER; is_full_page_scrolling: BOOLEAN)
			-- Scroll `a_step' rows
			-- or `a_step' page if `is_full_page_scrolling' is True
		local
			vy_now, vy, l_visible_count: INTEGER
			l_visible_rows: ARRAYED_LIST [INTEGER]
			l_viewable_row_indexes: ARRAYED_LIST [INTEGER]
			l_first_row: EV_GRID_ROW
			g: EV_GRID
		do
			g := grid
			if g.is_displayed then
				l_visible_rows := g.visible_row_indexes
				if l_visible_rows.is_empty then
						-- Nothing to be done, since no rows are visible
				else
					vy_now := g.virtual_y_position
					if is_full_page_scrolling then
						if g.is_tree_enabled then
							l_viewable_row_indexes := g.viewable_row_indexes
						else
							l_viewable_row_indexes := g.visible_row_indexes
						end

						if a_step < 0 then
								-- We are scrolling down.
							if scrolling_common_line_count < l_visible_rows.count then
								if l_visible_rows.count - scrolling_common_line_count > 1 then
									vy := g.row (l_visible_rows.i_th (l_visible_rows.count - scrolling_common_line_count)).virtual_y_position
								else
									l_viewable_row_indexes.start
									l_viewable_row_indexes.search (l_visible_rows.first)
									l_viewable_row_indexes.move (1)
									if not l_viewable_row_indexes.exhausted then
										vy := g.row (l_viewable_row_indexes.item).virtual_y_position
									else
										vy := g.row (l_viewable_row_indexes.last).virtual_y_position
									end
								end
							else
									-- Do nothing.
									-- Cannot go below, go to the last element.
								vy := g.row (l_viewable_row_indexes.last).virtual_y_position
							end
						else
								-- We are scrolling up
							if l_viewable_row_indexes /= Void then
								if g.is_row_height_fixed then
									l_visible_count := g.viewable_height // g.row_height - scrolling_common_line_count
								else
									l_visible_count := (visible_row_count (l_visible_rows) - scrolling_common_line_count).max (1)
								end
								l_first_row := g.row (l_visible_rows.first)
								l_viewable_row_indexes.start
								l_viewable_row_indexes.search (l_first_row.index)
								if not l_viewable_row_indexes.exhausted then
									if l_visible_count < l_viewable_row_indexes.item then
											-- Fixme: Doesn't take row with 0 height into consideration. (Jason)
										vy := g.row (l_viewable_row_indexes.item - l_visible_count).virtual_y_position
									else
											-- We reached the top.
										vy := 0
									end
								else
										-- We could not find the item. This is not right.
									if g.is_row_height_fixed then
										vy := vy_now - a_step * l_visible_count * g.row_height
									else
										vy := vy_now - g.viewable_height
									end
								end
							else
								check l_viewable_row_indexes_attached: False end
									-- We could not use `visible_indexes_to_row_indexes' to get the right
									-- information. Use an approximation that only works when there is no
									-- tree in the grid.
								if g.is_row_height_fixed then
									vy := vy_now - a_step * l_visible_count * g.row_height
								else
									vy := vy_now - g.viewable_height
								end
							end
						end
					else
						if a_step < 0 then
								-- We are scrolling down.
							if mouse_wheel_scroll_size < l_visible_rows.count then
								vy := g.row (l_visible_rows.i_th (mouse_wheel_scroll_size + 1)).virtual_y_position
							else
								if g.is_tree_enabled then
									l_viewable_row_indexes := g.viewable_row_indexes
								else
									l_viewable_row_indexes := g.visible_row_indexes
								end

								l_first_row := g.row (l_visible_rows.first)
								l_viewable_row_indexes.start
								l_viewable_row_indexes.search (l_first_row.index)
								l_viewable_row_indexes.move (mouse_wheel_scroll_size)
								if not l_viewable_row_indexes.exhausted then
									vy := g.row (l_viewable_row_indexes.item).virtual_y_position
								else
										-- Do nothing.
									vy := g.row (l_viewable_row_indexes.last).virtual_y_position
								end
							end
						else
								-- We are scrolling up
							if g.is_tree_enabled then
								l_viewable_row_indexes := g.viewable_row_indexes
							else
								l_viewable_row_indexes := g.visible_row_indexes
							end

							if l_viewable_row_indexes /= Void then
								l_first_row := g.row (l_visible_rows.first)
								l_viewable_row_indexes.start
								l_viewable_row_indexes.search (l_first_row.index)
								if not l_viewable_row_indexes.exhausted then
									if mouse_wheel_scroll_size < l_viewable_row_indexes.item then
										vy := g.row (l_viewable_row_indexes.item - mouse_wheel_scroll_size).virtual_y_position
									else
											-- We reached the top.
										vy := 0
									end
								else
										-- We could not find the item. This is not right.
									if g.is_row_height_fixed then
										vy := vy_now - a_step * mouse_wheel_scroll_size * g.row_height
									else
										vy := vy_now - a_step * mouse_wheel_scroll_size * average_row_height (l_visible_rows)
									end
								end
							else
								check l_viewable_row_indexes_attached: False end
									-- We could not use `visible_indexes_to_row_indexes' to get the right
									-- information. Use an approximation that only works when there is no
									-- tree in the grid.
								if g.is_row_height_fixed then
									vy := vy_now - a_step * mouse_wheel_scroll_size * g.row_height
								else
									vy := vy_now - a_step * mouse_wheel_scroll_size * average_row_height (l_visible_rows)
								end
							end
						end
					end
						-- Code below do the adjustment to the type of scrolling decided by user.
					if vy_now /= vy then
						if vy < 0 then
							vy := 0
						else
							vy := vy.min (g.maximum_virtual_y_position)
						end
						g.set_virtual_position (g.virtual_x_position, vy)
					end
				end
			end
		end

feature {NONE} -- Scrolling : Action implementation

	on_mouse_wheel_action_agent: detachable PROCEDURE [INTEGER]
			-- Agent representing `agent on_mouse_wheel_action' .

	on_mouse_wheel_action (a_step: INTEGER)
			-- Action called on mouse wheel event
		do
			scroll_rows (a_step, mouse_wheel_scroll_full_page or ev_application.ctrl_pressed)
		end

feature{NONE} -- Implementation

	visible_row_count (a_visible_rows: LIST [INTEGER]): INTEGER
			-- Number of visible rows whose indexes are stored in `a_visible_rows'.
			-- Used in case when rows are of different height and rows of 0-height are not taken into consideration.
		require
			a_visible_rows_attached: a_visible_rows /= Void
		local
			g: like grid
			l_cursor: CURSOR
			l_height: INTEGER
			l_row_height: INTEGER
			l_grid_row: EV_GRID_ROW
			l_visible_height: INTEGER
		do
			g := grid
			l_visible_height := g.viewable_height
			l_cursor := a_visible_rows.cursor
			from
				a_visible_rows.start
			until
				a_visible_rows.after or l_height > l_visible_height
			loop
				l_grid_row := g.row (a_visible_rows.item)
				l_row_height := l_grid_row.height
				if l_row_height > 0 and then l_height + l_row_height <= l_visible_height then
					Result := Result + 1
				end
				l_height := l_height + l_grid_row.height
				a_visible_rows.forth
			end
			a_visible_rows.go_to (l_cursor)
		end

	average_row_height (a_row_list: LIST [INTEGER]): INTEGER
			-- Average height of rows whose indexes are stored in `a_row_list'
			-- Rows of 0-height are not taken into consideration.
		require
			a_row_list_attached: a_row_list /= Void
		local
			l_row_count: INTEGER
			l_height: INTEGER
			l_cursor: CURSOR
			l_grid_row: EV_GRID_ROW
			l_grid: like grid
			l_row_height: INTEGER
		do
			l_grid := grid
			l_cursor := a_row_list.cursor
			from
				a_row_list.start
			until
				a_row_list.after
			loop
				l_grid_row := l_grid.row (a_row_list.index)
				l_row_height := l_grid_row.height
				if l_row_height > 0 then
					l_height := l_height + l_row_height
					l_row_count := l_row_count + 1
				end
				a_row_list.forth
			end
			a_row_list.go_to (l_cursor)
			if l_row_count > 0 then
				Result := l_height // l_row_count
			end
		end

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
