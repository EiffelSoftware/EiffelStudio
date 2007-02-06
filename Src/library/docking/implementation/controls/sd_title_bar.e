indexing
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

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method.
		do
			create internal_shared
			default_create

			create fixed
			create internal_border.make

			extend (internal_border)

			internal_border.set_border_width (internal_shared.border_width)
			internal_border.set_border_color (internal_shared.border_color)
			internal_border.set_border_style ({SD_ENUMERATION}.bottom)

			create viewport
			internal_border.extend (viewport)
			viewport.set_minimum_height (internal_shared.title_bar_height - 1)
			viewport.extend (fixed)

			create internal_title.make
			internal_title.set_focused_color (True)
			fixed.extend (internal_title)

			create stick
			stick.set_pixmap (internal_shared.icons.unstick)
			stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)

			set_stick (False)

			create normal_max
			normal_max.set_pixmap (internal_shared.icons.maximize)
			normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			create close
			close.set_pixmap (internal_shared.icons.close)
			close.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_close)

			stick.select_actions.extend (agent on_stick_select)
			normal_max.select_actions.extend (agent on_normal_max)
			close.select_actions.extend (agent on_close)

			internal_title.pointer_double_press_actions.force_extend (agent on_normal_max)

			create internal_tool_bar
			internal_tool_bar.extend (stick)
			internal_tool_bar.extend (normal_max)
			internal_tool_bar.extend (close)

			fixed.extend (internal_tool_bar)

			-- default setting
		 	disable_focus_color
		 	viewport.resize_actions.extend (agent on_fixed_resize)
		end

