indexing
	description: "Zone that hold EV_TOOL_BAR_BUTTONs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ZONE

inherit
	SD_HOR_VER_BOX
		rename
			extend as extend_hor_ver_box,
			change_direction as change_direction_hor_ver_box,
			is_vertical as is_vertical_hor_ver_box
		end

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			internal_docking_manager := a_docking_manager
			init (a_vertical)
			is_vertical := a_vertical
			create internal_tool_bar_items.make (1)
			create internal_drag_area

			background_color_internal := background_color
			init_a_dot
			internal_drag_area.set_minimum_size (10, 10)
			internal_drag_area.set_background_color (background_color_internal)
			internal_drag_area.expose_actions.extend (agent on_redraw_drag_area)
			internal_drag_area.pointer_button_press_actions.extend (agent on_drag_area_pressed)
			internal_drag_area.pointer_motion_actions.force_extend (agent on_drag_area_motion)
			internal_drag_area.pointer_button_release_actions.extend (agent on_drag_area_release)
			internal_drag_area.set_pointer_style (default_pixmaps.sizeall_cursor)
			extend_hor_ver_box (internal_drag_area)
			disable_item_expand (internal_drag_area)

			if not a_vertical then
				create internal_horizontal_bar
				extend_hor_ver_box (internal_horizontal_bar)
			end

			pointer_motion_actions.extend (agent on_pointer_motion)
			pointer_button_release_actions.extend (agent on_pointer_release)
		ensure
			set: is_vertical = a_vertical
			actions_added: internal_drag_area.expose_actions.count = 1 and internal_drag_area.pointer_button_press_actions.count = 1
				and internal_drag_area.pointer_motion_actions.count = 1 and internal_drag_area.pointer_button_release_actions.count = 1
				and pointer_motion_actions.count = 1 and pointer_button_release_actions.count = 1
			pointer_style_set: internal_drag_area.pointer_style = default_pixmaps.sizeall_cursor
			extended: has (internal_horizontal_bar)
			set: internal_docking_manager = a_docking_manager
		end

feature -- Basic operation

	change_direction is
			-- Change layout direction.
		do
			wipe_out
			change_direction_hor_ver_box
			extend_hor_ver_box (internal_drag_area)
			disable_item_expand (internal_drag_area)

			if is_vertical then
				-- Change to horizontal
				create internal_horizontal_bar
				extend_hor_ver_box (internal_horizontal_bar)
			else
				-- Change to vertical
			end
			is_vertical := not is_vertical

			extend (content)

		ensure
			direction_changed: old is_vertical /= is_vertical
		end

	float is
			-- Float.
		do
			if row /= Void then
				row.prune (Current)
				if row.count = 0 then
					row.parent.prune (row)
					internal_docking_manager.command.resize
				end
			end

			if is_vertical then
				change_direction
			end

			create internal_floating_menu.make (internal_docking_manager)
			internal_floating_menu.extend (Current)
			internal_floating_menu.show
			internal_docking_manager.menu_manager.floating_menus.extend (internal_floating_menu)
		ensure
			pruned: row /= Void implies not row.has (Current)
			extended: internal_floating_menu.has (Current)
		end

	dock is
			-- Dock to a menu area.
		require
			is_floating: is_floating
		do
			internal_docking_manager.menu_manager.floating_menus.prune_all (internal_floating_menu)
			internal_floating_menu.prune (Current)
			internal_floating_menu.destroy
			internal_floating_menu := Void
		ensure
			pruned: internal_floating_menu =  Void
		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position when `is_floating'.
		require
			is_floating: is_floating
		do
			internal_floating_menu.set_position (a_screen_x, a_screen_y)
		ensure
			set: internal_floating_menu.screen_x = a_screen_x and internal_floating_menu.screen_y = a_screen_y
		end

	set_row (a_row: like row) is
			-- Set `row'
		require
			a_row_not_void: a_row /= Void
		do
			row := a_row
		ensure
			set: row = a_row
		end

	extend (a_content: SD_MENU_CONTENT) is
			-- Extend `a_content'.
		require
			a_content_not_void: a_content /= Void
			content_not_set: content = Void or a_content = content
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			debug ("docking")
				io.put_string ("%N SD_MENU_ZONE extend IGNINIDNIGDIG START")
			end
			content := a_content
			l_items := a_content.menu_items
			from
				l_items.start
			until
				l_items.after
			loop
				if l_items.item.parent /= Void then
					l_items.item.parent.prune (l_items.item)
				end
				extend_one_item (l_items.item)

				l_items.forth
			end
			debug ("docking")
				io.put_string ("%N SD_MENU_ZONE extend IGNINIDNIGDIG END")
			end
		ensure
			set: content = a_content
		end

feature -- States report

	is_floating: BOOLEAN is
			-- If `Current' floating?
		do
			Result := internal_floating_menu /= Void
		end

	is_vertical: BOOLEAN
		-- Is `Current' vertical layout or horizontal layout?

	content: SD_MENU_CONTENT
		-- Content in `Current'.

	tool_bar_items: like internal_tool_bar_items is
			-- Tool bar items on `Current'.
		do
			Result := internal_tool_bar_items
		ensure
			not_void: Result /= Void
		end

	row: SD_MENU_ROW
			-- Parent which containe `Current'.

