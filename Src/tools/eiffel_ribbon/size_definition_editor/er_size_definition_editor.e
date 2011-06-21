note
	description: "[
					GUI editor for size definition
																]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SIZE_DEFINITION_EDITOR

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			create figures.make (20)

			build_ui
			build_docking_content

			update_figure_world
		end

	build_docking_content
			--
		do
			create content.make_with_widget (widget, "ER_SIZE_DEFINITION_EDITOR")
			content.set_long_title ("Size Definition Editor")
			content.set_short_title ("Size Definition Editor")
		end

	build_ui
			--
		local
			l_vertical_box: EV_VERTICAL_BOX
			l_hor_box: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
			l_sep: EV_HORIZONTAL_SEPARATOR
			l_constants: CONSTANTS
		do
			create widget
			create add_button.make_with_text ("Add button")
			create remove_button.make_with_text ("Remove button")
			create group_button.make_with_text ("Group buttons")
			create label_visible_checker.make_with_text ("Label visible")
			create image_size_large_radio.make_with_text ("large")
			image_size_large_radio.select_actions.extend (agent on_image_size_select)
			create image_size_small_radio.make_with_text ("small")
			image_size_small_radio.select_actions.extend (agent on_image_size_select)

			create name_combo_box
			name_combo_box.select_actions.extend (agent on_name_combo_box_select)
			create save_button.make_with_text ("Save")
			save_button.select_actions.extend (agent on_save_button_select)
			create snap_to_lines_checker.make_with_text ("Snap to line")
			snap_to_lines_checker.enable_select
			create auto_group_checker.make_with_text ("Auto group")
			auto_group_checker.enable_select

			create drawing_area
			create drawing_area_buffer
			create model_world

			create projector.make_with_buffer (model_world, drawing_area_buffer, drawing_area)

			drawing_area.resize_actions.extend (agent on_drawing_area_resize)

			widget.extend (drawing_area)

			create l_vertical_box

			create l_constants
			l_vertical_box.set_padding (l_constants.default_padding)
			l_vertical_box.set_border_width (l_constants.default_border_width)

			widget.extend (l_vertical_box)
			widget.disable_item_expand (l_vertical_box)

			l_vertical_box.extend (add_button)
			l_vertical_box.disable_item_expand (add_button)
			add_button.select_actions.extend (agent on_add_button_select)
			l_vertical_box.extend (remove_button)
			l_vertical_box.disable_item_expand (remove_button)
			remove_button.select_actions.extend (agent on_remove_button_select)

			l_vertical_box.extend (group_button)
			l_vertical_box.disable_item_expand (group_button)
			group_button.select_actions.extend (agent on_group_buttons_select)
			l_vertical_box.extend (label_visible_checker)
			label_visible_checker.select_actions.extend (agent on_label_visible_checker_select)
			l_vertical_box.disable_item_expand (label_visible_checker)

			create l_hor_box
			l_hor_box.set_padding (l_constants.default_padding)
			l_hor_box.set_border_width (l_constants.default_border_width)

			l_vertical_box.extend (l_hor_box)
			l_vertical_box.disable_item_expand (l_hor_box)
			create l_label.make_with_text ("Image size")
			l_hor_box.extend (l_label)
			l_hor_box.disable_item_expand (l_label)
			l_hor_box.extend (image_size_small_radio)
			l_hor_box.disable_item_expand (image_size_small_radio)
			l_hor_box.extend (image_size_large_radio)
			l_hor_box.disable_item_expand (image_size_large_radio)

			create l_sep
			l_vertical_box.extend (l_sep)
			l_vertical_box.disable_item_expand (l_sep)

			l_vertical_box.extend (snap_to_lines_checker)
			l_vertical_box.disable_item_expand (snap_to_lines_checker)
--			snap_to_lines_checker.select_actions.extend (agent on_snap_to_lines_checker_select)
			l_vertical_box.extend (auto_group_checker)
			l_vertical_box.disable_item_expand (auto_group_checker)
