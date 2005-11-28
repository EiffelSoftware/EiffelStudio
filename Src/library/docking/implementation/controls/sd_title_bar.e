indexing
	description: "Title bar on the top of SD_ZONE."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TITLE_BAR
--		FIXIT: This class need label\mini tool bar changed when size changed.
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
			temp_cell: EV_CELL
			frame: EV_FRAME
			main_box, vertical_box: EV_VERTICAL_BOX
			minimum_size_cell: EV_CELL
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

			set_stick (False)

			create normal_max
			normal_max.set_pixmap (internal_shared.icons.maximize)
			create close
			close.set_pixmap (internal_shared.icons.close)

			stick.pointer_button_press_actions.force_extend (agent on_stick_select)
			normal_max.pointer_button_press_actions.force_extend (agent on_normal_max)
			close.pointer_button_press_actions.force_extend (agent on_close)

			internal_title.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_title.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_title.pointer_leave_actions.force_extend (agent on_pointer_leave)
			internal_title.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_title.pointer_double_press_actions.force_extend (agent on_normal_max)

--			l_label.pointer_button_press_actions.force_extend (agent on_pointer_press)
--			l_label.pointer_button_release_actions.force_extend (agent on_pointer_release)
--			l_label.pointer_leave_actions.force_extend (agent on_pointer_leave)
--			l_label.pointer_motion_actions.extend (agent on_pointer_motion)
--			l_label.pointer_double_press_actions.force_extend (agent on_pointer_double_press)

			create internal_tool_bar
			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (normal_max)
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
		require
			a_title_not_void: a_title /= Void
		do
			internal_title.set_text (a_title)
		ensure
			set: internal_title.text.is_equal (a_title)
		end

	title: STRING is
			-- Title.
		do
			Result := internal_title.text
		ensure
			not_void: Result /= Void
		end

	set_stick (a_stick: BOOLEAN) is
			-- Set `is_stick'.
		do
			if a_stick then
				stick.set_pixmap (internal_shared.icons.stick)
			else
				stick.set_pixmap (internal_shared.icons.unstick)
			end
			is_stick := a_stick
		ensure
			set: a_stick = is_stick
		end

	is_stick: BOOLEAN
			-- If current sticked?

	set_max (a_max: BOOLEAN) is
			-- Set `is_max'.
		do
			if a_max then
				normal_max.set_pixmap (internal_shared.icons.normal)
			else
				normal_max.set_pixmap (internal_shared.icons.maximize)
			end
			is_max := a_max
		ensure
			set: is_max = a_max
		end

	is_max: BOOLEAN
			-- If current maximized?

	set_show_normal_max (a_show: BOOLEAN) is
			-- Set show normal\max button?
		do
			if a_show then
				if not internal_tool_bar.has (normal_max) then
					internal_tool_bar.start
					internal_tool_bar.put_right (normal_max)
				end
			else
				if internal_tool_bar.has (normal_max) then
					internal_tool_bar.prune_all (normal_max)
				end
			end
		ensure
			set: a_show = internal_tool_bar.has (normal_max)

		end

	is_show_normal_max: BOOLEAN is
			-- Show normal\max button?
		do
			Result := internal_tool_bar.has (normal_max)
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Set show stick button.
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
		ensure
			set: a_show = internal_tool_bar.has (stick)
		end

	is_show_stick: BOOLEAN is
			-- Show stick button?
		do
			Result := internal_tool_bar.has (stick)
		end

	enable_focus_color is
			-- Enable focus color.
		do
			is_focus_color_enable := True
			exposing_color := hightlight_color
			internal_leading_hightlight_area.expose_actions.call ([0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height])
			internal_ending_hightlight_area.expose_actions.call ([0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height])
		ensure
			color_right: exposing_color = hightlight_color
			is_focus_color_enable_set: is_focus_color_enable
		end

	disable_focus_color is
			-- Disable focus color.
		do
			is_focus_color_enable := False
			exposing_color := hightlight_gray_color
			internal_leading_hightlight_area.expose_actions.call ([0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height])
			internal_ending_hightlight_area.expose_actions.call ([0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height])
		ensure
			color_right: exposing_color = hightlight_gray_color
			is_focus_color_enable_set: not is_focus_color_enable
		end

	is_focus_color_enable: BOOLEAN
			-- If show highlight color now?

	custom_area: EV_HORIZONTAL_BOX
			-- Contains custom widget.

feature -- Actions

	stick_select_actions: like internal_stick_select_actions is
			-- Stick button select actions.
		do
			if internal_stick_select_actions = Void then
				create internal_stick_select_actions
			end
			Result := internal_stick_select_actions
		ensure
			not_void: Result /= Void
		end

	close_request_actions: like internal_close_request_actions is
			-- Close button select actions.
		do
			if internal_close_request_actions = Void then
				create internal_close_request_actions
			end
			Result := internal_close_request_actions
		ensure
			not_void: Result /= Void
		end

	normal_max_actions: like internal_normal_max_actions is
			-- Min max select actions.
		do
			if internal_normal_max_actions = Void then
				create internal_normal_max_actions
			end
			Result := internal_normal_max_actions
		ensure
			not_void: Result /= Void
		end

	drag_actions: like internal_drag_actions is
			-- Drag actions.
		do
			if internal_drag_actions = Void then
				create internal_drag_actions
			end
			Result := internal_drag_actions
		ensure
			not_void: Result /= Void
		end

