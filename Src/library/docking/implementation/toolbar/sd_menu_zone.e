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
		export
			{NONE} all
			{ANY} x_position, y_position, minimum_width, set_minimum_width, minimum_height, set_minimum_height, parent, height, has, enable_capture, disable_capture, has_capture, pointer_motion_actions, pointer_button_release_actions, set_pointer_style
			{SD_MENU_ZONE_ASSISTANT, SD_FLOATING_MENU_ZONE} wipe_out
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
			create drag_area

			background_color_internal := background_color
			create internal_menu_dot_drawer.make (background_color_internal)
			create bar_dot.make_with_size (3, 3)
			internal_menu_dot_drawer.draw (bar_dot)

			init_drag_area

			create sizer.make (Current)
		ensure
			set: is_vertical = a_vertical
			pointer_style_set: drag_area.pointer_style = default_pixmaps.sizeall_cursor
			set: internal_docking_manager = a_docking_manager
		end

	init_drag_area is
			-- Initlization of `drag_area'.
		do
			drag_area.set_minimum_size (10, 10)
			drag_area.set_background_color (background_color_internal)
			drag_area.expose_actions.extend (agent on_redraw_drag_area)

			create internal_agents.make (internal_docking_manager, Current)
			drag_area.pointer_button_press_actions.extend (agent internal_agents.on_drag_area_pressed)
			drag_area.pointer_motion_actions.extend (agent internal_agents.on_drag_area_motion)
			drag_area.pointer_button_release_actions.extend (agent internal_agents.on_drag_area_release)
			drag_area.set_pointer_style (default_pixmaps.sizeall_cursor)
			extend_hor_ver_box (drag_area)
			disable_item_expand (drag_area)
		end

feature -- Command

	change_direction is
			-- Change layout direction.
		do
			wipe_out
			change_direction_hor_ver_box
			extend_hor_ver_box (drag_area)
			disable_item_expand (drag_area)

			if is_vertical then
				-- Change to horizontal
				create internal_horizontal_tool_bar
				extend_hor_ver_box (internal_horizontal_tool_bar)
			else
				-- Change to vertical
			end
			is_vertical := not is_vertical

			extend (content)

			sizer.update_indicator
		ensure
			direction_changed: old is_vertical /= is_vertical
		end

	float is
			-- Float.
		do
			if row /= Void then
				row.prune (Current)
				if row.count = 0 then
					if row.parent /= Void then
						row.parent.prune (row)
						internal_docking_manager.command.resize
					end
				end
			end

			if is_vertical then
				change_direction
			end

			wipe_out
			create floating_menu.make (internal_docking_manager)
			if parent /= Void then
				parent.prune (Current)
			end
			floating_menu.extend (Current)

			drag_area.hide
			internal_tail_tool_bar.hide
			floating_menu.show

			internal_docking_manager.menu_manager.floating_menus.extend (floating_menu)

			sizer.update_indicator
		ensure
			pruned: row /= Void implies not row.has (Current)
--			extended: floating_menu.has (Current)
		end

	dock is
			-- Dock to a menu area.
		require
			is_floating: is_floating
		do
			internal_docking_manager.menu_manager.floating_menus.prune_all (floating_menu)
			floating_menu.prune (Current)
			floating_menu.destroy
			floating_menu := Void

			extend_hor_ver_box (drag_area)
			drag_area.show
			extend (content)
--			extend_hor_ver_box (internal_tail_tool_bar)
--			internal_tail_tool_bar.hide
		ensure
			pruned: floating_menu =  Void
		end

	extend (a_content: SD_MENU_CONTENT) is
			-- Extend `a_content'.
		require
			a_content_not_void: a_content /= Void
			content_not_set: content = Void or a_content = content
		local
			l_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]
			l_test_cell: EV_CELL
		do
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

			create internal_tail_tool_bar

			-- Test
			create l_test_cell
			extend_hor_ver_box (l_test_cell)
			l_test_cell.extend (internal_tail_tool_bar)