--			auto_group_checker.select_actions.extend (agent on_auto_group_checker_select)

			create l_hor_box
			l_hor_box.set_padding (l_constants.default_padding)
			l_hor_box.set_border_width (l_constants.default_border_width)
			l_vertical_box.extend (l_hor_box)
			l_vertical_box.disable_item_expand (l_hor_box)
			l_hor_box.extend (name_combo_box)
			l_hor_box.extend (save_button)
			l_hor_box.disable_item_expand (save_button)

			drawing_area.pointer_button_press_actions.extend (agent on_pointer_press)
			drawing_area.pointer_button_release_actions.extend (agent on_pointer_release)
			drawing_area.pointer_motion_actions.extend (agent on_pointer_motion)

			drawing_area_buffer.set_size (600, 500)
		end

feature -- Command

	attach_to_docking_manager (a_docking_manager: SD_DOCKING_MANAGER)
			--
		require
			not_void: a_docking_manager /= Void
		do
			a_docking_manager.contents.extend (content)

--			content.set_floating_width (600)
--			content.set_floating_height (600)
--			content.set_floating (0, 0)

			content.set_auto_hide ({SD_ENUMERATION}.bottom)
			content.show_actions.extend_kamikaze (agent do
															update_figure_world
														end)
		end

feature -- Query

	size_definition_writer: ER_SIZE_DEFINITION_WRITER
				--
		once
			create Result.make
		end

	name_combo_box: EV_COMBO_BOX
			--

