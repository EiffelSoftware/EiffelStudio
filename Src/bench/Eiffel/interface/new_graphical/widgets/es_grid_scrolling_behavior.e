indexing
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

	REFACTORING_HELPER

create
	make

feature {NONE} -- Scrolling : initialization

	make (g: EV_GRID) is
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

	enable_mouse_wheel is
		require
			mouse_wheel_disabled: not mouse_wheel_enabled
		do
			if on_mouse_wheel_action_agent = Void then
				on_mouse_wheel_action_agent := agent on_mouse_wheel_action
			end
			grid.mouse_wheel_actions.extend (on_mouse_wheel_action_agent)
			on_mouse_wheel_action := True
		end

	disable_mouse_wheel is
		require
			mouse_wheel_enabled: mouse_wheel_enabled
		do
			if on_mouse_wheel_action_agent /= Void then
				grid.mouse_wheel_actions.prune_all (on_mouse_wheel_action_agent)
			end
			on_mouse_wheel_action := False
		end

	set_mouse_wheel_scroll_full_page (v: BOOLEAN) is
			-- Set the mouse wheel scroll page mode
		do
			mouse_wheel_scroll_full_page := v
		ensure
			mouse_wheel_scroll_full_page_set: mouse_wheel_scroll_full_page = v
		end

	set_mouse_wheel_scroll_size (v: like mouse_wheel_scroll_size) is
			-- Set the mouse wheel scroll size
		require
			v_positive: v > 0
		do
			mouse_wheel_scroll_size	:= v
		ensure
			mouse_wheel_scroll_size_set: mouse_wheel_scroll_size = v
		end

	set_scrolling_common_line_count (v: like scrolling_common_line_count) is
			-- Set `scrolling_common_line_count' with `v'.
		do
			scrolling_common_line_count := v
		ensure
			scrolling_common_line_count_set: scrolling_common_line_count = v
		end

feature -- Scrolling

	scroll_rows (a_step: INTEGER; is_full_page_scrolling: BOOLEAN) is
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
						if a_step < 0 then
								-- We are scrolling down.
							if scrolling_common_line_count < l_visible_rows.count then
								vy := g.row (l_visible_rows.i_th (
									l_visible_rows.count - scrolling_common_line_count)).virtual_y_position
							else
									-- Cannot go below, go to the last element.
								vy := g.row (l_visible_rows.last).virtual_y_position
							end
						else
								-- We are scrolling up
							l_viewable_row_indexes := g.viewable_row_indexes
							if l_viewable_row_indexes /= Void then
								l_visible_count := g.viewable_height // g.row_height - scrolling_common_line_count
								l_first_row := g.row (l_visible_rows.first)
								l_viewable_row_indexes.start
								l_viewable_row_indexes.search (l_first_row.index)
								if not l_viewable_row_indexes.exhausted then
									if l_visible_count < l_viewable_row_indexes.index then
										vy := g.row (l_viewable_row_indexes.i_th (
											l_viewable_row_indexes.index - l_visible_count)).virtual_y_position
									else
											-- We reached the top.
										vy := 0
									end
								else
										-- We could not find the item. This is not right.
									vy := vy_now - a_step * l_visible_count * g.row_height
								end
							else
									-- We could not use `visible_indexes_to_row_indexes' to get the right
									-- information. Use an approximation that only works when there is no
									-- tree in the grid.
								vy := vy_now - a_step * l_visible_count * g.row_height
							end
						end
					else
						if a_step < 0 then
								-- We are scrolling down.
							if mouse_wheel_scroll_size < l_visible_rows.count then
								vy := g.row (l_visible_rows.i_th (mouse_wheel_scroll_size + 1)).virtual_y_position
							else
									-- Do nothing.
								vy := vy_now
							end
						else
								-- We are scrolling up
							l_viewable_row_indexes := g.viewable_row_indexes
							if l_viewable_row_indexes /= Void then
								l_first_row := g.row (l_visible_rows.first)
								l_viewable_row_indexes.start
								l_viewable_row_indexes.search (l_first_row.index)
								if not l_viewable_row_indexes.exhausted then
									if mouse_wheel_scroll_size < l_viewable_row_indexes.index then
										vy := g.row (l_viewable_row_indexes.i_th (
											l_viewable_row_indexes.index - mouse_wheel_scroll_size)).virtual_y_position
									else
											-- We reached the top.
										vy := 0
									end
								else
										-- We could not find the item. This is not right.
									vy := vy_now - a_step * mouse_wheel_scroll_size * g.row_height
								end
							else
									-- We could not use `visible_indexes_to_row_indexes' to get the right
									-- information. Use an approximation that only works when there is no
									-- tree in the grid.
								vy := vy_now - a_step * mouse_wheel_scroll_size * g.row_height
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

	on_mouse_wheel_action_agent: PROCEDURE [ANY, TUPLE [INTEGER]]
			-- Agent representing `agent on_mouse_wheel_action' .

	on_mouse_wheel_action (a_step: INTEGER) is
			-- Action called on mouse wheel event
		do
			scroll_rows (a_step, mouse_wheel_scroll_full_page or ev_application.ctrl_pressed)
		end

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