feature {NONE} -- Agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw drag area.
		local
			i, l_interval : INTEGER
		do
			if not is_vertical then
				l_interval := internal_drag_area.height
			else
				l_interval := internal_drag_area.width
			end
			internal_drag_area.clear
			from
				i := 2
			until
				i > l_interval - 3
			loop
				if not is_vertical then
					internal_drag_area.draw_pixmap (4, i, bar_dot)
				else
					internal_drag_area.draw_pixmap (i, 4, bar_dot)
				end
				i := i + 4
			end
		end

	on_drag_area_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area pressed.
		do
			if a_button = 1 then
				internal_pointer_pressed := True
				internal_docker_mediator := Void
			end
		ensure
			pointer_press_set: a_button = 1 implies internal_pointer_pressed = True
			docker_mediaot_void: internal_docker_mediator = Void
		end

	on_drag_area_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle drag area release.
		do
			if a_button = 1 then
				internal_pointer_pressed := False
				internal_docker_mediator := Void
			end
		ensure
			pointer_press_set: a_button = 1 implies internal_pointer_pressed = False
			docker_mediaot_void: internal_docker_mediator = Void
		end

	on_drag_area_motion is
			-- Handle drag area motion.
		do
			if internal_pointer_pressed then
				enable_capture
				create internal_docker_mediator.make (Current, internal_docking_manager)
			end
		ensure
			capture_enable: internal_pointer_pressed implies has_capture and internal_docker_mediator /= Void
		end

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer motion.
		do
			internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
		ensure
			pointer_motion_forwarded:
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Handle pointer release.
		do
			disable_capture
			internal_pointer_pressed := False
		ensure
			disable_capture: not has_capture
			not_pointer_pressed: not internal_pointer_pressed
		end

feature {NONE} -- Implmentation

	extend_one_item (a_item: EV_TOOL_BAR_ITEM) is
			-- Extend `a_item'.
		require
			a_item_not_void: a_item /= Void
		local
			l_tool_bar: EV_TOOL_BAR
			l_item: EV_TOOL_BAR_ITEM
			l_ev_sep: EV_TOOL_BAR_SEPARATOR
			l_sd_sep: SD_TOOL_BAR_SEPARATOR
			l_hbox: EV_HORIZONTAL_BOX
		do
			debug ("docking")
				io.put_string ("%N SD_MENU_ZONE extend a_item")
			end
			l_item := a_item
			l_ev_sep ?= l_item
			if is_vertical then
				if l_ev_sep = Void then
					create l_tool_bar
					l_tool_bar.extend (l_item)
					extend_hor_ver_box (l_tool_bar)
				else
					create l_hbox
					create l_sd_sep.make (background_color_internal, not is_vertical, internal_shared.separator_width)
					l_hbox.extend (l_sd_sep)
					extend_hor_ver_box (l_hbox)
				end
			else
				if l_ev_sep = Void then
					internal_horizontal_bar.extend (l_item)
				else
					create l_hbox
					create l_sd_sep.make (background_color_internal, not is_vertical, internal_shared.separator_width)
					l_hbox.extend (l_sd_sep)
					extend_hor_ver_box (l_hbox)
					create internal_horizontal_bar
					extend_hor_ver_box (internal_horizontal_bar)
				end
			end
		end

	internal_pointer_pressed: BOOLEAN
			-- If pointer pressed?

	internal_shared: SD_SHARED
			-- All singletons.

	internal_docker_mediator: SD_MENU_DOCKER_MEDIATOR
			-- Docker mediator.

	internal_tool_bar_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			-- Tool bar items.

	internal_horizontal_bar: EV_TOOL_BAR
			-- When `Current' is horizontal, use this to hold EV_TOOL_BAR_ITEM.

	internal_drag_area: EV_DRAWING_AREA
			-- Drag area which at beginning.

	bar_dot: EV_PIXMAP
			-- 9 colors on a dot.

	background_color_internal: EV_COLOR
			-- Backgroud color

	internal_floating_menu: SD_FLOATING_MENU_ZONE
			-- Floating menu zone which contain `Current' when floating.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

feature {NONE} -- Drawing.

	init_a_dot is
			-- Init colors of a shadowed dot.
		local
			l_color: EV_COLOR
			l_red, l_blue, l_green: REAL
		do
			create bar_dot.make_with_size (3, 3)

			l_red := background_color_internal.red * 0.95
			l_green := background_color_internal.green * 0.95
			l_blue := background_color_internal.blue * 0.95
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 0)

			l_red := background_color_internal.red * 0.83
			l_green := background_color_internal.green * 0.83
			l_blue := background_color_internal.blue * 0.83
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 1)

			l_red := background_color_internal.red * 0.94
			l_green := background_color_internal.green * 0.94
			l_blue := background_color_internal.blue * 0.94
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (0, 2)

			l_red := background_color_internal.red * 0.80
			l_green := background_color_internal.green * 0.80
			l_blue := background_color_internal.blue * 0.80
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 0)

			l_red := 1 - background_color_internal.red * 0.45
			l_green := 1 - background_color_internal.green * 0.45
			l_blue := 1 - background_color_internal.blue * 0.45
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 1)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (1, 2)

			l_red := background_color_internal.red * 0.97
			l_green := background_color_internal.green * 0.97
			l_blue := background_color_internal.blue * 0.96
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 0)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 1)

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			bar_dot.draw_point (2, 2)
		end

invariant

		internal_shared_not_void: internal_shared /= Void
		internal_tool_bar_items_not_void:	internal_tool_bar_items /= Void
		internal_drag_area_not_void: internal_drag_area /= Void

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
