indexing
	description: "Title bar on the top of SD_ZONE."
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
			frame: EV_FRAME
			main_box, vertical_box: EV_VERTICAL_BOX
			minimum_size_cell: EV_CELL
			l_zero_size_container: EV_HORIZONTAL_BOX
		do
			create internal_shared
			default_create

			hightlight_color := internal_shared.focused_color
			hightlight_gray_color := internal_shared.non_focused_color

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

			create l_zero_size_container
			container.extend (l_zero_size_container)

			create internal_highlight_area_before
			internal_highlight_area_before.set_minimum_width (4)
			internal_highlight_area_before.expose_actions.force_extend (agent on_expose)
			l_zero_size_container.extend (internal_highlight_area_before)
			l_zero_size_container.disable_item_expand (internal_highlight_area_before)

			internal_title := "          "
			create internal_drawing_area
			internal_drawing_area.expose_actions.force_extend (agent on_expose)
			l_zero_size_container.extend (internal_drawing_area)

			create internal_highlight_area_after
			internal_highlight_area_after.set_minimum_width (internal_shared.highlight_tail_width)
			internal_highlight_area_after.expose_actions.force_extend (agent on_expose)
			l_zero_size_container.extend (internal_highlight_area_after)
			l_zero_size_container.disable_item_expand (internal_highlight_area_after)

			create custom_area
			l_zero_size_container.extend (custom_area)
			l_zero_size_container.disable_item_expand (custom_area)

			l_zero_size_container.set_minimum_width (0)

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

			init_actions

			create internal_tool_bar
			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (normal_max)
			internal_tool_bar.extend (close)

			container.extend (internal_tool_bar)
			container.disable_item_expand (internal_tool_bar)

			-- default setting
		 	disable_focus_color
		 	internal_highlight_area_before.set_background_color (hightlight_gray_color)
		 	internal_highlight_area_after.set_background_color (hightlight_gray_color)
		end

	init_actions is
			-- Initlize actions.
		do
			internal_highlight_area_before.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_highlight_area_before.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_highlight_area_before.pointer_leave_actions.force_extend (agent on_pointer_leave)
			internal_highlight_area_before.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_highlight_area_before.pointer_double_press_actions.force_extend (agent on_normal_max)

			internal_drawing_area.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_drawing_area.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_drawing_area.pointer_leave_actions.force_extend (agent on_pointer_leave)
			internal_drawing_area.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_drawing_area.pointer_double_press_actions.force_extend (agent on_normal_max)

			internal_highlight_area_after.pointer_button_press_actions.force_extend (agent on_pointer_press)
			internal_highlight_area_after.pointer_button_release_actions.force_extend (agent on_pointer_release)
			internal_highlight_area_after.pointer_leave_actions.force_extend (agent on_pointer_leave)
			internal_highlight_area_after.pointer_motion_actions.extend (agent on_pointer_motion)
			internal_highlight_area_after.pointer_double_press_actions.force_extend (agent on_normal_max)

		end

feature -- Access

	set_title (a_title: STRING) is
			-- Set the title on the title bar.
		require
			a_title_not_void: a_title /= Void
		do
			internal_title := a_title
		ensure
			set: internal_title = a_title
		end

	title: STRING is
			-- Title.
		do
			Result := internal_title
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
					if internal_tool_bar.has (stick) then
						internal_tool_bar.put_right (normal_max)
					else
						internal_tool_bar.put_left (normal_max)
					end
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
		local
			l_text_color: EV_COLOR
		do
			is_focus_color_enable := True

			internal_drawing_area.set_background_color (hightlight_color)
			if hightlight_color.lightness > 0.5 then
				create l_text_color.make_with_rgb (0, 0, 0)
			else
				create l_text_color.make_with_rgb (1, 1, 1)
			end
			internal_drawing_area.set_foreground_color (l_text_color)
			on_expose
		ensure
			is_focus_color_enable_set: is_focus_color_enable
		end

	disable_focus_color is
			-- Disable focus color.
		local
			l_text_color: EV_COLOR
		do
			is_focus_color_enable := False
			internal_drawing_area.set_background_color (hightlight_gray_color)
			if hightlight_gray_color.lightness > 0.5 then
				create l_text_color.make_with_rgb (0, 0, 0)
			else
				create l_text_color.make_with_rgb (1, 1, 1)
			end
			internal_drawing_area.set_foreground_color (l_text_color)

			on_expose
		ensure
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
			-- Handle pointer motion.
		do
			if pressed then
				drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
			end
		end

	on_expose is
			-- Handle expose actions.
		local
			l_helper: SD_COLOR_HELPER
		do
			create l_helper
			if is_focus_color_enable then
				l_helper.draw_color_change_gradually (internal_highlight_area_after, hightlight_color)
				internal_highlight_area_before.set_foreground_color (hightlight_color)
				internal_highlight_area_before.fill_rectangle (0, 0, internal_highlight_area_before.width, internal_highlight_area_before.height)
				internal_drawing_area.clear
				internal_drawing_area.draw_ellipsed_text_top_left (0, 2, internal_title, internal_drawing_area.width)
			else
				internal_highlight_area_before.clear
				internal_highlight_area_after.clear
				internal_drawing_area.clear
				internal_drawing_area.draw_ellipsed_text_top_left (0, 2, internal_title, internal_drawing_area.width)
			end
		end

feature {NONE} -- Implementation

	internal_highlight_area_before, internal_highlight_area_after: EV_DRAWING_AREA
			-- Hightlight area at beginning and end.

	set_all_custom_area_background_color (a_colorizable: EV_COLORIZABLE) is
			-- Set all custom area widgets background color.
		local
			l_container: EV_CONTAINER
			l_widgets: LINEAR [EV_WIDGET]
		do
			l_container ?= a_colorizable
			if l_container /= Void then
				l_widgets := l_container.linear_representation
				from
					l_widgets.start
				until
					l_widgets.after
				loop
					set_all_custom_area_background_color (l_widgets.item)
					l_widgets.forth
				end
			end
			if a_colorizable /= Void then
				if is_focus_color_enable then
					a_colorizable.set_background_color (hightlight_color)
				else
					a_colorizable.set_background_color (hightlight_gray_color)
				end
			end
		end

	internal_title: STRING
			-- Internal_title

	internal_drawing_area: EV_DRAWING_AREA
			-- Drawing area which draw `internal_title'.

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

feature {NONE} -- Implementation (Colors)

	hightlight_color: EV_COLOR
			-- Highlight color.

	hightlight_gray_color: EV_COLOR
			-- Highlight gray color.

invariant

	internal_shared_not_void: internal_shared /= Void

end

