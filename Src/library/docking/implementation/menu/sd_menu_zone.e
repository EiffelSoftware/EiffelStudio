indexing
	description: "Objects that hold EV_TOOL_BAR_BUTTONs."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_ZONE
-- Do NOT need to inherit from SD_ZONE. It's another system.
inherit
	SD_HOR_VER_BOX
		rename
			extend as extend_hor_ver_box,
			change_direction as change_direction_hor_ver_box
		end

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN) is
			-- Creation method
		local
--			l_test_item: EV_TOOL_BAR_BUTTON
		do
			create internal_shared
			init (a_vertical)
			internal_vertical := a_vertical
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
		end

feature -- Basic operation

	change_direction is
			--
		local
--			l_tool_bar_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do


--			l_tool_bar_items := tool_bar_items
			wipe_out
			change_direction_hor_ver_box
			extend_hor_ver_box (internal_drag_area)
			disable_item_expand (internal_drag_area)

			if internal_vertical then
				-- Change to horizontal
				create internal_horizontal_bar
				extend_hor_ver_box (internal_horizontal_bar)

			else
				-- Change to vertical

			end
			internal_vertical := not internal_vertical

			debug ("larry")
				io.put_string ("%N SD_MENU_ZONE change direction &&&&&&&&&&&&&&&&&&&&&&&&&&")
				io.put_string ("Manu is here%N")
			end
			extend (content)

			debug ("larry")
				io.put_string ("%N SD_MENU_ZONE change direction after")
			end
		end

	float is
			--
		do
			if row /= Void then
				row.prune (Current)
				if row.count = 0 then
					row.parent.prune (row)
				end
			end

			if internal_vertical then
				change_direction
			end

			create internal_floating_menu.make
			internal_floating_menu.extend (Current)
			internal_floating_menu.show
			internal_shared.docking_manager.menu_manager.floating_menus.extend (internal_floating_menu)
		end

	dock is
			-- Change from float state to dock state.
		require
			is_floating: is_floating
		do
			internal_shared.docking_manager.menu_manager.floating_menus.prune_all (internal_floating_menu)
			internal_floating_menu.prune (Current)
			internal_floating_menu.destroy
			internal_floating_menu := Void
		end

	set_row_position (a_x_or_y: INTEGER) is
			-- Set position when `Current' not floating.
		do

		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			--
		require
			is_floating: is_floating
		do

			internal_floating_menu.set_position (a_screen_x, a_screen_y)
		end

feature -- States report

	is_floating: BOOLEAN is
			--
		do
			Result := internal_floating_menu /= Void
		end

feature -- Access

	content: SD_MENU_CONTENT
		--

	tool_bar_items: like internal_tool_bar_items is
			--
		do
			Result := internal_tool_bar_items
		ensure
			not_void: Result /= Void
		end

	extend (a_content: SD_MENU_CONTENT) is
			--
		require
			a_content_not_void: a_content /= Void
			content_not_set: content = Void or a_content = content
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
		do
			io.put_string ("Manu is here too%N")
			debug ("larry")
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
			debug ("larry")
				io.put_string ("%N SD_MENU_ZONE extend IGNINIDNIGDIG END")
			end
		ensure
			set: content = a_content
		end

	row: like internal_row is
			--
		do
			Result := internal_row
		end

	set_row (a_row: like internal_row) is
			--
		do
			internal_row := a_row
		end

feature -- States reports

	is_vertical: BOOLEAN is
			-- `internal_vertical'
		do
			Result := internal_vertical
		end