--	pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE is
--			-- Pointer double press actions.
--		do
--			if internal_pointer_double_press_actions = Void then
--				create internal_pointer_double_press_actions
--			end
--			Result := internal_pointer_double_press_actions
--		ensure
--			not_void: Result /= Void
--		end

feature {NONE} -- Agents

	on_stick_select is
			-- Notify clients when user click stick button.
		do
			if  is_stick then
				stick.set_pixmap (internal_shared.icons.unstick)
			else
				stick.set_pixmap (internal_shared.icons.stick)
			end
			stick_select_actions.call ([])
		end

	on_normal_max is
			-- Handle `normal_max_actions'.
		do
			if is_max then
				normal_max.set_pixmap (internal_shared.icons.maximize)
			else
				normal_max.set_pixmap (internal_shared.icons.normal)
			end

			normal_max_actions.call ([])
		end

	on_close is
			-- Handle `close_request_actions'.
		do
			close_request_actions.call ([])
		end

	pressed: BOOLEAN
			-- Is pointer button pressed?

	on_pointer_press is
			-- Handle pointer press.
		do
			pressed := True
		ensure
			set: pressed = True
		end

	on_pointer_release is
			-- Handle pointer release.
		do
			pressed := False
		ensure
			set: pressed = False
		end

	on_pointer_leave is
			-- Hanle pointer leave.
		do
			pressed := False
		end

	on_pointer_motion (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Hanle pointer motion.
		do
			if pressed then
				drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
			end
		end

--	on_pointer_double_press is
--			-- Handle pointer double press.
--		do
--			if pointer_double_press_actions /= Void then
--				pointer_double_press_actions.call ([])
--			end
--		end

feature {NONE} -- Implemetation

	build_hightlight_area is
			-- Build highlight area.
		do
			create internal_leading_hightlight_area
			create internal_ending_hightlight_area

			internal_leading_hightlight_area.set_minimum_width (7)
			internal_ending_hightlight_area.set_minimum_width (2)

			internal_leading_hightlight_area.expose_actions.extend (agent expose_hightlight_area)
			internal_ending_hightlight_area.expose_actions.extend (agent expose_hightlight_area)
		end

	expose_hightlight_area (a, b, c, d: INTEGER) is
			-- Expose highlight area.
		do
			internal_leading_hightlight_area.set_foreground_color (exposing_color)
			internal_leading_hightlight_area.fill_rectangle (0, 0, internal_leading_hightlight_area.width, internal_leading_hightlight_area.height)
			internal_ending_hightlight_area.set_foreground_color (exposing_color)
			internal_ending_hightlight_area.fill_rectangle (0, 0, internal_ending_hightlight_area.width, internal_ending_hightlight_area.height)
			internal_title.set_background_color (exposing_color)
			custom_area.set_background_color (exposing_color)
			internal_tool_bar.set_background_color (exposing_color)
			set_background_color (exposing_color)
		end

feature {NONE} -- Implementation

	internal_title: EV_LABEL
			-- Internal_title

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `stick', `normal_max', `close' buttons.
	stick: EV_TOOL_BAR_BUTTON
			-- Sitck button
	normal_max: EV_TOOL_BAR_BUTTON
			-- Minimize and maxmize button
	close: EV_TOOL_BAR_BUTTON
			-- Close button

	internal_shared: SD_SHARED
			-- All singletons

	container: EV_HORIZONTAL_BOX

	internal_pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer double press actions.
	internal_stick_select_actions, internal_close_request_actions, internal_normal_max_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Title bar actions.
	internal_drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag actions.
	internal_leading_hightlight_area: EV_DRAWING_AREA
			-- Leading highlight area.
	internal_ending_hightlight_area: EV_DRAWING_AREA
			-- Ending hightlight area.

feature {NONE} -- Implementation (Colors)

	hightlight_color: EV_COLOR is
			-- `hightlight_color_internal'.
		local
			unfocus_background_color: EV_GRID
		do
			if hightlight_color_internal = Void then
				create unfocus_background_color
				hightlight_color_internal := unfocus_background_color.focused_selection_color
			end
			Result := hightlight_color_internal
		end

	hightlight_gray_color: EV_COLOR is
			-- `hightlight_gray_color_internal'.
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
			-- Exposing color.

	hightlight_color_internal: EV_COLOR
			-- Highlight color.

	hightlight_gray_color_internal: EV_COLOR
			-- Highlight gray color.

invariant

	internal_shared_not_void: internal_shared /= Void


end

