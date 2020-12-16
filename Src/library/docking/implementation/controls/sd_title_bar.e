note
	description: "Title bar on the top of SD_ZONE."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TITLE_BAR

inherit
	EV_HORIZONTAL_BOX
		rename
			pointer_double_press_actions as pointer_double_press_actions_horizontal_box
		redefine
			destroy
		end

	SD_WIDGETS_LISTS
		undefine
			default_create,
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initlization

	make
			-- Creation method
		do
			create internal_shared

			create fixed
			create internal_border.make
			create viewport
			create stick.make
			create normal_max.make
			create internal_title.make
			create close.make
			create internal_tool_bar.make

			default_create

			extend (internal_border)

			internal_border.set_border_width (internal_shared.border_width)
			internal_border.set_border_color (internal_shared.border_color)
			internal_border.set_border_style ({SD_ENUMERATION}.bottom)


			internal_border.extend (viewport)

			viewport.extend (fixed)


			internal_title.set_focused_color (True)

			fixed.extend (internal_title)

			update_size_and_font

			stick.set_pixmap (internal_shared.icons.unstick)
			if internal_shared.icons.unstick_buffer /= Void then
				stick.set_pixel_buffer (internal_shared.icons.unstick_buffer)
			end
			stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)

			set_stick (False)

			normal_max.set_pixmap (internal_shared.icons.maximize)
			if internal_shared.icons.maximize_buffer /= Void then
				normal_max.set_pixel_buffer (internal_shared.icons.maximize_buffer)
			end
			normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)

			close.set_pixmap (internal_shared.icons.close)
			if internal_shared.icons.close_buffer /= Void then
				close.set_pixel_buffer (internal_shared.icons.close_buffer)
			end
			close.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_close)

			stick.select_actions.extend (agent on_stick_select)
			normal_max.select_actions.extend (agent on_normal_max)
			close.select_actions.extend (agent on_close)

			internal_title.pointer_double_press_actions.extend
				(agent(a_x, a_y, a_button: INTEGER_32; a_x_tilt, a_y_tilt, a_pressure: REAL_64; a_screen_x, a_screen_y: INTEGER_32)
					do on_normal_max end)

			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (normal_max)
			internal_tool_bar.extend (close)
			internal_tool_bar.compute_minimum_size

			fixed.extend (internal_tool_bar)

			-- default setting
		 	disable_focus_color
		 	viewport.resize_actions.extend (agent on_fixed_resize)
		 	viewport.dpi_changed_actions.extend (agent on_dpi_change_fixed_resize)

		 	add_title_bar (Current)
		end