feature {NONE} -- Implementation for agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			--
		local
			i, l_height : INTEGER
		do
			l_height := internal_drag_area.height
			internal_drag_area.clear
			from
				i := 2
			until
				i > l_height - 3
			loop
				internal_drag_area.draw_pixmap (4, i, bar_dot)
				i := i + 4
			end
		end

	on_drag_area_pressed (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if a_button = 1 then
				internal_pointer_pressed := True
				internal_docker_mediator := Void
			end
		end

	on_drag_area_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			if a_button = 1 then
				internal_pointer_pressed := False
				internal_docker_mediator := Void
			end
		end

	on_drag_area_motion is
			--
		do
			if internal_pointer_pressed then
				enable_capture
				create internal_docker_mediator.make (Current)
			end
		end

	internal_pointer_pressed: BOOLEAN

	on_pointer_motion (a_x: INTEGER; a_y: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			internal_docker_mediator.on_pointer_motion (a_screen_x, a_screen_y)
		end

	on_pointer_release (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			--
		do
			disable_capture
			internal_pointer_pressed := False
		end

feature {NONE} -- Implmentation

	extend_one_item (a_item: EV_TOOL_BAR_ITEM) is
			--
		require
			a_item_not_void: a_item /= Void
		local
			l_tool_bar: EV_TOOL_BAR
		do
			debug ("larry")
				io.put_string ("%N SD_MENU_ZONE extend a_item")
			end
			if not internal_tool_bar_items.has (a_item) then
				internal_tool_bar_items.extend (a_item)
			end

			if internal_vertical then
				create l_tool_bar
				l_tool_bar.extend (a_item)
				extend_hor_ver_box (l_tool_bar)
			else
				internal_horizontal_bar.extend (a_item)
			end
		end

	internal_shared: SD_SHARED

	internal_docker_mediator: SD_MENU_DOCKER_MEDIATOR

	internal_vertical: BOOLEAN
			-- Is `Current' vertically or horizontal?

	internal_tool_bar_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]

	internal_horizontal_bar: EV_TOOL_BAR
			-- When `Current' is horizontal, use this to hold EV_TOOL_BAR_ITEM.

	internal_drag_area: EV_DRAWING_AREA

	internal_row: SD_MENU_ROW
			-- SD_MENU_ROW which containe `Current'.

	bar_dot: EV_PIXMAP
			-- 9 colors on a dot.

	background_color_internal: EV_COLOR
			-- Backgroud color

--	internal_floating_menu: EV_UNTITLED_DIALOG
--	internal_floating_menu: EV_POPUP_WINDOW
	internal_floating_menu: SD_FLOATING_MENU_ZONE
			-- Floating menu zone which contain `Current' when floating.

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
			if not internal_vertical then
				bar_dot.draw_point (0, 0)
			else
				bar_dot.draw_point (0, 0)
			end


			l_red := background_color_internal.red * 0.83
			l_green := background_color_internal.green * 0.83
			l_blue := background_color_internal.blue * 0.83
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (0, 1)
			else
				bar_dot.draw_point (1, 0)
			end

			l_red := background_color_internal.red * 0.94
			l_green := background_color_internal.green * 0.94
			l_blue := background_color_internal.blue * 0.94
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (0, 2)
			else
				bar_dot.draw_point (2, 0)
			end

			l_red := background_color_internal.red * 0.80
			l_green := background_color_internal.green * 0.80
			l_blue := background_color_internal.blue * 0.80
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (1, 0)
			else
				bar_dot.draw_point (0, 1)
			end

			l_red := 1 - background_color_internal.red * 0.45
			l_green := 1 - background_color_internal.green * 0.45
			l_blue := 1 - background_color_internal.blue * 0.45
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (1, 1)
			else
				bar_dot.draw_point (1, 1)
			end

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (1, 2)
			else
				bar_dot.draw_point (2, 1)
			end

			l_red := background_color_internal.red * 0.97
			l_green := background_color_internal.green * 0.97
			l_blue := background_color_internal.blue * 0.96
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (2, 0)
			else
				bar_dot.draw_point (0, 2)
			end

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (2, 1)
			else
				bar_dot.draw_point (1, 2)
			end

			l_red := 1
			l_green := 1
			l_blue := 1
			create l_color.make_with_rgb (l_red, l_green, l_blue)
			bar_dot.set_foreground_color (l_color)
			if not internal_vertical then
				bar_dot.draw_point (2, 2)
			else
				bar_dot.draw_point (2, 2)
			end
		end
end