--			extend_hor_ver_box (internal_tail_tool_bar)


			create internal_tail_indicator
				internal_tail_indicator.set_pixmap (internal_shared.icons.menu_customize_indicator)
				internal_tail_indicator.select_actions.extend (agent sizer.on_tail_indicator_selected)

-- FIXIT: bugs in EV_TOOL_BAR
			internal_tail_tool_bar.extend (internal_tail_indicator)

--			disable_item_expand (internal_tail_tool_bar)
-- If follow line move to above comment line position. It'll show different behaviour.
			internal_tail_tool_bar.disable_vertical_button_style

--			internal_tail_tool_bar.set_minimum_height (16)

			if is_vertical then
				maximize_size := height
			else
				maximize_size := width
			end

		ensure
			set: content = a_content
		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position when `is_floating'.
		require
			is_floating: is_floating
		do
			floating_menu.set_position (a_screen_x, a_screen_y)
		ensure
			set: floating_menu.screen_x = a_screen_x and floating_menu.screen_y = a_screen_y
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

feature -- Query

	is_floating: BOOLEAN is
			-- If `Current' floating?
		do
			Result := floating_menu /= Void
		end

	is_vertical: BOOLEAN
			-- Is `Current' vertical layout or horizontal layout?

	content: SD_MENU_CONTENT
			-- Content in `Current'.

	tool_bar_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM] is
			-- Tool bar items on `Current'.
		do
			Result := content.menu_items
		ensure
			not_void: Result /= Void
		end

	row: SD_MENU_ROW
			-- Parent which contain `Current'.

	maximize_size: INTEGER
			-- Maximize width of Current if not `is_vertical'. Maximize height of Current if `is_vertical'.

	size: INTEGER is
			-- Current size.
		do
			if is_vertical then
				Result := height
			else
				Result := width
			end
		ensure
			valid: Result > 0
		end

	position: INTEGER is
			-- X position if not `is_vertical' or Y position if `is_vertical'.
		do
			if is_vertical then
				Result := y_position
			else
				Result := x_position
			end
		end

	tail_indicator_position: EV_COORDINATE is
			-- Screen position `internal_tail_indicator' position.
		do
			create Result.make (internal_tail_tool_bar.screen_x, internal_tail_tool_bar.screen_y)
		ensure
			not_void: Result /= Void
		end

	prune_last_separator is
			-- Prune last separator, if exist.
		local
			l_separator: SD_TOOL_BAR_SEPARATOR
		do
			from
				finish
			until
				before or l_separator /= Void
			loop
				l_separator ?= item
				if l_separator /= Void then
					prune (l_separator)
				end
				back
			end
		end

	sizer: SD_MENU_ZONE_ASSISTANT
			-- Sizer to manage size issues.

	drag_area: EV_DRAWING_AREA
			-- Drag area which at beginning.

	floating_menu: SD_FLOATING_MENU_ZONE
			-- Floating menu zone which contain `Current' when floating.

feature {NONE} -- Agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw drag area.
		local
			i, l_interval : INTEGER
		do
			if not is_vertical then
				l_interval := drag_area.height
			else
				l_interval := drag_area.width
			end
			drag_area.clear
			from
				i := 2
			until
				i > l_interval - 3
			loop
				if not is_vertical then
					drag_area.draw_pixmap (4, i, bar_dot)
				else
					drag_area.draw_pixmap (i, 4, bar_dot)
				end
				i := i + 4
			end
		end