feature {NONE} -- Implementation

	content: SD_CONTENT
			--

	widget: EV_HORIZONTAL_BOX
			-- Main dockig content widget

	drawing_area: EV_DRAWING_AREA
			--

	drawing_area_buffer: EV_PIXMAP
			-- `drawing_area' buffer

	add_button: EV_BUTTON
			--

	remove_button: EV_BUTTON
			--

	group_button: EV_BUTTON
			--

	label_visible_checker: EV_CHECK_BUTTON
			--

	image_size_large_radio: EV_RADIO_BUTTON
			--

	image_size_small_radio: EV_RADIO_BUTTON
			--

	save_button: EV_BUTTON
			--

	snap_to_lines_checker: EV_CHECK_BUTTON
			--

	auto_group_checker: EV_CHECK_BUTTON
			--

feature {NONE} -- GUI implementation

	on_add_button_select
			--
		local
			l_figure: ER_FIGURE
		do
			create l_figure.make
			figures.extend (l_figure)

			update_figure_world
		end

	all_highlight_figures: ARRAYED_LIST [ER_FIGURE]
			--
		do
			from
				create Result.make (figures.count)
				figures.start
			until
				figures.after
			loop
				if figures.item.is_highlight then
					Result.extend (figures.item)
				end
				figures.forth
			end
		end

	on_remove_button_select
			--
		local
			l_all_selected: ARRAYED_LIST [ER_FIGURE]
		do

			if attached focus_figure as l_figure then
				figures.prune_all (l_figure)
				focus_figure := Void

				update_figure_world
			else
				from
					l_all_selected := all_highlight_figures
					l_all_selected.start
				until
					l_all_selected.after
				loop
					figures.prune_all (l_all_selected.item)

					l_all_selected.forth
				end
				update_figure_world
			end
		end

	on_label_visible_checker_select
			--
		do
			if attached focus_figure as l_figure then
				l_figure.set_label_visible (label_visible_checker.is_selected)

				update_figure_world
			end
		end

	on_drawing_area_resize (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
			--
		do
			if a_width > 0 and a_height > 0 then
				drawing_area_buffer.set_size (a_width, a_height)
			end

		end

	on_group_buttons_select
			--
		local
			l_buttons_by_x_position: ARRAYED_LIST [ER_FIGURE]
			l_first_y, l_last_x: INTEGER
			l_item: ER_FIGURE
		do
			from
				create l_buttons_by_x_position.make (figures.count)
				figures.start
			until
				figures.after
			loop
				-- FIXME: implement buttons by x position, implemented COMPARABLE in ER_RIGURE
				if figures.item.is_highlight then
					l_buttons_by_x_position.extend (figures.item)
				end
				figures.forth
			end

			if l_buttons_by_x_position.count > 1 then
				from
					l_buttons_by_x_position.start
				until
					l_buttons_by_x_position.after
				loop
					l_item :=  l_buttons_by_x_position.item
					if l_buttons_by_x_position.index = 1 then
						l_first_y := l_item.y
						l_last_x := l_item.x + l_item.width
					else
						l_item.set_x (l_last_x)
						l_item.set_y (l_first_y)

						l_last_x := l_last_x + l_item.width
					end
					l_buttons_by_x_position.forth
				end

				update_figure_world
			end
		end

	on_image_size_select
			--
		do
			if attached focus_figure as l_figure then
				l_figure.set_is_large_image_size (image_size_large_radio.is_selected)

				update_figure_world
			end
		end

	on_save_button_select
			--
		do
			check_for_invalid_buttons

			size_definition_writer.reset
			check not name_combo_box.text.is_empty end
			size_definition_writer.save (figures, name_combo_box.text)
			size_definition_writer.update_combo_box (name_combo_box, name_combo_box.text)
		end

	on_name_combo_box_select
			--
		do
			if attached name_combo_box.selected_item as l_selected_item then
				size_definition_writer.load (l_selected_item.text)
				figures.wipe_out
				figures.append (size_definition_writer.all_generated_figures)
				update_figure_world
			end
		end

feature {NONE} -- Figure handling

	ev_figure_by_info (a_info: ER_FIGURE): EV_FIGURE
			--
		local
			l_result: EV_FIGURE_PICTURE
			l_pixmap: EV_PIXMAP
		do
			create l_result

			l_result.set_pixmap (a_info.pixmap)
			l_result.set_point (create {EV_RELATIVE_POINT}.make_with_position (a_info.x, a_info.y))
			Result := l_result
		end

	is_close_to_assist_line (a_y: INTEGER; a_horizontal_line_y: INTEGER): BOOLEAN
			--
		do
			Result := a_y >= (a_horizontal_line_y - {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset) and a_y <= (a_horizontal_line_y + {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset)
		end

	snap_to_assist_line_if_possible
			--
		do
			if snap_to_lines_checker.is_selected then
				if attached focus_figure as l_figure then
					if is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y) then
						l_figure.set_y ({ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y)
					elseif is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y) then
						l_figure.set_y ({ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y)
					elseif is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y) then
						l_figure.set_y ({ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y)
					end
				end
			end
		end

	auto_group_is_possible
			--
		local
			l_found: BOOLEAN
			l_figure_right: INTEGER
		do
			if auto_group_checker.is_selected then
				if attached focus_figure as l_figure then
					from
						figures.start
					until
						figures.after or l_found
					loop
						if figures.item /= l_figure then
							-- check `l_figure' left side
							l_figure_right := figures.item.x + figures.item.width
							if l_figure.x >= (l_figure_right - {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset) and
								l_figure.x <= (l_figure_right + {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset) then
								l_found := True

								l_figure.set_x (l_figure_right)
							elseif (l_figure.x + l_figure.width) >= (figures.item.x - {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset) and
								(l_figure.x + l_figure.width ) <= (figures.item.x + {ER_SIZE_DEFINITION_CONSTANTS}.sensitive_offset) then
								-- check `l_figure' right side
								l_found := True

								l_figure.set_x (figures.item.x - l_figure.width)
							end
						end

						figures.forth
					end
				end
			end
		end

	check_for_invalid_buttons
			--
		do
			from
				focus_figure := void
				set_focus_figure (void)
				figures.start
			until
				figures.after
			loop
				if figures.item.y = {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y or
					figures.item.y = {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y or
					figures.item.y = {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y then
					figures.item.set_is_valid_position (True)
				else
					figures.item.set_is_valid_position (False)
				end
				figures.forth
			end

			update_figure_world
		end

	add_assist_lines
			--
		local
			l_line: EV_FIGURE_LINE
		do
			if attached focus_figure as l_figure then
				if is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y) then
					create l_line.make_with_positions (0, {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y, drawing_area.width, {ER_SIZE_DEFINITION_CONSTANTS}.up_horizontal_line_y)
					model_world.extend (l_line)
				end

				if is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y) then
					create l_line.make_with_positions (0, {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y, drawing_area.width, {ER_SIZE_DEFINITION_CONSTANTS}.middle_horizontal_line_y)
					model_world.extend (l_line)
				end

				if is_close_to_assist_line (l_figure.y, {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y) then
					create l_line.make_with_positions (0, {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y, drawing_area.width, {ER_SIZE_DEFINITION_CONSTANTS}.lower_horizontal_line_y)
					model_world.extend (l_line)
				end
			end

		end

	update_for_select_moving
			--
		local
			l_rect: EV_FIGURE_RECTANGLE
			l_point_1, l_point_2: EV_RELATIVE_POINT
		do
			if is_select_moving then
				create l_point_1.make_with_position (select_moving_start_x, select_moving_start_y)
				create l_point_2.make_with_position (select_moving_end_x, select_moving_end_y)
				create l_rect.make_with_points (l_point_1, l_point_2)
				model_world.extend (l_rect)
			end
		end

	background_pic: EV_PIXMAP
			--
		local
			l_path: FILE_NAME
			l_retried: BOOLEAN
			l_shared: ER_SHARED_SINGLETON
			l_error: EV_ERROR_DIALOG
			l_interface_names: ER_INTERFACE_NAMES
			l_misc_constants: ER_MISC_CONSTANTS
		do
			if not l_retried then
				create l_path.make_from_string (constants.images)
				l_path.set_file_name ("ribbon_background.png")
				create Result
				Result.set_with_named_file (l_path)
			else
				create Result.make_with_size (10, 10)
			end

		rescue
			l_retried := True
			create l_shared
			create l_interface_names
			create l_misc_constants
			if attached l_misc_constants.ise_eiffel as l_ise_eiffel then
				create l_error.make_with_text (l_interface_names.cannot_find_templates (l_ise_eiffel))
			else
				create l_error.make_with_text (l_interface_names.ise_eiffel_not_defined)
			end
			l_error.set_buttons (<<l_interface_names.ok>>)
			if attached l_shared.main_window_cell.item as l_win then
				l_error.show_modal_to_window (l_win)
			else
				l_error.show
			end
			retry
		end

	update_figure_world
			--
		local
			l_figure: EV_FIGURE
			l_point_1, l_point_2: EV_RELATIVE_POINT
			l_background: EV_FIGURE_PICTURE
		do
			model_world.wipe_out

			-- Background
			create l_background.make_with_pixmap (background_pic)
			model_world.extend (l_background)

			-- Assist lines
			add_assist_lines

			-- Buttons
			from
				figures.start
			until
				figures.after
			loop
				l_figure := ev_figure_by_info (figures.item)

				model_world.extend (l_figure)

				figures.forth
			end

			-- Select moving
			update_for_select_moving

			projector.project
		end

	figures: ARRAYED_LIST [ER_FIGURE]
			--

	focus_figure: detachable ER_FIGURE
			--

	last_x, last_y: INTEGER
			--

	is_pointer_pressed: BOOLEAN
			--

	offset_x, offset_y: INTEGER
			-- Recorded by `on_pointer_press'

	is_select_moving: BOOLEAN
			-- If moving selected figure now?
	select_moving_start_x, select_moving_start_y: INTEGER
			--
	select_moving_end_x, select_moving_end_y: INTEGER
			--

	on_pointer_press (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			--
		local
			l_point: EV_RELATIVE_POINT
			l_found: BOOLEAN
		do
			from
				clear_invalid_figure_states
				focus_figure := void
				figures.start
			until
				figures.after or l_found
			loop
				if figures.item.has_point (a_x, a_y) then
					focus_figure := figures.item
					figures.item.set_highlight (True)

					offset_x := a_x - figures.item.x
					offset_y := a_y - figures.item.y
					l_found := True
				end
				figures.forth
			end

			set_focus_figure (focus_figure)
			update_gui_for_focus_figure

			if focus_figure = Void then
				-- Start selecting rect
				is_select_moving := True
				select_moving_start_x := a_x
				select_moving_start_y := a_y
			end

			is_pointer_pressed := True
		end

	update_gui_for_focus_figure
			-- Update `label_visible_checker' and `image_size_large_radio'
		do
			if attached focus_figure as l_figure then
				if l_figure.is_label_visible then
					label_visible_checker.enable_select
				else
					label_visible_checker.disable_select
				end

				if l_figure.is_large_image_size then
					image_size_large_radio.enable_select
				else
					image_size_small_radio.enable_select
				end
			end
		end

	clear_invalid_figure_states
			--
		do
			from
				figures.start
			until
				figures.after
			loop
				figures.item.set_is_valid_position (True)

				figures.forth
			end
		end

	set_focus_figure (a_focus_figure: detachable ER_FIGURE)
			--
		do
			from
				figures.start
			until
				figures.after
			loop

				if attached a_focus_figure as l_focus_figure and then
				 l_focus_figure = figures.item then
					figures.item.set_highlight (True)
				else
					figures.item.set_highlight (False)
				end
				figures.forth
			end
			update_figure_world
		end

	on_pointer_release (a_x: INTEGER_32; a_y: INTEGER_32; a_button: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			--
		local
			l_point: EV_RELATIVE_POINT
		do
			is_pointer_pressed := False
			if is_select_moving then

				is_select_moving := False

				calculate_selected_figures
				--To erase selecting rectangle	
				update_figure_world
			end

		end

	calculate_selected_figures
			--
		local
			l_item: ER_FIGURE
			l_rect_item: EV_RECTANGLE
			l_rect_select: EV_RECTANGLE
		do
			from
				create l_rect_select.make (select_moving_start_x, select_moving_start_y, (select_moving_end_x - select_moving_start_x).abs, (select_moving_end_y - select_moving_start_y).abs)
				figures.start
			until
				figures.after
			loop
				l_item := figures.item
				create l_rect_item.make (l_item.x, l_item.y, l_item.width, l_item.height)


				if l_rect_select.intersects (l_rect_item) then
					l_item.set_highlight (True)
				end
				figures.forth
			end
		end

	on_pointer_motion (a_x: INTEGER_32; a_y: INTEGER_32; a_x_tilt: REAL_64; a_y_tilt: REAL_64; a_pressure: REAL_64; a_screen_x: INTEGER_32; a_screen_y: INTEGER_32)
			--
		do
			if attached focus_figure as l_figure and then is_pointer_pressed then
				l_figure.set_x (a_x - offset_x)
				l_figure.set_y (a_y - offset_y)

				snap_to_assist_line_if_possible

				auto_group_is_possible

				update_figure_world
			elseif is_select_moving then
				select_moving_end_x := a_x
				select_moving_end_y := a_y

				update_figure_world
			end

		end

feature {NONE} -- Implementation

	model_world: EV_FIGURE_WORLD
			--

	projector: EV_DRAWING_AREA_PROJECTOR
		-- Projector used for `world'

	constants: ER_MISC_CONSTANTS
			--
		once
			create Result
		end

end
