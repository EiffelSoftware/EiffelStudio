indexing
	description: "Zone that hold SD_TOOL_BAR_BUTTONs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_ZONE

inherit
	SD_TOOL_BAR
		rename
			extend as extend_tool_bar,
			make as make_tool_bar
		export
			{ANY} x_position, y_position, screen_x, screen_y, parent, disable_capture, enable_capture, has_capture, set_pointer_style
			{SD_TOOL_BAR_DRAGGING_AGENTS} pointer_motion_actions, pointer_button_release_actions
			{SD_FLOATING_TOOL_BAR_ZONE, SD_TOOL_BAR_ROW} set_minimum_width, set_minimum_height
			{SD_TOOL_BAR_CONTENT} destroy
			{SD_TOOL_BAR_ZONE_ASSISTANT} internal_items
		redefine
			compute_minmum_size
		end

	HASHABLE
		export
			{NONE} all
		undefine
			default_create,
			is_equal,
			copy
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
			make_tool_bar
			is_vertical := a_vertical

			create internal_tool_bar_dot_drawer.make (background_color)
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
			start_x := internal_drag_area_size
			create drag_area_rectangle.make (0, 0, start_x, row_height)

			expose_actions.extend (agent on_redraw_drag_area)

			create agents.make (docking_manager, Current)
			pointer_button_press_actions.extend (agent agents.on_drag_area_pressed)
			pointer_motion_actions.extend (agent agents.on_drag_area_motion)
			pointer_button_release_actions.extend (agent agents.on_drag_area_release)
			pointer_double_press_actions.force_extend (agent assistant.floating_last_state)
			set_pointer_style (default_pixmaps.sizeall_cursor)
		end

feature -- Command

	change_direction (a_hortizontal: BOOLEAN) is
			-- Change layout direction.
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_separator: SD_TOOL_BAR_SEPARATOR
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
				internal_items.start
			until
				internal_items.after
			loop
				l_button ?= internal_items.item
				internal_items.item.set_wrap (not a_hortizontal)
				if not a_hortizontal and then internal_items.index /= internal_items.count then
					l_separator ?= internal_items.i_th (internal_items.index + 1)
					if l_separator /= Void then
						internal_items.item.set_wrap (False)
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
				internal_items.forth
			end
			compute_minmum_size
			is_vertical := not a_hortizontal
		ensure
			direction_changed: is_vertical = not a_hortizontal
		end

	float (a_screen_x, a_screen_y: INTEGER) is
			-- Float to `a_screen_x' and `a_screen_y'.
		do
			if row /= Void then
				row.prune (Current)
				if row.count = 0 then
					if row.parent /= Void then
						docking_manager.command.lock_update (Void, True)
						row.parent.prune (row)
						docking_manager.command.resize
						docking_manager.command.unlock_update
					end
				end
			end

			if is_vertical then
				change_direction (True)
			end
			start_x := 0
			start_y := 0
			create drag_area_rectangle.make (0, 0, 0, 0)
			redraw_rectangle (0, 0, {SD_TOOL_BAR_SEPARATOR}.width, row_height)

			create floating_tool_bar.make (docking_manager)
			if parent /= Void then
				parent.prune (Current)
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
			pruned: row /= Void implies not row.has (Current)
			is_floating: is_floating
		end

	dock is
			-- Dock to a tool bar area.
		require
			is_floating: is_floating
		do
			docking_manager.tool_bar_manager.floating_tool_bars.prune_all (floating_tool_bar)
			floating_tool_bar.prune (Current)
			floating_tool_bar.destroy
			floating_tool_bar := Void

			if parent /= Void then
				parent.prune (Current)
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
			content_not_set: content = Void or a_content = content
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			content := a_content
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
			if is_vertical then
				maximize_size := minimum_height
			else
				maximize_size := minimum_width
			end
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

	set_row (a_row: like row) is
			-- Set `row'
		require
			a_row_not_void: a_row /= Void
		do
			row := a_row
		ensure
			set: row = a_row
		end

	compute_minmum_size is
			-- Redefine
		do
			Precursor {SD_TOOL_BAR}
			if row /= Void and row.has (Current) then
				row.set_item_size (Current, minimum_width, minimum_height)
			end
		end

feature -- Query

	is_floating: BOOLEAN is
			-- If `Current' floating?
		do
			Result := floating_tool_bar /= Void
		end

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

	row: SD_TOOL_BAR_ROW
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
			valid: Result >= 0
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

	hidden_dialog_position: EV_COORDINATE is
			-- Screen position for SD_TOOL_BAR_HIDDEN_ITEM_DIALOG.
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := tail_indicator.rectangle
			create Result.make (l_rect.x + screen_x, l_rect.y + screen_y)
		ensure
			not_void: Result /= Void
		end

	assistant: SD_TOOL_BAR_ZONE_ASSISTANT
			-- Assistant to manage size issues.

	drag_area_rectangle: EV_RECTANGLE
			-- Drag area rectangle

	floating_tool_bar: SD_FLOATING_TOOL_BAR_ZONE
			-- Floating tool bar zone which contain `Current' when floating.

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
						draw_pixmap (4, i, bar_dot)
					else
						draw_pixmap (i, 4, bar_dot)
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
				start_x := internal_drag_area_size
				start_y := 0
				create drag_area_rectangle.make (0, 0, internal_drag_area_size, row_height)
			else
				-- Change to vertical drag area.
				start_x := 0
				start_y := internal_drag_area_size
				create drag_area_rectangle.make (0, 0, row_height, internal_drag_area_size)
			end
		end

	internal_text: ARRAYED_LIST [STRING]
			-- When `is_vertical' we hide all texts, store orignal texts here.

feature {SD_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_HIDDEN_ITEM_DIALOG, SD_FLOATING_TOOL_BAR_ZONE} -- Internal issues

	tail_indicator: SD_TOOL_BAR_NARROW_BUTTON
			-- Button at tail of Current, which used for show hide buttons and customize dialog.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	extend_one_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item' if `a_item' is_displayed.
		do
			if a_item.is_displayed then
				extend_tool_bar (a_item)
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
