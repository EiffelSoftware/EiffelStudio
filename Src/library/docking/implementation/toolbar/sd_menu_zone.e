indexing
	description: "Zone that hold SD_TOOL_BAR_BUTTONs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ZONE

inherit

	HASHABLE
		export
			{NONE} all
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
			docking_manager := a_docking_manager
			create {SD_WIDGET_TOOL_BAR} tool_bar.make (create {SD_TOOL_BAR}.make)

			is_vertical := a_vertical

			create internal_tool_bar_dot_drawer.make (tool_bar.background_color)
			create bar_dot.make_with_size (3, 3)
			internal_tool_bar_dot_drawer.draw (bar_dot)

			create assistant.make (Current)

			init_drag_area
		ensure
			set: is_vertical = a_vertical
			set: docking_manager = a_docking_manager
		end

	init_drag_area is
			-- Initlization of `drag_area'.
		do
			tool_bar.set_start_x (internal_drag_area_size)
			create drag_area_rectangle.make (0, 0, tool_bar.start_x, tool_bar.row_height)

			tool_bar.expose_actions.extend (agent on_redraw_drag_area)

			create agents.make (docking_manager, Current)
			tool_bar.pointer_button_press_actions.extend (agent agents.on_drag_area_pressed)
			tool_bar.pointer_motion_actions.extend (agent agents.on_drag_area_motion)
			tool_bar.pointer_button_release_actions.extend (agent agents.on_drag_area_release)
			tool_bar.pointer_double_press_actions.extend (agent agents.on_drag_area_pointer_double_press)
		end

feature -- Command

	change_direction (a_hortizontal: BOOLEAN) is
			-- Change layout direction.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			set_drag_area (a_hortizontal)
			from
				if not a_hortizontal then
					create internal_text.make (1)
				else
					if internal_text /= Void then
						internal_text.start
					end
				end
				l_items := tool_bar.items
				l_items.start
			until
				l_items.after
			loop
				l_button ?= l_items.item
				l_items.item.set_wrap (not a_hortizontal)
				if not a_hortizontal and then l_items.index /= l_items.count then
					l_separator ?= l_items.i_th (l_items.index + 1)
					if l_separator /= Void then
						l_items.item.set_wrap (False)
					end
				end

				if not a_hortizontal and l_button /= Void then
					-- We may record Void text here.
					internal_text.extend (l_button.text)
					l_button.set_text ("")
				elseif a_hortizontal and l_button /= Void then
					if internal_text /= Void then
						l_button.set_text (internal_text.item)
						internal_text.forth
					end
				end
				l_items.forth
			end
			compute_minmum_size
			is_vertical := not a_hortizontal
			update_maximum_size
		ensure
			direction_changed: is_vertical = not a_hortizontal
		end

	float (a_screen_x, a_screen_y: INTEGER) is
			-- Float to `a_screen_x' and `a_screen_y'.
		local
			l_row: SD_TOOL_BAR_ROW
		do
			l_row := row
			if l_row /= Void then
				l_row.prune (Current)
				if l_row.count = 0 then
					if l_row.parent /= Void then
						docking_manager.command.lock_update (Void, True)
						l_row.parent.prune (l_row)
						docking_manager.command.resize (True)
						docking_manager.command.unlock_update
					end
				end
			end

			if is_vertical then
				change_direction (True)
			end
			tool_bar.set_start_x (0)
			tool_bar.set_start_y (0)
			create drag_area_rectangle.make (0, 0, 0, 0)
			tool_bar.redraw_rectangle (0, 0, {SD_TOOL_BAR_SEPARATOR}.width, tool_bar.row_height)

			create floating_tool_bar.make (docking_manager)
			if tool_bar.parent /= Void then
				tool_bar.parent.prune (tool_bar)
			end
			floating_tool_bar.extend (Current)

			prune (tail_indicator)
			floating_tool_bar.set_position (a_screen_x, a_screen_y)
			if assistant.last_state.floating_group_info /= Void then
				floating_tool_bar.assistant.position_groups (assistant.last_state.floating_group_info)
			end
			floating_tool_bar.show

			docking_manager.tool_bar_manager.floating_tool_bars.extend (floating_tool_bar)

			assistant.update_indicator
		ensure
			pruned: row /= Void implies not row.has (tool_bar)
			is_floating: is_floating
		end

	dock is
			-- Dock to a tool bar area.
		require
			is_floating: is_floating
		do
			docking_manager.tool_bar_manager.floating_tool_bars.prune_all (floating_tool_bar)
			-- On windows, following line is not needed,
			-- But on Gtk, we need first disable_capture then enable capture,
			-- because it's off-screen widget, it'll not have capture when it show again (in SD_TOOL_BAR_HOT_ZONE).
			tool_bar.disable_capture

			floating_tool_bar.prune (tool_bar)
			floating_tool_bar.destroy
			floating_tool_bar := Void

			if tool_bar.parent /= Void then
				tool_bar.parent.prune (tool_bar)
			end
			set_drag_area (True)
			change_direction (True)
			extend_one_item (tail_indicator)
			compute_minmum_size
		ensure
			pruned: floating_tool_bar =  Void
		end

	extend (a_content: SD_TOOL_BAR_CONTENT) is
			-- Extend `a_content'.
		require
			a_content_not_void: a_content /= Void
			content_not_set: content = Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			content := a_content
			a_content.set_zone (Current)
			l_items := a_content.items
			from
				l_items.start
			until
				l_items.after
			loop
				extend_one_item (l_items.item)
				l_items.forth
			end
			create tail_indicator.make
			extend_one_item (tail_indicator)
			tail_indicator.set_pixmap (internal_shared.icons.tool_bar_customize_indicator)
			tail_indicator.select_actions.extend (agent assistant.on_tail_indicator_selected)

			compute_minmum_size
			update_maximum_size
		ensure
			set: content = a_content
		end

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position when `is_floating'.
		require
			is_floating: is_floating
		do
			floating_tool_bar.set_position (a_screen_x, a_screen_y)
		ensure
			set: floating_tool_bar.screen_x = a_screen_x and floating_tool_bar.screen_y = a_screen_y
		end

	compute_minmum_size is
			-- Redefine
		do
			tool_bar.compute_minmum_size
			if row /= Void and row.has (tool_bar) then
				row.set_item_size (tool_bar, tool_bar.minimum_width, tool_bar.minimum_height)
			end
		end

	wipe_out is
			-- Wipe out
		do
			tool_bar.wipe_out
			content := Void
		end

	destroy is
			-- Destroy
		do
			tool_bar.destroy
		end

	show is
			-- Show
		do
			tool_bar.show
		end

	hide is
			-- Hide
		do
			tool_bar.hide
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		do
			tool_bar.prune (a_item)
		end