feature -- Command

	set_title (a_title: STRING_GENERAL) is
			-- Set the title on the title bar.
		require
			a_title_not_void: a_title /= Void
		do
			internal_title.set_title (a_title)
			internal_title.refresh
		ensure
			set: internal_title.title = a_title
		end

	set_stick (a_stick: BOOLEAN) is
			-- Set `is_stick'.
		do
			if a_stick then
				stick.set_pixmap (internal_shared.icons.stick)
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick)
			else
				stick.set_pixmap (internal_shared.icons.unstick)
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)
			end
			is_stick := a_stick
		ensure
			set: a_stick = is_stick
		end

	set_max (a_max: BOOLEAN) is
			-- Set `is_max'.
		do
			if a_max then
				normal_max.set_pixmap (internal_shared.icons.normal)
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			else
				normal_max.set_pixmap (internal_shared.icons.maximize)
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			end
			is_max := a_max
		ensure
			set: is_max = a_max
		end

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
					internal_tool_bar.start
					internal_tool_bar.prune (normal_max)
				end
			end
			-- We restoring docking layout, `fixed' maybe destroyed.
			if not fixed.is_destroyed then
				internal_update_fixed_size
			end
		ensure
			set: a_show = internal_tool_bar.has (normal_max)
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
					internal_tool_bar.start
					internal_tool_bar.prune (stick)
				end
			end
			-- We restoring docking layout, `fixed' maybe destroyed.
			if not fixed.is_destroyed then
				internal_update_fixed_size
			end
		ensure
			set: a_show = internal_tool_bar.has (stick)
		end

	enable_focus_color is
			-- Enable focus color.
		do
			internal_title.set_focus_color_enable (True)
			internal_title.set_focused_color (True)

			internal_title.set_focus_background_color
			internal_title.refresh

			internal_border.set_border_color (internal_title.hightlight_color)
		ensure
			is_focus_color_enable_set: is_focus_color_enable
		end

	enable_non_focus_active_color is
			-- Enable non-focused active color.
		do

			internal_title.set_focus_color_enable (True)
			internal_title.set_focused_color (False)

			internal_title.set_non_focus_active_background_color
			internal_title.refresh

			internal_border.set_border_color (internal_title.hightlight_non_focus_color)
		end

	disable_focus_color is
			-- Disable focus color.

		do
			internal_title.set_focus_color_enable (False)
			internal_title.set_disable_focus_background_color
			internal_title.refresh
			internal_border.set_border_color (internal_shared.border_color)
		ensure
			is_focus_color_enable_set: not is_focus_color_enable
		end

	extend_custom_area (a_widget: EV_WIDGET) is
			-- Extend `custom_area' with a_widget
		do
			if internal_custom_widget /= a_widget and fixed.has (internal_custom_widget) then
				-- Prune the old one
				fixed.prune (internal_custom_widget)
			end
			internal_custom_widget := a_widget
			internal_update_fixed_size

			-- `a_widget' will not have resize actions since it was in EV_FIXED.
			--	a_widget.resize_actions.force_extend (agent update_fixed_size)
		ensure
			set: internal_custom_widget = a_widget
		end

	clear_custom_widget is
			-- Wipe out custom area.
		do
			fixed.prune (internal_custom_widget)
			internal_custom_widget := Void
			internal_update_fixed_size
		ensure
			wuped_out: internal_custom_widget = Void
		end

	update_fixed_size is
			-- Update fixed sizes.
			-- Different from `internal_update_fixed_size', this feature will force `internal_custom_widget' recalculate its size.
		do
			if not is_resizing then
				is_resizing := True
				-- This is to make sure item in `fixed' is resized, otherwise items inside mini tool bar size is incorrect
				if fixed.has (internal_custom_widget) then
					fixed.prune (internal_custom_widget)
				end
				on_fixed_resize (0, 0, fixed.width, fixed.height)
				is_resizing := False
			end
		end

	destroy is
			-- Destroy
		do
			Precursor {EV_HORIZONTAL_BOX}
			-- FIXIT: Vision2 bug
			-- If we don't destory it, it'll not be collected.
			internal_tool_bar.destroy
		end

feature -- Query

	title: STRING_GENERAL is
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

	is_show_normal_max: BOOLEAN is
			-- Show normal\max button?
		do
			Result := internal_tool_bar.has (normal_max)
		end

	is_show_stick: BOOLEAN is
			-- Show stick button?
		do
			Result := internal_tool_bar.has (stick)
		end

	is_focus_color_enable: BOOLEAN is
			-- If show highlight color now?
		do
			Result := internal_title.is_focus_color_enable
		end

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

	drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE is
			-- Drag actions.
		do
			Result := internal_title.drag_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Agents

	on_mini_tool_bar_indicator_clicked is
			-- Handle `mini_tool_bar_indicator' select actions.
		local
			l_dialog: SD_MINI_TOOL_BAR_DIALOG
			l_helper: SD_POSITION_HELPER
		do
			create l_dialog.make (internal_custom_widget)
			create l_helper.make
			l_helper.set_dialog_position (l_dialog, internal_tool_bar.screen_x, internal_tool_bar.screen_y)
			l_dialog.show
			l_dialog.set_focus
		end

	on_fixed_resize (a_x: INTEGER_32; a_y: INTEGER_32; a_width: INTEGER_32; a_height: INTEGER_32) is
			-- Handle fixed resize actions.
		do
			if a_width > 0 and a_height > 0 and not fixed.is_destroyed then
				fixed.set_minimum_width (a_width)
				viewport.set_item_width (a_width)

				if internal_custom_widget /= Void then
					if a_width >= tool_bar_width + internal_custom_widget.minimum_width + (internal_shared.highlight_before_width + internal_shared.highlight_tail_width) then
						-- There is enough space for mini tool bar.
						if internal_tool_bar.has (mini_tool_bar_indicator) then
							internal_tool_bar.prune (mini_tool_bar_indicator)
						end

						if not fixed.has (internal_custom_widget) then
							if internal_custom_widget.parent /= Void then
								internal_custom_widget.parent.prune (internal_custom_widget)
							end
							fixed.extend (internal_custom_widget)
						end
						fixed.set_item_x_position (internal_custom_widget, a_width - tool_bar_width - internal_custom_widget.minimum_width)
						fixed.set_item_size (internal_title, a_width - tool_bar_width - internal_custom_widget.minimum_width, a_height)
					else
						-- There is not enough space for mini tool bar.
						if not internal_tool_bar.has (mini_tool_bar_indicator) then
							internal_tool_bar.start
							internal_tool_bar.put_left (mini_tool_bar_indicator)
						end

						if fixed.has (internal_custom_widget) then
							fixed.prune (internal_custom_widget)
						end
						if a_width - tool_bar_width >= 0 then
							fixed.set_item_size (internal_title, a_width - tool_bar_width, a_height)
						end
					end
				else
					if a_width - tool_bar_width >= 0 then
						fixed.set_item_size (internal_title, a_width - tool_bar_width, a_height)
						if internal_tool_bar.has (mini_tool_bar_indicator) then
							internal_tool_bar.prune (mini_tool_bar_indicator)
						end
					end

				end

				fixed.set_item_x_position (internal_title, 0)
				fixed.set_item_x_position (internal_tool_bar, a_width - tool_bar_width)
			end
		end

	on_stick_select is
			-- Notify clients when user click stick button.
		do
			if  is_stick then
				stick.set_pixmap (internal_shared.icons.unstick)
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick_unpin)
			else
				stick.set_pixmap (internal_shared.icons.stick)
				stick.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_stick)
			end
			stick_select_actions.call ([])
		end

	on_normal_max is
			-- Handle `normal_max_actions'.
		do
			if is_max then
				normal_max.set_pixmap (internal_shared.icons.maximize)
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_maximize)
			else
				normal_max.set_pixmap (internal_shared.icons.normal)
				normal_max.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_restore)
			end

			normal_max_actions.call ([])
		end

	on_close is
			-- Handle `close_request_actions'.
		do
			close_request_actions.call ([])
		end

