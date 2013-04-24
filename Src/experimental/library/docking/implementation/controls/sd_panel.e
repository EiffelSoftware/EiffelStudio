note
	description: "Container used for hold SD_TITLE_BAR and SD_CONTENT's widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_PANEL

inherit
	EV_VERTICAL_BOX
		rename
			has_focus as has_focus_vertical_box
		end

create
	make

feature {NONE} -- Initlization

	make (a_style: INTEGER; a_zone_type: INTEGER)
			-- Creation method
		require
			a_style_valid: a_style = {SD_WIDGET_FACTORY}.style_all_same or a_style = {SD_WIDGET_FACTORY}.style_different
			a_zone_type_valid: a_zone_type = {SD_ENUMERATION}.docking or a_zone_type = {SD_ENUMERATION}.tab or a_zone_type = {SD_ENUMERATION}.auto_hide
		local
			l_zone_type: INTEGER
		do
			create internal_shared
			create internal_border_box.make
			l_zone_type := a_zone_type

			internal_title_bar := internal_shared.widget_factory.title_bar (a_style, l_zone_type)

			default_create

			internal_title_bar.set_minimum_height (internal_shared.title_bar_height)
			internal_title_bar.close_request_actions.extend (agent close)
			internal_title_bar.stick_select_actions.extend (agent stick)
			internal_title_bar.normal_max_actions.extend (agent on_normal_max_window)
			internal_title_bar.drag_actions.extend (agent drag_window)
			internal_title_bar.pointer_button_release_actions.extend (agent pointer_release)
			pointer_button_release_actions.extend (agent pointer_release)
			pointer_motion_actions.extend (agent pointer_motion)

			extend (internal_title_bar)
			disable_item_expand (internal_title_bar)

			internal_border_box.set_border_style ({SD_ENUMERATION}.top)
			internal_border_box.set_show_border ({SD_ENUMERATION}.top, True)
			internal_border_box.set_border_width (internal_shared.focuse_border_width)

			extend (internal_border_box)

			set_minimum_size (internal_shared.zone_minimum_width, internal_shared.title_bar_height)
			internal_border_box.set_border_color (internal_shared.border_color)
		ensure
			extended: has (internal_title_bar)
		end

feature   -- Access

	has_focus: BOOLEAN
			-- Has focus?
		do
			Result := internal_title_bar.is_focus_color_enable
		end

	set_stick (a_bool: BOOLEAN)
			-- Set whether current is sticked
		do
			internal_title_bar.set_stick (a_bool)
		ensure
			set: a_bool = internal_title_bar.is_stick
		end

	title_bar: like internal_title_bar
			-- Title bar which on the top
		do
			Result := internal_title_bar
		end

	user_widget: like internal_user_widget assign set_user_widget
			-- Client programmer's widget
		do
			Result := internal_user_widget
		end

	set_user_widget (a_widget: like internal_user_widget)
			-- Set client programmer's widget
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_user_widget := a_widget
			internal_border_box.wipe_out
			if attached a_widget.parent as l_parent then
				l_parent.prune (a_widget)
			end
			internal_border_box.extend (a_widget)

		ensure
			contain_right_number_widget: internal_border_box.count = 1
			contain_user_wiget: internal_border_box.has (a_widget)
		end

	set_mini_toolbar (a_widget: EV_WIDGET)
			-- Set mini toolbar with {SD_CONTENT}.mini_toolbar
		do
			title_bar.extend_custom_area (a_widget)
		end

feature {NONE} -- Two widgets

	internal_title_bar: SD_TITLE_BAR
			-- Title bar which above at top

	internal_user_widget: detachable EV_WIDGET
			-- SD_CONTENT's user_widget

feature -- Basic operation

	set_show_normal_max (a_show: BOOLEAN)
			-- Set show or not show normal\max button
		do
			internal_title_bar.set_show_normal_max (a_show)
		ensure
			set: a_show = internal_title_bar.is_show_normal_max
		end

	is_show_normal_max: BOOLEAN
			-- If titile bar show normal max button?
		do
			Result := internal_title_bar.is_show_normal_max
		end

	set_show_stick (a_show: BOOLEAN)
			-- Set show or not show stick button
		do
			internal_title_bar.set_show_stick (a_show)
		ensure
			set: a_show = internal_title_bar.is_show_stick
		end

	set_focus_color (a_focus: BOOLEAN)
			-- Set focus color of title bar and surround focus color
		do
			if a_focus then
				title_bar.enable_focus_color
				internal_border_box.set_border_color (internal_shared.focused_color)
			else
				title_bar.disable_focus_color
				internal_border_box.set_border_color (internal_shared.border_color)
			end
		end

feature -- Actions

	close_request_actions: attached like internal_close_request_actions
			-- `internal_close_request_actions'
		local
			l_actions: like internal_close_request_actions
		do
			l_actions := internal_close_request_actions
			if l_actions = Void then
				create l_actions
				internal_close_request_actions := l_actions
			end
			Result := l_actions
		ensure
			not_void: Result /= Void
		end

	stick_actions: attached like internal_stick_actions
			-- `internal_stick_actions'
		local
			l_actions: like internal_stick_actions
		do
			l_actions := internal_stick_actions
			if l_actions = Void then
				create l_actions
				internal_stick_actions := l_actions
			end
			Result := l_actions
		ensure
			not_void: Result /= Void
		end

	drag_actions: attached like internal_drag_actions
			-- `internal_drag_actions'
		local
			l_actions: like internal_drag_actions
		do
			l_actions := internal_drag_actions
			if l_actions = Void then
				create l_actions
				internal_drag_actions := l_actions
			end
			Result := l_actions
		ensure
			not_void: Result /= Void
		end

	normal_max_action: attached like internal_normal_max_action
			-- `internal_normal_max_action'
		local
			l_actions: like internal_normal_max_action
		do
			l_actions := internal_normal_max_action
			if l_actions = Void then
				create l_actions
				internal_normal_max_action := l_actions
			end
			check l_actions /= Void end -- Implied by previous if clause
			Result := l_actions
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implemention

	close
			-- Handle close window
		do
			close_request_actions.call (Void)
		end

	on_normal_max_window
			-- Handle normal\max window
		do
			normal_max_action.call (Void)
		end

	stick
			-- Handle stick window
		do
			stick_actions.call (Void)
		end

	drag_window (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER)
			-- Handle drag window
		do
			drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
		end

	pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer motion
		do
		end

	pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- Handle pointer release
		do
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

	internal_close_request_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when close the window

	internal_stick_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when stick the window

	internal_drag_actions: detachable EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions performed when drag the window

	internal_normal_max_action: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- Actions perfromed when min/max window

	internal_border_box: SD_CELL_WITH_BORDER
			-- Box for border highlight

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_title_bar_not_void: internal_title_bar /= Void

note
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
