note
	description: "Tests for EV_PIXMAP"
	author: "Daniel Furrer <daniel.furrer@gmail.com>"
	revised_by: "Alexander Kogtenkov"
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
							l_grid.hide_header

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
							⟳ i: 1 |..| 30 ¦ l_grid.row (i).set_height (50) ⟲
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

	test_size_validity
			-- Check some internal validity regarding sizes.
		note
			testing: "execution/isolated"
		do
			run_test (agent
						local
							l_grid: EV_GRID
							l_old_height: INTEGER
							window: EV_TITLED_WINDOW
						do
							create window

							create l_grid
							l_grid.hide_header

							window.extend (l_grid)
							window.set_size (100, 100)
							window.show

							l_grid.set_row_count_to (1)

								-- We know for sure that the grid is fully contained in the visible part.
							assert ("virtual_height", l_grid.virtual_height = l_grid.viewable_height)
							assert ("virtual_width", l_grid.virtual_width = l_grid.viewable_width)
							assert ("viewable_height", l_grid.viewable_height = l_grid.height)

								-- Now with the header. It is still fully contained in the visible part.
							l_grid.show_header
							assert ("virtual_height", l_grid.virtual_height = l_grid.viewable_height)
							assert ("virtual_width", l_grid.virtual_width = l_grid.viewable_width)
							assert ("viewable_height", l_grid.viewable_height + l_grid.header.height = l_grid.height)

								-- Add 10 rows which makes the grid content larger than its container.
								-- Now we check that the minimum height if set is properly set.
							l_grid.set_row_count_to (10)
							assert ("viewable_height", l_grid.viewable_height + l_grid.header.height = l_grid.height)
							l_old_height := l_grid.virtual_height + l_grid.header.height
							l_grid.set_minimum_height (l_old_height)
							assert ("Minumum_height updated", l_old_height = l_grid.minimum_height)
							assert ("Same virtual height", l_old_height = l_grid.virtual_height + l_grid.header.height)

								-- Add 20 rows which makes the grid content larger than its container.
								-- Now we check that the minimum height if set is properly set.
							l_grid.set_row_count_to (20)
							assert ("viewable_height", l_grid.viewable_height + l_grid.header.height = l_grid.height)
							l_old_height := l_grid.virtual_height
							l_grid.set_minimum_height (l_old_height)
							assert ("Minumum_height updated", l_old_height = l_grid.minimum_height)
							assert ("Same virtual height", l_old_height = l_grid.virtual_height)
						end
				)
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