feature -- Command

	set_title (a_title: READABLE_STRING_GENERAL)
			-- Set the title on the title bar
		require
			a_title_not_void: a_title /= Void
		do
			internal_title.set_title (a_title)
			add_refresh_title_in_idle_action
		ensure
			set: internal_title.title.is_equal (a_title.as_string_32)
		end

	set_stick (a_stick: BOOLEAN)
			-- Set `is_stick'
		do
			if a_stick then
				stick.set_pixmap (internal_shared.icons.stick)
				if internal_shared.icons.stick_buffer /= Void then
					stick.set_pixel_buffer (internal_shared.icons.stick_buffer)
				end
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick)
			else
				stick.set_pixmap (internal_shared.icons.unstick)
				if internal_shared.icons.unstick_buffer /= Void then
					stick.set_pixel_buffer (internal_shared.icons.unstick_buffer)
				end
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)
			end
			is_stick := a_stick
		ensure
			set: a_stick = is_stick
		end

	set_max (a_max: BOOLEAN)
			-- Set `is_max'
		do
			if a_max then
				normal_max.set_pixmap (internal_shared.icons.normal)
				if internal_shared.icons.normal_buffer /= Void then
					normal_max.set_pixel_buffer (internal_shared.icons.normal_buffer)
				end
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			else
				normal_max.set_pixmap (internal_shared.icons.maximize)
				if internal_shared.icons.maximize_buffer /= Void then
					normal_max.set_pixel_buffer (internal_shared.icons.maximize_buffer)
				end
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			end
			is_max := a_max
		ensure
			set: is_max = a_max
		end

	set_show_normal_max (a_show: BOOLEAN)
			-- Set show normal\max button?
		do
			if a_show then
				if not internal_tool_bar.has (normal_max) then
					if internal_tool_bar.has (stick) then
						internal_tool_bar.force (normal_max, 2)
					else
						internal_tool_bar.force (normal_max, 1)
					end
					internal_tool_bar.compute_minimum_size
				end
			else
				if internal_tool_bar.has (normal_max) then
					internal_tool_bar.prune (normal_max)
					internal_tool_bar.compute_minimum_size
				end
			end
			-- We restoring docking layout, `fixed' maybe destroyed
			if not fixed.is_destroyed then
				internal_update_fixed_size
			end
		ensure
			set: a_show = internal_tool_bar.has (normal_max)
		end

	set_show_stick (a_show: BOOLEAN)
			-- Set show stick button
		do
			if a_show then
				if not internal_tool_bar.has (stick) then
					internal_tool_bar.force (stick, 1)
					internal_tool_bar.compute_minimum_size
				end
			else
				if internal_tool_bar.has (stick) then
					internal_tool_bar.prune (stick)
					internal_tool_bar.compute_minimum_size
				end
			end
			-- We restoring docking layout, `fixed' maybe destroyed
			if not fixed.is_destroyed then
				internal_update_fixed_size
			end
		ensure
			set: a_show = internal_tool_bar.has (stick)
		end

	enable_focus_color
			-- Enable focus color in applicaiton idle actions
		do
			set_color_in_idle (agent enable_focus_color_imp)
		end

	enable_non_focus_active_color
			-- Enable non-focused active color in applicaiton idle actions
		do
			set_color_in_idle (agent enable_non_focus_active_color_imp)
		end

	disable_focus_color
			-- Disable focus color in applicaiton idle actions
		do
			set_color_in_idle (agent disable_focus_color_imp)
		end

	extend_custom_area (a_widget: detachable EV_WIDGET)
			-- Extend `custom_area' with `a_widget'
			-- `a_widget' can be void
		do
			if attached internal_custom_widget as l_custom_widget and then
				(l_custom_widget /= a_widget and fixed.has (l_custom_widget)) then
				-- Prune the old one
				fixed.prune (l_custom_widget)
			end
			internal_custom_widget := a_widget
			internal_update_fixed_size

			-- `a_widget' will not have resize actions since it was in EV_FIXED
			--	a_widget.resize_actions.force_extend (agent update_fixed_size)
		ensure
			set: internal_custom_widget = a_widget
		end

	clear_custom_widget
			-- Wipe out custom area
		do
			if attached internal_custom_widget as l_custom_widget then
				fixed.prune (l_custom_widget)
			end
			internal_custom_widget := Void
			internal_update_fixed_size
		ensure
			wuped_out: internal_custom_widget = Void
		end

	update_fixed_size
			-- Update fixed sizes
			-- Different from `internal_update_fixed_size', this feature will force `internal_custom_widget' recalculate its size
		do
			if not is_resizing then
				is_resizing := True
				-- This is to make sure item in `fixed' is resized, otherwise items inside mini tool bar size is incorrect
				if attached internal_custom_widget as l_custom_widget and then fixed.has (l_custom_widget) then
					fixed.prune (l_custom_widget)
				end
				on_fixed_resize (0, 0, fixed.width, fixed.height)
				is_resizing := False
			end
		end

	enable_baseline
			-- Set `is_baseline_enalbed' with True
		do
			is_baseline_enabled := True
			update_baseline
		end

	disable_baseline
			-- Set `is_baseline_enalbed' with false
		do
			is_baseline_enabled := False
			update_baseline
		end

	update_baseline
			-- Update baseline state and color
		do
			if not is_destroyed then
				if is_baseline_enabled then
					internal_border.set_show_border ({SD_ENUMERATION}.bottom, True)
					internal_border.set_one_border_color ({SD_ENUMERATION}.bottom, internal_shared.border_color)
					set_minimum_height (internal_shared.title_bar_height + 1)
				else
					internal_border.set_show_border ({SD_ENUMERATION}.bottom, False)
					set_minimum_height (internal_shared.title_bar_height)
				end
			end
		end

	destroy
			-- Destroy
		do
			prune_title_bar (Current)
			Precursor {EV_HORIZONTAL_BOX}
			-- FIXIT: Vision2 bug
			-- If we don't destory it, it'll not be collected.
			internal_tool_bar.destroy
		end

	update_size_and_font
			-- Update size and font
		do
			viewport.set_minimum_height (internal_shared.title_bar_height - 1)
			internal_title.set_minimum_height (internal_shared.title_bar_height)
			internal_title.set_font (internal_shared.tool_bar_font)

			set_minimum_height (internal_shared.title_bar_height)
		end

feature -- Query

	title: STRING_32
			-- Title
		do
			Result := internal_title.title
		ensure
			not_void: Result /= Void
		end

	is_stick: BOOLEAN
			-- If current sticked?

	is_max: BOOLEAN
			-- If current maximized?

	is_show_normal_max: BOOLEAN
			-- Show normal\max button?
		do
			Result := internal_tool_bar.has (normal_max)
		end

	is_show_stick: BOOLEAN
			-- Show stick button?
		do
			Result := internal_tool_bar.has (stick)
		end

	is_focus_color_enable: BOOLEAN
			-- If show highlight color now?
		do
			Result := internal_title.is_focus_color_enable
		end

	is_focused_active_color_enable: BOOLEAN
			-- Is active focused drawing style enabled?
		do
			Result := is_focus_color_enable and then internal_title.is_focused_color
		end

	is_non_focused_active_color_enable: BOOLEAN
			-- Is active non-focused drawing style enabled?
		do
			Result := is_focus_color_enable and then not internal_title.is_focused_color
		end

	is_baseline_enabled: BOOLEAN
			-- If there is a extra baseline?
			-- When used by SD_FLOATING_ZONE, we should added an extra base line to make it looks beautiful

feature -- Actions

	stick_select_actions: attached like internal_stick_select_actions
			-- Stick button select actions
		do
			Result := internal_stick_select_actions
			if not attached Result then
				create Result
				internal_stick_select_actions := Result
			end
		ensure
			not_void: Result /= Void
		end

	close_request_actions: attached like internal_close_request_actions
			-- Close button select actions
		do
			Result := internal_close_request_actions
			if not attached Result then
				create Result
				internal_close_request_actions := Result
			end
		ensure
			not_void: Result /= Void
		end

	normal_max_actions: attached like internal_normal_max_actions
			-- Min max select actions.
		do
			Result := internal_normal_max_actions
			if not attached Result then
				create Result
				internal_normal_max_actions := Result
			end
		ensure
			not_void: Result /= Void
		end

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Drag actions
		do
			Result := internal_title.drag_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Agents

	on_mini_tool_bar_indicator_clicked
			-- Handle `mini_tool_bar_indicator' select actions
		local
			l_dialog: SD_MINI_TOOL_BAR_DIALOG
			l_helper: SD_POSITION_HELPER
		do
			if attached internal_custom_widget as l_custom_widget then
				create l_dialog.make (l_custom_widget)
				create l_helper.make
				l_helper.set_dialog_position (l_dialog, internal_tool_bar.screen_x, internal_tool_bar.screen_y, internal_shared.title_bar_height)
				l_dialog.show
				l_dialog.set_focus
			end
		end

	on_fixed_resize (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
			-- Handle fixed resize actions
		local
			l_custom_widget: like internal_custom_widget
		do
			if a_width > 0 and a_height > 0 and not fixed.is_destroyed and not internal_tool_bar.is_destroyed then
				fixed.set_minimum_width (a_width)
				viewport.set_item_width (a_width)

				l_custom_widget := internal_custom_widget
				if l_custom_widget /= Void  then
					-- We have to check if `internal_custome_widget' is_destroyed, it makes sense while an application is exiting.
					-- See bug#13731
					if not l_custom_widget.is_destroyed then
						if a_width >= tool_bar_width + l_custom_widget.minimum_width + (internal_shared.highlight_before_width + internal_shared.highlight_tail_width) then
							-- There is enough space for mini tool bar.
							if internal_tool_bar.has (mini_tool_bar_indicator) then
								internal_tool_bar.prune (mini_tool_bar_indicator)
								internal_tool_bar.compute_minimum_size
							end

							if not fixed.has (l_custom_widget) then
								if attached l_custom_widget.parent as l_parent then
									l_parent.prune (l_custom_widget)
								end
								fixed.extend (l_custom_widget)
							end
							if internal_title.minimum_height < a_height then
								internal_title.set_minimum_height (a_height)
							end
							fixed.set_item_x_position (l_custom_widget, a_width - tool_bar_width - l_custom_widget.minimum_width)
							fixed.set_item_size (internal_title, a_width - tool_bar_width - l_custom_widget.minimum_width, a_height)
						else
							-- There is not enough space for mini tool bar.
							if not internal_tool_bar.has (mini_tool_bar_indicator) then
								internal_tool_bar.force (mini_tool_bar_indicator, 1)
								internal_tool_bar.compute_minimum_size
							end

							if fixed.has (l_custom_widget) then
								fixed.prune (l_custom_widget)
							end
							if a_width - tool_bar_width >= 0 then
								if internal_title.minimum_height < a_height then
									internal_title.set_minimum_height (a_height)
								end
								fixed.set_item_size (internal_title, a_width - tool_bar_width, a_height)
							end
						end
					end
				else
					if a_width - tool_bar_width >= 0 then
						if internal_title.minimum_height < a_height then
							internal_title.set_minimum_height (a_height)
						end
						fixed.set_item_size (internal_title, a_width - tool_bar_width, a_height)
						if internal_tool_bar.has (mini_tool_bar_indicator) then
							internal_tool_bar.prune (mini_tool_bar_indicator)
							internal_tool_bar.compute_minimum_size
						end
					end
				end

				fixed.set_item_x_position (internal_title, 0)
				if fixed.has (internal_tool_bar) then
					fixed.set_item_x_position (internal_tool_bar, a_width - tool_bar_width)
				end
			end
		end

	on_dpi_change_fixed_resize (a_dpi: NATURAL_32; a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32)
			-- Handle dpi changed actions.
		do
			on_fixed_resize (a_x, a_y, a_width, a_height)
		end

	on_stick_select
			-- Notify clients when user click stick button
		do
			if  is_stick then
				stick.set_pixmap (internal_shared.icons.unstick)
				if internal_shared.icons.unstick_buffer /= Void then
					stick.set_pixel_buffer (internal_shared.icons.unstick_buffer)
				end
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)
			else
				stick.set_pixmap (internal_shared.icons.stick)
				if internal_shared.icons.stick_buffer /= Void then
					stick.set_pixel_buffer (internal_shared.icons.stick_buffer)
				end
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick)
			end
			stick_select_actions.call (Void)
		end

	on_normal_max
			-- Handle `normal_max_actions'
		do
			if is_max then
				normal_max.set_pixmap (internal_shared.icons.maximize)
				if internal_shared.icons.maximize_buffer /= Void then
					normal_max.set_pixel_buffer (internal_shared.icons.maximize_buffer)
				end
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			else
				normal_max.set_pixmap (internal_shared.icons.normal)
				if internal_shared.icons.normal_buffer /= Void then
					normal_max.set_pixel_buffer (internal_shared.icons.normal_buffer)
				end
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			end

			normal_max_actions.call (Void)
		end

	on_close
			-- Handle `close_request_actions'
		do
			close_request_actions.call (Void)
		end

feature {NONE} -- Implementation

	ignore_resize: BOOLEAN
			-- If ignore resize actions?

	is_resizing: BOOLEAN
			-- If `update_fixed_size' or `internal_update_fixed_size' is executing

	internal_border: SD_CELL_WITH_BORDER
			-- Internal border

	internal_custom_widget: detachable EV_WIDGET
			-- Custom widget which is setted by client programmer

	internal_title: SD_TITLE_BAR_TITLE
			-- Internal_title

	internal_tool_bar: SD_TOOL_BAR
			-- Tool bar which hold `stick', `normal_max', `close' buttons

	tool_bar_width: INTEGER
			-- Actual width of `internal_tool_bar'
			-- If we query internal_tool_bar.width directly, we will always get maximum width on Windows.
		do
			Result := internal_tool_bar.minimum_width
		end

	stick: SD_TOOL_BAR_BUTTON
			-- Sitck button

	normal_max: SD_TOOL_BAR_BUTTON
			-- Minimize and maxmize button

	close: SD_TOOL_BAR_BUTTON
			-- Close button

	mini_tool_bar_indicator: SD_TOOL_BAR_BUTTON
			-- Factory method for `internal_mini_tool_bar_indicator'
		do
			Result := internal_mini_tool_bar_indicator
			if not attached Result then
				create Result.make
				internal_mini_tool_bar_indicator := Result
				Result.set_pixmap (internal_shared.icons.tool_bar_indicator)
				if internal_shared.icons.tool_bar_indicator_buffer /= Void then
					Result.set_pixel_buffer (internal_shared.icons.tool_bar_indicator_buffer)
				end
				Result.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_hidden_toolbar_indicator)
				Result.select_actions.extend (agent on_mini_tool_bar_indicator_clicked)
			end
		ensure
			not_void: Result /= Void
		end

	internal_update_fixed_size
			-- Different from `update_fixed_size', this feature will not force `internal_custom_widget' recalculate it's size
		do
			if not is_resizing then
				is_resizing := True
				-- If we use fixed.width (or fixed.height) here, the width is a little bit smaller than actual when called from SD_DOCKING_STATE.show.
				on_fixed_resize (0, 0, viewport.width, viewport.height)
				is_resizing := False
			end
		end

	internal_mini_tool_bar_indicator: detachable SD_TOOL_BAR_BUTTON
			-- Indicator for mini tool bar. Shown when not enough space for `internal_custom_widget'

	internal_shared: SD_SHARED
			-- All singletons

	viewport: EV_VIEWPORT
			-- Viewport which contain `fixed'

	fixed: EV_FIXED
			-- Fixed widget which contain `internal_custom_widget', `internal_title' and `internal_tool_bar'

	internal_stick_select_actions, internal_close_request_actions, internal_normal_max_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Title bar actions

	is_focused_color: BOOLEAN
			-- If Current use focused color?
			-- Otherwise we use non-focused color
		do
			Result := internal_title.is_focused_color
		end

	enable_focus_color_imp
			-- Enable focus color
		do
			if not is_focused_active_color_enable then
				internal_title.set_focus_color_enable (True)
				internal_title.set_focused_color (True)

				internal_title.set_focus_background_color
				internal_title.refresh

				internal_border.set_border_color (internal_title.hightlight_color)
				update_baseline
			end
		ensure
			focused_color_enabled: is_focused_active_color_enable
		end

	enable_non_focus_active_color_imp
			-- Enable non-focused active color
		do
			if not is_non_focused_active_color_enable  then
				internal_title.set_focus_color_enable (True)
				internal_title.set_focused_color (False)

				internal_title.set_non_focus_active_background_color
				internal_title.refresh

				internal_border.set_border_color (internal_title.hightlight_non_focus_color)
				update_baseline
			end
		ensure
			non_focused_active_color_enabled: is_non_focused_active_color_enable
		end

	disable_focus_color_imp
			-- Disable focus color
		do
			if is_focus_color_enable then
				internal_title.set_focus_color_enable (False)
				internal_title.set_disable_focus_background_color
				internal_title.refresh
				internal_border.set_border_color (internal_shared.border_color)
				update_baseline
			end
		ensure
			focused_color_enabled: not is_focus_color_enable
		end

	set_color_in_idle (a_agent: attached like last_color_setting_agent)
			-- Add `a_agent' to application idle actions and removed `last_color_setting_agent' if possible
		require
			not_void: a_agent /= Void
		do
			if environment_i.is_application_processor and then attached environment_i.application as a then
				if attached last_color_setting_agent as l_agent then
					a.remove_idle_action (l_agent)
				end
				last_color_setting_agent := a_agent
				a.do_once_on_idle (a_agent)
			else
				last_color_setting_agent := a_agent
			end
		ensure
			set: last_color_setting_agent = a_agent
		end

	last_color_setting_agent: detachable PROCEDURE
			--	Last agent, possibly one of `enable_focus_color_imp', `enable_non_focus_active_color_imp' and `disable_focus_color_imp'

	add_refresh_title_in_idle_action
			-- call `internal_title'.refresh in idle actions
		local
			l_agent: like title_bar_refresh_agent
		do
			if title_bar_refresh_agent = Void then
				l_agent := agent refresh_title_bar
				title_bar_refresh_agent := l_agent
				if attached (create {EV_ENVIRONMENT}).application as l_app then
					l_app.do_once_on_idle (l_agent)
				end
			end
		ensure
			created: title_bar_refresh_agent /= Void
		end

	title_bar_refresh_agent: detachable PROCEDURE
			-- Agent for refresh title bar

	refresh_title_bar
			-- Title bar refresh action in idle action
		require
			already_set: title_bar_refresh_agent /= Void
		do
			if attached internal_title as l_title and then not l_title.is_destroyed then
				l_title.refresh
			end
			title_bar_refresh_agent := Void
		ensure
			cleared: title_bar_refresh_agent = Void
		end

invariant

	internal_shared_not_void: internal_shared /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2020, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

