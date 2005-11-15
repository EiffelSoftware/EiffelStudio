indexing
	description: "The title bar on the top of user's widget."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TITLE_BAR

inherit
	EV_HORIZONTAL_BOX
		rename
			pointer_double_press_actions as pointer_double_press_actions_horizontal_box
		end

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		local
			l_cell, temp_cell: EV_CELL
			l_color_helper: SD_COLOR_HELPER
			frame: EV_FRAME
			main_box, vertical_box: EV_VERTICAL_BOX
			minimum_size_cell: EV_CELL
			tool_bar_button: EV_TOOL_BAR_BUTTON
			l_label: EV_LABEL

		do
			create internal_shared
			default_create
			build_hightlight_area

			create main_box
			extend (main_box)
			create minimum_size_cell
			extend (minimum_size_cell)
			disable_item_expand (minimum_size_cell)
			create container
			create frame
			frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_lowered)
			main_box.extend (frame)
			create vertical_box
			frame.extend (vertical_box)
			create frame
			frame.set_style ({EV_FRAME_CONSTANTS}.ev_frame_raised)
			vertical_box.extend (frame)
			frame.extend (container)

			container.extend (internal_leading_hightlight_area)
			container.disable_item_expand (internal_leading_hightlight_area)

--			create temp_cell
--			temp_cell.set_minimum_width (0)
--			container.extend (temp_cell)
--			container.disable_item_expand (temp_cell)

			create internal_title.make_with_text ("Untitled")
--			internal_title.set_minimum_width (0)
			container.extend (internal_title)
			container.disable_item_expand (internal_title)

			create temp_cell
--			temp_cell.set_minimum_width (0)
			container.extend (temp_cell)
			container.disable_item_expand (temp_cell)

			create vertical_box
			container.extend (vertical_box)
			container.disable_item_expand (vertical_box)

			create custom_area
			vertical_box.extend (custom_area)
			vertical_box.disable_item_expand (custom_area)

			---------------- Remove this to remove Demo button ----------------
--			create internal_tool_bar
--			custom_area.extend (internal_tool_bar)
--
--			create tool_bar_button
--			tool_bar_button.set_pixmap (internal_shared.icons.maximize)
--			internal_tool_bar.extend (tool_bar_button)
--			create tool_bar_button
--			tool_bar_button.set_pixmap (internal_shared.icons.maximize)
--			internal_tool_bar.extend (tool_bar_button)
----			internal_tool_bar.set_minimum_width (0)
			-------------------------------------------------------------------

			create l_label.default_create
			l_label.set_minimum_width (0)
			container.extend (l_label)
			container.enable_item_expand (l_label)

			create stick
			stick.set_pixmap (internal_shared.icons.unstick)

			is_stick := False
			create min_max
			min_max.set_pixmap (internal_shared.icons.maximize)
			create close
			close.set_pixmap (internal_shared.icons.close)

			stick.pointer_button_press_actions.force_extend (agent handle_stick_select)
			min_max.pointer_button_press_actions.force_extend (agent handle_min_max)
			close.pointer_button_press_actions.force_extend (agent handle_close)

			internal_title.pointer_button_press_actions.force_extend (agent handle_pointer_press)
			internal_title.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_title.pointer_leave_actions.force_extend (agent handle_pointer_leave)
			internal_title.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_title.pointer_double_press_actions.force_extend (agent handle_pointer_double_press)

			l_label.pointer_button_press_actions.force_extend (agent handle_pointer_press)
			l_label.pointer_button_release_actions.force_extend (agent on_pointer_release)
			l_label.pointer_leave_actions.force_extend (agent handle_pointer_leave)
			l_label.pointer_motion_actions.extend (agent on_pointer_motion)
			l_label.pointer_double_press_actions.force_extend (agent handle_pointer_double_press)

			create internal_tool_bar
			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (min_max)
			internal_tool_bar.extend (close)

			container.extend (internal_tool_bar)
			container.disable_item_expand (internal_tool_bar)

			container.extend (internal_ending_hightlight_area)
			container.disable_item_expand (internal_ending_hightlight_area)

			-- default setting
		 	disable_focus_color
		end

