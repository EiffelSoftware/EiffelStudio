note
	description: "Testing of the EV_MODEL classes."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_EV_MODEL

inherit
	EV_VISION2_TEST_SET

	EQA_TEST_SET

	TEST_CONSTANTS

feature -- Testing

	pixmap_with_clip_area
			-- Make sure that drawing a pixmap with a clip area is actually using the clip area.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					pixmap1: EV_PIXMAP
					l_world: EV_MODEL_WORLD
					l_world_cell: EV_MODEL_WORLD_CELL
					l_picture: EV_MODEL_PICTURE
					l_rect: EV_MODEL_RECTANGLE
					window: EV_TITLED_WINDOW
					l_clip: EV_RECTANGLE
				do
					create pixmap1
					pixmap1.set_with_named_file (lenna)
					create l_clip.make (200, 100, 200, 200)
					pixmap1.set_clip_area (l_clip)


					create l_picture.make_with_pixmap (pixmap1)
					create l_world
					create l_rect.make_rectangle (-2, -2, pixmap1.width + 2, pixmap1.height + 2)
					l_rect.set_line_width (2)
					l_rect.set_foreground_color (create {EV_COLOR}.make_with_rgb (1, 0, 0))
					l_world.extend (l_rect)
					l_world.extend (l_picture)
					l_world.scale (.33)

					create l_world_cell.make_with_world (l_world)

					create window
					window.extend (l_world_cell)
					window.set_size (600, 600)
					window.show
					process_events
				end
			)
		end

	test_move_handle_constraint
			-- When setting `minimum_x|y' or `maximum_x|y' on a move handle, it messes up the moving.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_world: EV_MODEL_WORLD
					l_world_cell: EV_MODEL_WORLD_CELL
					l_scrollbar, l_slider: EV_MODEL_RECTANGLE
					l_move_handle: EV_MODEL_MOVE_HANDLE
					window: EV_TITLED_WINDOW
				do
					create l_world

					create l_scrollbar.make_rectangle (20, 20, 40, 10)
					create l_slider.make_rectangle (20, 20, 10, 10)
					create l_move_handle
					l_move_handle.disable_snapping
					l_move_handle.extend (l_slider)
					l_move_handle.set_minimum_y (l_scrollbar.bounding_box.y + l_slider.bounding_box.height // 2 + 1)
					l_move_handle.set_maximum_y (l_scrollbar.bounding_box.y + l_slider.bounding_box.height // 2 + 1)
					l_move_handle.set_minimum_x (l_scrollbar.bounding_box.x + l_slider.bounding_box.width // 2 + 1)
					l_move_handle.set_maximum_x (l_scrollbar.bounding_box.right - l_slider.bounding_box.width // 2)
					l_world.extend (l_scrollbar)
					l_world.extend (l_move_handle)

					create l_world_cell.make_with_world (l_world)

					create window
					window.extend (l_world_cell)
					window.set_size (600, 600)
					window.show
					process_events
				end
			)
		end

	test_hidden_figure
			-- Ensure that hidden figures are not drawn.
		note
			testing: "execution/isolated"
		do
			run_test (agent
				local
					l_world: EV_MODEL_WORLD
					l_world_cell: EV_MODEL_WORLD_CELL
					l_scrollbar, l_slider: EV_MODEL_RECTANGLE
					l_group, l_group2: EV_MODEL_GROUP
					window: EV_TITLED_WINDOW
				do
					create l_world

					create l_group.make_with_position (10, 10)
					create l_group2.make_with_position (10, 10)
					l_group.extend (l_group2)
					create l_scrollbar.make_rectangle (20, 20, 40, 10)
					create l_slider.make_rectangle (50, 50, 100, 100)
					l_slider.hide
					l_group2.extend (l_scrollbar)
					l_group2.extend (l_slider)

					l_world.extend (l_group)

					create l_world_cell.make_with_world (l_world)

					create window
					window.extend (l_world_cell)
					window.set_size (600, 600)
					window.show
					process_events
				end
			)
		end

feature {NONE} -- Helpers

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