feature {NONE} -- Implmentation

	extend_one_item_vertical (a_item: EV_TOOL_BAR_ITEM) is
			-- Extend a_item when `is_vertical'.
		local
			l_ev_sep: EV_TOOL_BAR_SEPARATOR
			l_tool_bar: EV_TOOL_BAR
			l_sd_sep: SD_TOOL_BAR_SEPARATOR
			l_hbox: EV_HORIZONTAL_BOX
			l_button: EV_TOOL_BAR_BUTTON
		do
			l_button ?= a_item
			if l_button /= Void then
				l_button.set_text ("")
			end
			l_ev_sep ?= a_item
			if l_ev_sep = Void then
				create l_tool_bar
				l_tool_bar.disable_vertical_button_style
				l_tool_bar.extend (a_item)
				extend_hor_ver_box (l_tool_bar)

			else
				create l_hbox
				create l_sd_sep.make (background_color_internal, False, internal_shared.separator_width)
				l_hbox.extend (l_sd_sep)
				extend_hor_ver_box (l_hbox)
			end
		end

	extend_one_item_horizontal (a_item: EV_TOOL_BAR_ITEM) is
			-- Extend a_item when not `is_vertical'.
			-- FIXIT: Extract a menu builder class?
		require
			not_void: a_item /= Void
		local
			l_ev_sep: EV_TOOL_BAR_SEPARATOR
			l_sd_sep: SD_TOOL_BAR_SEPARATOR
			l_hbox: EV_HORIZONTAL_BOX
			l_button: EV_TOOL_BAR_BUTTON
		do
			l_ev_sep ?= a_item
			if l_ev_sep = Void then
				if (content.text_of (a_item).is_equal ("") and internal_last_has_text) or (not content.text_of (a_item).is_equal ("") and not internal_last_has_text) then
					if not content.text_of (a_item).is_equal ("") then
						internal_horizontal_tool_bar.disable_vertical_button_style
					end
				end
				if not content.text_of (a_item).is_equal ("") then
					l_button ?= a_item
					check not_void: l_button /= Void end
					l_button.set_text (content.text_of (a_item))
				end
				internal_horizontal_tool_bar.extend (a_item)
			else
				create l_hbox
				create l_sd_sep.make (background_color_internal, not is_vertical, internal_shared.separator_width)
				l_hbox.extend (l_sd_sep)
				extend_hor_ver_box (l_hbox)
			end
		end

	internal_last_has_text: BOOLEAN
			-- If last extended item has a text? Used by `extend_one_item_horizontal'.

	internal_shared: SD_SHARED
			-- All singletons.

	internal_horizontal_tool_bar: EV_TOOL_BAR
			-- When `Current' is horizontal, use this to hold EV_TOOL_BAR_ITEM.

	bar_dot: EV_PIXMAP
			-- 9 colors on a dot.

	background_color_internal: EV_COLOR
			-- Backgroud color

	internal_menu_dot_drawer: SD_MENU_DOT_DRAWER
			-- Menu dot drawer.

feature {SD_MENU_ZONE_ASSISTANT}

	extend_one_item (a_item: EV_TOOL_BAR_ITEM) is
			-- Extend `a_item'.
		require
			a_item_not_void: a_item /= Void
--			only_when_horizontal_and_floating: a_new_row implies (not is_vertical and is_floating)
		do

			if is_vertical then
				extend_one_item_vertical (a_item)
			else
				create internal_horizontal_tool_bar
				extend_hor_ver_box (internal_horizontal_tool_bar)
				disable_item_expand (internal_horizontal_tool_bar)

				extend_one_item_horizontal (a_item)
			end
			start
			search (internal_tail_tool_bar)
			if not off and then index /= count then
				swap (count)
			end
		end

	internal_tail_tool_bar: EV_TOOL_BAR
			-- Tool bar which only contain `internal_tail_indicator'.

	internal_tail_indicator: EV_TOOL_BAR_BUTTON
			-- Button at tail of Current.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

feature {SD_FLOATING_MENU_ZONE} -- Internal issues.

	internal_agents: SD_MENU_DRAGGING_AGENTS
			-- Dragging agents.
invariant

	not_void: internal_shared /= Void
	not_void: drag_area /= Void
	not_void: sizer /= Void

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
