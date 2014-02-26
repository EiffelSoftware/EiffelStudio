note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_EV_GRID

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

feature -- Test routines

	test_hide_row
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_grid: EV_GRID
					window: EV_WINDOW
				do
					create window

					create l_grid
					l_grid.set_row_count_to (10)
					l_grid.row (5).hide
					l_grid.row (5).show

					window.extend (l_grid)
					window.show
				end
			)
		end

	test_last_visible_row
			-- Set the text and reads it again.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_grid: EV_GRID
					window: EV_WINDOW
				do
					create window

					create l_grid
					l_grid.set_minimum_size (50, 50)

					window.extend (l_grid)
					window.show

					l_grid.set_row_count_to (10)

						-- When we hook to the resize actions of the EV_GRID, calling `last_visible_row' is Void
						-- when it should not.
					l_grid.virtual_size_changed_actions.extend (agent (a_grid: EV_GRID; x, y: INTEGER) do
						assert ("last_visible_row_attached", a_grid.last_visible_row /= Void)
					end (l_grid, ?, ?))
					l_grid.set_item (1, 1, create {EV_GRID_LABEL_ITEM}.make_with_text ("test"))

					assert ("last_visible_row_attached", l_grid.last_visible_row /= Void)
				end
			)
		end

	test_row_count
		do
			run_test (agent
				local
					l_grid: EV_GRID
					window: EV_WINDOW
				do
						-- Note: It is important that we have a grid with no header and
						-- no column set for this particular test.
					create window

					create l_grid
					l_grid.set_minimum_size (200, 1000)
					l_grid.set_row_count_to (20)

					window.extend (l_grid)
					window.show

					assert ("Number of rows", l_grid.row_count = 20)
					assert ("Number of visible rows", l_grid.visible_row_count = 20)

					l_grid.disable_row_height_fixed
					l_grid.row (1).set_height (40)
					l_grid.row (2).set_height (1000)
						-- The fact that we have different heights in various rows should
						-- not change the number of rows present or `visible'.
					assert ("Number of rows", l_grid.row_count = 20)
					assert ("Number of visible rows", l_grid.visible_row_count = 20)
					assert ("Last visible row", attached l_grid.last_visible_row as l_row and then l_row.index = 2)
					assert ("only 2 visible rows", l_grid.visible_row_indexes.count = 2)

						-- Create a tree now with 10 child under the first row.
					l_grid.enable_tree
					l_grid.insert_new_rows_parented (10, 2, l_grid.row (1))
					across 1 |..| 30 as l_counter loop
						l_grid.row (l_counter.item).set_height (50)
					end
					l_grid.row (1).collapse
					assert ("Number of rows", l_grid.row_count = 30)
					assert ("Number of visible rows", l_grid.visible_row_count = 20)
					assert ("Last visible row", attached l_grid.last_visible_row as l_row and then l_row.index = 30)
					assert ("20 visible rows", l_grid.visible_row_indexes.count = 20)

					l_grid.row (1).expand
					assert ("Number of rows", l_grid.row_count = 30)
					assert ("Number of visible rows", l_grid.visible_row_count = 30)
					assert ("Last visible row", attached l_grid.last_visible_row as l_row and then l_row.index = 20)
					assert ("20 visible rows", l_grid.visible_row_indexes.count = 20)

						-- Redo the same but this time we enable the fixed row height
					l_grid.enable_row_height_fixed
					l_grid.set_row_height (100)
					l_grid.row (1).collapse
					assert ("Number of rows", l_grid.row_count = 30)
					assert ("Number of visible rows", l_grid.visible_row_count = 20)
					assert ("Last visible row", attached l_grid.last_visible_row as l_row and then l_row.index = 20)
					assert ("20 visible rows", l_grid.visible_row_indexes.count = 10)

					l_grid.row (1).expand
					assert ("Number of rows", l_grid.row_count = 30)
					assert ("Number of visible rows", l_grid.visible_row_count = 30)
					assert ("Last visible row", attached l_grid.last_visible_row as l_row and then l_row.index = 10)
					assert ("20 visible rows", l_grid.visible_row_indexes.count = 10)
				end
			)
		end

note
	copyright: "Copyright (c) 1984-2014, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