feature -- Access

	set_title (a_title: STRING) is
			-- Set the title on the title bar.
		do
			internal_title.set_text (a_title)
		end

	set_stick (a_bool: BOOLEAN) is
			-- Set if current is sticked.
		do
			if a_bool then
				stick.set_pixmap (internal_shared.icons.stick)
			else
				stick.set_pixmap (internal_shared.icons.unstick)
			end
		end

	set_show_min_max (a_show: BOOLEAN) is
			--
		do
			if a_show then
				if not internal_tool_bar.has (min_max) then
					internal_tool_bar.start
					internal_tool_bar.put_right (min_max)
				end
			else
				if internal_tool_bar.has (min_max) then
					internal_tool_bar.prune_all (min_max)
				end
			end
		end

--	show_min_max: BOOLEAN
--			-- Show min\max button?

	set_show_stick (a_show: BOOLEAN) is
			--
		do
			if a_show then
				if not internal_tool_bar.has (stick) then
					internal_tool_bar.start
					internal_tool_bar.put_left (stick)
				end
			else
				if internal_tool_bar.has (stick) then
					internal_tool_bar.prune_all (stick)
				end
			end
		end

--	show_stick: BOOLEAN
--			-- Show stick button?

	enable_focus_color is
			--
		local
		do
			is_focus_color_enable := True
			exposing_color := hightlight_color
			internal_leading_hightlight_area.expose_actions.call ([0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height])
			internal_ending_hightlight_area.expose_actions.call ([0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height])
		end

	disable_focus_color is
			--
		local
		do
			is_focus_color_enable := False
			exposing_color := hightlight_gray_color
			internal_leading_hightlight_area.expose_actions.call ([0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height])
			internal_ending_hightlight_area.expose_actions.call ([0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height])
		end

	is_focus_color_enable: BOOLEAN

	custom_area: EV_HORIZONTAL_BOX
			-- Contains custom widget.

feature -- Actions

	stick_select_actions: like internal_stick_select_actions is
			--
		do
			if internal_stick_select_actions = Void then
				create internal_stick_select_actions
			end
			Result := internal_stick_select_actions
		ensure
			not_void: Result /= Void
		end

	close_actions: like internal_close_actions is
			--
		do
			if internal_close_actions = Void then
				create internal_close_actions
			end
			Result := internal_close_actions
		ensure
			not_void: Result /= Void
		end

	min_max_actions: like internal_min_max_actions is
			--
		do
			if internal_min_max_actions = Void then
				create internal_min_max_actions
			end
			Result := internal_min_max_actions
		ensure
			not_void: Result /= Void
		end

	drag_actions: like internal_drag_actions is
			--
		do
			if internal_drag_actions = Void then
				create internal_drag_actions
			end
			Result := internal_drag_actions
		ensure
			not_void: Result /= Void
		end

	pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE is
			--
		do
			if internal_pointer_double_press_actions = Void then
				create internal_pointer_double_press_actions
			end
			Result := internal_pointer_double_press_actions
		ensure
			not_void: Result /= Void
		end