feature -- Query

	is_floating: BOOLEAN is
			-- If `Current' floating?
		do
			Result := floating_tool_bar /= Void
		end

	tool_bar: SD_TOOL_BAR
			-- Tool bar which managed by Current.

	is_vertical: BOOLEAN
			-- Is `Current' vertical layout or horizontal layout?

	content: SD_TOOL_BAR_CONTENT
			-- Content in `Current'.

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Tool bar items on `Current'.
		do
			Result := content.items
		ensure
			not_void: Result /= Void
		end

	row: SD_TOOL_BAR_ROW is
			-- Parent which contain `Current'.
		do
			Result ?= tool_bar.parent
			check really_void: Result = Void implies tool_bar.parent = Void end
		end

	maximize_size: INTEGER
			-- Maximize width of Current if not `is_vertical'. Maximize height of Current if `is_vertical'.

	size: INTEGER is
			-- Current size.
		do
			if is_vertical then
				Result := tool_bar.height
			else
				Result := tool_bar.width
			end
		ensure
			valid: Result >= 0
		end

	position: INTEGER is
			-- X position if not `is_vertical' or Y position if `is_vertical'.
		do
			if is_vertical then
				Result := tool_bar.y_position
			else
				Result := tool_bar.x_position
			end
		end

	hidden_dialog_position: EV_COORDINATE is
			-- Screen position for SD_TOOL_BAR_HIDDEN_ITEM_DIALOG.
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := tail_indicator.rectangle
			create Result.make (l_rect.x + tool_bar.screen_x, l_rect.y + tool_bar.screen_y)
		ensure
			not_void: Result /= Void
		end

	assistant: SD_TOOL_BAR_ZONE_ASSISTANT
			-- Assistant to manage size issues.

	drag_area_rectangle: EV_RECTANGLE
			-- Drag area rectangle

	floating_tool_bar: SD_FLOATING_TOOL_BAR_ZONE
			-- Floating tool bar zone which contain `Current' when floating.

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item'?
		do
			Result := tool_bar.has (a_item)
		end

feature {NONE} -- Agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw drag area.
		local
			i, l_interval : INTEGER
		do
			if drag_area_rectangle.has_x_y (a_x, a_y) or drag_area_rectangle.has_x_y (a_x + a_width, a_y + a_height) then
				if not is_vertical then
					l_interval := drag_area_rectangle.height
				else
					l_interval := drag_area_rectangle.width
				end

				from
					i := 2
				until
					i > l_interval - 3
				loop
					if not is_vertical then
						tool_bar.draw_pixmap (4, i, bar_dot)
					else
						tool_bar.draw_pixmap (i, 4, bar_dot)
					end
					i := i + 4
				end
			end
		end

feature {NONE} -- Implmentation

	hash_code: INTEGER is
			-- Hash code is index in all tool bar zones.
		do
			Result := docking_manager.tool_bar_manager.contents.index_of (Current.content, 1)
		end

	internal_shared: SD_SHARED
			-- All singletons.

	bar_dot: EV_PIXMAP
			-- Drag area pixmap.

	internal_tool_bar_dot_drawer: SD_TOOL_BAR_DOT_DRAWER
			-- Tool bar dot drawer.

	internal_drag_area_size: INTEGER is 10
			-- Drag area size.
			-- It is width is Current is horizontal layout.
			-- It is height is CUrrent is vertical layout.

	set_drag_area (a_is_for_horizontal: BOOLEAN) is
			-- Set `drag_area_rectangle' and `start_x', `start_y' for tool bar.
		do
			if a_is_for_horizontal then
				-- Change to horizontal drag area.
				tool_bar.set_start_x (internal_drag_area_size)
				tool_bar.set_start_y (0)
				create drag_area_rectangle.make (0, 0, internal_drag_area_size, tool_bar.row_height)
			else
				-- Change to vertical drag area.
				tool_bar.set_start_x (0)
				tool_bar.set_start_y (internal_drag_area_size)
				create drag_area_rectangle.make (0, 0, tool_bar.row_height, internal_drag_area_size)
			end
		end

	internal_text: ARRAYED_LIST [STRING]
			-- When `is_vertical' we hide all texts, store orignal texts here.

	update_maximum_size is
			-- Update `maximize_size'
		do
			if is_vertical then
				maximize_size := tool_bar.minimum_height
			else
				maximize_size := tool_bar.minimum_width
			end
		end

feature {SD_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_HIDDEN_ITEM_DIALOG, SD_FLOATING_TOOL_BAR_ZONE} -- Internal issues

	tail_indicator: SD_TOOL_BAR_NARROW_BUTTON
			-- Button at tail of Current, which used for show hide buttons and customize dialog.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	extend_one_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item' if `a_item' is_displayed.
		do
			if a_item.is_displayed then
				tool_bar.extend (a_item)
			end
		end

feature {SD_FLOATING_TOOL_BAR_ZONE} -- Internal issues.

	agents: SD_TOOL_BAR_DRAGGING_AGENTS
			-- Dragging agents.
invariant

	not_void: internal_shared /= Void
	not_void: assistant /= Void

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