feature {NONE} -- Implementation

	ignore_resize: BOOLEAN
			-- If ignore resize actions?

	is_resizing: BOOLEAN
			-- If `update_fixed_size' or `internal_update_fixed_size' is executing.

	internal_border: SD_CELL_WITH_BORDER
			-- Internal border

	internal_custom_widget: EV_WIDGET
			-- Custom widget which is setted by client programmer.

	internal_title: SD_TITLE_BAR_TITLE
			-- Internal_title

	internal_tool_bar: EV_TOOL_BAR
			-- Tool bar which hold `stick', `normal_max', `close' buttons.

	tool_bar_width: INTEGER is
			-- Actual width of `internal_tool_bar'
			-- If we query internal_tool_bar.width directly, we will always get maximum width on Windows.
		do
			from
				internal_tool_bar.start
			until
				internal_tool_bar.after
			loop
				Result := Result + internal_tool_bar.item.width
				internal_tool_bar.forth
			end
		end

	stick: EV_TOOL_BAR_BUTTON
			-- Sitck button

	normal_max: EV_TOOL_BAR_BUTTON
			-- Minimize and maxmize button

	close: EV_TOOL_BAR_BUTTON
			-- Close button

	mini_tool_bar_indicator: EV_TOOL_BAR_BUTTON is
			-- Factory method for `internal_mini_tool_bar_indicator'.
		do
			if internal_mini_tool_bar_indicator = Void then
				create internal_mini_tool_bar_indicator
				internal_mini_tool_bar_indicator.set_pixmap (internal_shared.icons.tool_bar_indicator)
				internal_mini_tool_bar_indicator.set_tooltip (internal_shared.interface_names.tooltip_mini_toolbar_hidden_toolbar_indicator)
				internal_mini_tool_bar_indicator.select_actions.extend (agent on_mini_tool_bar_indicator_clicked)
			end
			Result := internal_mini_tool_bar_indicator
		ensure
			not_void: Result /= Void
		end

	internal_update_fixed_size is
			-- Different from `update_fixed_size', this feature will not force `internal_custom_widget' recalculate it's size.
		do
			if not is_resizing then
				is_resizing := True
				on_fixed_resize (0, 0, fixed.width, fixed.height)
				is_resizing := False
			end
		end

	internal_mini_tool_bar_indicator: EV_TOOL_BAR_BUTTON
			-- Indicator for mini tool bar. Shown when not enough space for `internal_custom_widget'.

	internal_shared: SD_SHARED
			-- All singletons

	viewport: EV_VIEWPORT
			-- Viewport which contain `fixed'.

	fixed: EV_FIXED
			-- Fixed widget which contain `internal_custom_widget', `internal_title' and `internal_tool_bar'.

	internal_pointer_double_press_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Pointer double press actions.

	internal_stick_select_actions, internal_close_request_actions, internal_normal_max_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Title bar actions.

	is_focused_color: BOOLEAN is
			-- If Current use focused color?
			-- Otherwise we use non-focused color.
		do
			Result := internal_title.is_focused_color
		end

invariant

	internal_shared_not_void: internal_shared /= Void

indexing
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end