feature {NONE} -- Implementation for agents

	handle_stick_select is
			-- Notify clients when user click stick button.
		do
			if  is_stick then
				stick.set_pixmap (internal_shared.icons.unstick)
			else
				stick.set_pixmap (internal_shared.icons.stick)
			end

			is_stick := not is_stick
			stick_select_actions.call ([])
		end

	handle_min_max is
			--
		do
			min_max_actions.call ([])
		end

	handle_close is
			-- Handle the event when close button pressed.
		do
			close_actions.call ([])
		end

	pressed: BOOLEAN
			-- Is pointer button pressed?

	handle_pointer_press is
			--
		do
			pressed := True
		end

	on_pointer_release is
			--
		do
			pressed := False
		end

	handle_pointer_leave is
			--
		do
			pressed := False
		end

	on_pointer_motion (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			--
		do
			if pressed then
				drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
			end
		end

	handle_pointer_double_press is
			--
		do
			if pointer_double_press_actions /= Void then
				pointer_double_press_actions.call ([])
			end
		end

feature {NONE} -- Implemetation

	build_hightlight_area is
			--
		do
			create internal_leading_hightlight_area
			create internal_ending_hightlight_area

			internal_leading_hightlight_area.set_minimum_width (7)
			internal_ending_hightlight_area.set_minimum_width (2)

			internal_leading_hightlight_area.expose_actions.extend (agent expose_hightlight_area)
			internal_ending_hightlight_area.expose_actions.extend (agent expose_hightlight_area)
		end

	expose_hightlight_area (a, b, c, d: INTEGER) is
			--
		do
			internal_leading_hightlight_area.set_foreground_color (exposing_color)
			internal_leading_hightlight_area.fill_rectangle (0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height)
			internal_ending_hightlight_area.set_foreground_color (exposing_color)
			internal_ending_hightlight_area.fill_rectangle (0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height)
		end

feature {NONE} -- Implementation
	is_stick: BOOLEAN
			-- If the stick button selected ?

	internal_title: EV_LABEL
			-- Internal_title

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `stick', `min_max', `close' buttons.
	stick: EV_TOOL_BAR_BUTTON
			-- Sitck button
	min_max: EV_TOOL_BAR_BUTTON
			-- Minimize and maxmize button
	close: EV_TOOL_BAR_BUTTON
			-- Close button

	internal_shared: SD_SHARED
			-- All singletons

	container: EV_HORIZONTAL_BOX

	internal_pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE

	internal_stick_select_actions, internal_close_actions, internal_min_max_actions: EV_NOTIFY_ACTION_SEQUENCE

	internal_drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE

	internal_leading_hightlight_area: EV_DRAWING_AREA

	internal_ending_hightlight_area: EV_DRAWING_AREA

feature {NONE} -- Implementation (Colors)

	hightlight_color: EV_COLOR is
			--
		local
			unfocus_background_color: EV_GRID
		do
			if hightlight_color_internal = Void then
				create unfocus_background_color
				hightlight_color_internal := unfocus_background_color.focused_selection_color
			end
			Result := hightlight_color_internal
		end

	hightlight_color_up: EV_COLOR is
			--
		local
			l_color_helper: SD_COLOR_HELPER
		do
			if hightlight_color_shadow_up_internal = Void then
				create l_color_helper
				hightlight_color_shadow_up_internal := l_color_helper.build_color_with_lightness (hightlight_color, 0.7)
			end
			Result := hightlight_color_shadow_up_internal
		end

	hightlight_color_low: EV_COLOR is
			--
		local
			l_color_helper: SD_COLOR_HELPER
		do
			if hightlight_color_shadow_low_internal = Void then
				create l_color_helper
				hightlight_color_shadow_low_internal := l_color_helper.build_color_with_lightness (hightlight_color, - 0.7)
			end
			Result := hightlight_color_shadow_low_internal
		end

	hightlight_gray_color: EV_COLOR is
			--
		local
			l_color_helper: SD_COLOR_HELPER
		do
			if hightlight_gray_color_internal = Void then
				create l_color_helper
				hightlight_gray_color_internal := l_color_helper.build_color_with_lightness (hightlight_color, 0.6)
			end
			Result := hightlight_gray_color_internal
		end

	exposing_color: EV_COLOR

	hightlight_color_internal: EV_COLOR

	hightlight_gray_color_internal: EV_COLOR

	hightlight_color_shadow_up_internal: EV_COLOR

	hightlight_color_shadow_low_internal: EV_COLOR

end

