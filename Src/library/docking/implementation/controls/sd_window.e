indexing
	description: "Container used for hold SD_TITLE_BAR and SD_CONTENT's widget."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WINDOW

inherit
	EV_CELL
		rename
			has_focus as has_focus_cell
		end

create
	make

feature {NONE} -- Initlization

	make (a_style: INTEGER; a_zone: SD_ZONE) is
			-- Creation method.
		require
			a_zone_not_void: a_zone /= Void
			a_style_valid: a_style = {SD_WIDGET_FACTORY}.style_all_same or a_style = {SD_WIDGET_FACTORY}.style_different
		do
			default_create
			create internal_shared
			create internal_vertical_box

			internal_title_bar := internal_shared.widget_factory.title_bar (a_style, a_zone)
			internal_title_bar.set_minimum_height (internal_shared.title_bar_height)
			internal_title_bar.close_request_actions.extend (agent close)
			internal_title_bar.stick_select_actions.extend (agent stick)
			internal_title_bar.normal_max_actions.extend (agent on_normal_max_window)
			internal_title_bar.drag_actions.extend (agent drag_window)
			internal_title_bar.pointer_button_release_actions.extend (agent pointer_release)
			pointer_button_release_actions.extend (agent pointer_release)
			pointer_motion_actions.extend (agent pointer_motion)

			internal_vertical_box.extend (internal_title_bar)
			internal_vertical_box.disable_item_expand (internal_title_bar)

			create internal_border_box.make
			internal_border_box.set_border_style ({SD_DOCKING_MANAGER}.dock_top)
			internal_border_box.set_show_border ({SD_DOCKING_MANAGER}.dock_top, True)
			internal_border_box.set_border_width (internal_shared.focuse_border_width)
			internal_vertical_box.extend (internal_border_box)

			extend (internal_vertical_box)
			set_minimum_size (internal_shared.Zone_minmum_width, internal_shared.title_bar_height)
			internal_border_box.set_border_color (internal_shared.border_color)
		ensure
			extended: has (internal_vertical_box)
			extended: internal_vertical_box.has (internal_title_bar)
		end

feature   -- Access

	has_focus: BOOLEAN is
			-- Has focus?
		do
			Result := internal_title_bar.is_focus_color_enable
		end

	set_stick (a_bool: BOOLEAN) is
			-- Set whether current is sticked.
		do
			internal_title_bar.set_stick (a_bool)
		ensure
			set: a_bool = internal_title_bar.is_stick
		end

	title_bar: like internal_title_bar is
			-- Title bar which on the top.
		do
			Result := internal_title_bar
		end

	user_widget: like internal_user_widget assign set_user_widget is
			-- Client programmer's widget.
		do
			Result := internal_user_widget
		end

	set_user_widget (a_widget: like internal_user_widget) is
			-- Set the client programmer's widget.
		require
			a_widget_not_void: a_widget /= Void
		do
			internal_user_widget := a_widget
			internal_border_box.wipe_out
			if a_widget.parent /= Void then
				a_widget.parent.prune (a_widget)
			end
			internal_border_box.extend (a_widget)

		ensure
			contain_right_number_widget: internal_border_box.count = 1
			contain_user_wiget: internal_border_box.has (a_widget)
		end

feature {NONE} -- Two widgets

	internal_title_bar: SD_TITLE_BAR
			-- Title bar which above at top.

	internal_user_widget: EV_WIDGET
			-- SD_CONTENT's user_widget.

feature -- Basic operation

	set_show_normal_max (a_show: BOOLEAN) is
			-- Set show or not show normal\max button.
		do
			internal_title_bar.set_show_normal_max (a_show)
		ensure
			set: a_show = internal_title_bar.is_show_normal_max
		end

	is_show_normal_max: BOOLEAN is
			-- If titile bar show normal max button?
		do
			Result := internal_title_bar.is_show_normal_max
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Set show or not show stick button.
		do
			internal_title_bar.set_show_stick (a_show)
		ensure
			set: a_show = internal_title_bar.is_show_stick
		end

	set_focus_color (a_focus: BOOLEAN) is
			-- Set focus color of title bar and surround focus color.
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

	close_request_actions: like internal_close_request_actions is
			-- `internal_close_request_actions'
		do
			if internal_close_request_actions = Void then
				create internal_close_request_actions
			end
			Result := internal_close_request_actions
		ensure
			not_void: Result /= Void
		end

	stick_actions: like internal_stick_actions is
			-- `internal_stick_actions'
		do
			if internal_stick_actions = Void then
				create internal_stick_actions
			end
			Result := internal_stick_actions
		ensure
			not_void: Result /= Void
		end

	drag_actions: like internal_drag_actions is
			-- `internal_drag_actions'
		do
			if internal_drag_actions = Void then
				create internal_drag_actions
			end
			Result := internal_drag_actions
		ensure
			not_void: Result /= Void
		end

	normal_max_action: like internal_normal_max_action is
			-- `internal_normal_max_action'
		do
			if internal_normal_max_action = Void then
				create internal_normal_max_action
			end
			Result := internal_normal_max_action
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Implemention

	close is
			-- Handle close window,
		do
			close_request_actions.call ([])
		end

	on_normal_max_window is
			-- Handle normal\max window.
		do
			normal_max_action.call ([])
		end

	stick is
			-- Handle stick window.
		do
			stick_actions.call ([])
		end

	drag_window (a_x, a_y: INTEGER; tile_a, tile_b, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- Handle drag window.
		do
			drag_actions.call ([a_x, a_y, tile_a, tile_b, a_pressure, a_screen_x, a_screen_y])
		end

	pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
		end

	pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
		end

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.

	internal_close_request_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when close the window.

	internal_stick_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions performed when stick the window.

	internal_drag_actions: EV_POINTER_MOTION_ACTION_SEQUENCE
			-- Actions performed when drag the window.

	internal_normal_max_action: EV_NOTIFY_ACTION_SEQUENCE
			-- Actions perfromed when min/max window.

	internal_vertical_box: EV_VERTICAL_BOX
			-- Vertical box to hold SD_TITLE_BAR and user_widget.

--	internal_border_box: EV_CELL
	internal_border_box: SD_CELL_WITH_BORDER
			-- Box for border highlight.

invariant

	internal_shared_not_void: internal_shared /= Void
	internal_title_bar_not_void: internal_title_bar /= Void
	internal_vertical_box_not_void: internal_vertical_box /= Void

indexing
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
