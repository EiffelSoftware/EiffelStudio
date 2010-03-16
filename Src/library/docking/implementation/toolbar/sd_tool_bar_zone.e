note
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
		undefine
			is_equal
		end

	SD_WIDGETS_LISTS
		undefine
			is_equal,
			copy
		end

	SD_ACCESS
		undefine
			is_equal
		end

	SD_DOCKING_MANAGER_HOLDER
		undefine
			is_equal,
			copy
		end

	COMPARABLE
		undefine
			is_equal,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER; a_is_menu_bar: BOOLEAN)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		local
			l_drawer: detachable like internal_tool_bar_dot_drawer
		do
			create internal_shared
			set_docking_manager (a_docking_manager)
			if not a_is_menu_bar then
				create {SD_WIDGET_TOOL_BAR} internal_tool_bar.make (create {SD_TOOL_BAR}.make)
			else
				create {SD_MENU_BAR} internal_tool_bar.make
			end

			is_vertical := a_vertical
			if attached {EV_WIDGET} tool_bar as lt_widget then
				create l_drawer.make (lt_widget.background_color)

			else
				check not_possible: False end
			end
			check l_drawer /= Void end -- Implied by previous if clause
			internal_tool_bar_dot_drawer := l_drawer
			create bar_dot.make_with_size (3, 3)
			check l_drawer /= Void end -- Implied by previous if clause
			l_drawer.draw (bar_dot)

			create assistant.make
			create tail_indicator.make
			init_drag_area
			assistant.set_tool_bar_zone (Current)
			add_tool_bar_zone (Current)

		ensure
			set: is_vertical = a_vertical
			set: docking_manager = a_docking_manager
			tool_bar_not_void: is_tool_bar_set
		end

	init_drag_area
			-- Initlization of `drag_area'
		do
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (True)
			else
				disable_drag_area
			end

			tool_bar.expose_actions.extend (agent on_redraw_drag_area)

			create internal_agents.make
			agents.set_docking_manager (docking_manager)
			agents.set_tool_bar_zone (Current)
			tool_bar.pointer_button_press_actions.extend (agent agents.on_drag_area_pressed)
			tool_bar.pointer_motion_actions.extend (agent agents.on_drag_area_motion)
			tool_bar.pointer_button_release_actions.extend (agent agents.on_drag_area_release)
			tool_bar.pointer_double_press_actions.extend (agent agents.on_drag_area_pointer_double_press)
		end

feature -- Command

	change_direction (a_horizontal: BOOLEAN)
			-- Change layout direction
		require
			not_destroyed: not is_destroyed
		local
			l_button: detachable SD_TOOL_BAR_BUTTON
			l_separator: detachable SD_TOOL_BAR_SEPARATOR
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_widget_button: detachable SD_TOOL_BAR_WIDGET_ITEM
			l_text: like internal_text
			l_hidden_items: like internal_hidden_widget_items
		do
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (a_horizontal)
			end

			from
				if not a_horizontal then
					create l_text.make (1)
					internal_text := l_text
					create l_hidden_items.make (1)
					internal_hidden_widget_items := l_hidden_items
				else
					if attached internal_text as l_text_2 then
						l_text := l_text_2
						l_text.start
					end
					if attached internal_hidden_widget_items as l_hidden_items_2 then
						l_hidden_items := l_hidden_items_2
						l_hidden_items.start
					end
				end
				l_items := tool_bar.items
				l_items.start
			until
				l_items.after
			loop
				l_button ?= l_items.item
				l_items.item.set_wrap (not a_horizontal)
				if not a_horizontal and then l_items.index /= l_items.count then
					l_separator ?= l_items.i_th (l_items.index + 1)
					if l_separator /= Void then
						l_items.item.set_wrap (False)
					end
				end

				if not a_horizontal and l_button /= Void then
					check l_text /= Void end -- Implied by `l_text' created in previous if clause if not `is_horizontal'
					-- We may record Void text here
					l_text.extend (l_button.text)
					l_button.set_text ("")
				elseif a_horizontal and l_button /= Void then
					if attached internal_text as l_internal_text then
						l_button.set_text (l_internal_text.item)
						l_internal_text.forth
					end
				end

				l_widget_button ?= l_items.item
				if not a_horizontal and then l_widget_button /= Void then
					check l_hidden_items /= Void end -- Implied by the first if clause in this feature
					l_hidden_items.extend (l_widget_button, l_items.index)
					tool_bar.prune (l_widget_button)
				end
				l_items.forth
			end
			if a_horizontal and is_need_restore_hidden_items then
				restore_hidden_widget_items
			end
			compute_minmum_size
			is_vertical := not a_horizontal
			update_maximum_size
		ensure
			direction_changed: is_vertical = not a_horizontal
		end

	destroy_parent_containers
			-- Destroy related parent containers
		require
			not_destroyed: not is_destroyed
		local
			l_row: detachable SD_TOOL_BAR_ROW
		do
			l_row := row
			if l_row /= Void then
				l_row.prune (Current)
				if l_row.count = 0 then
					if attached l_row.parent as l_parent then
						docking_manager.command.lock_update (Void, True)
						l_parent.prune (l_row)
						docking_manager.command.resize (True)
						docking_manager.command.unlock_update
					end
				end
			end
		end

	disable_drag_area
			-- Remove drag area which is located at head
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.set_start_x (0)
			tool_bar.set_start_y (0)
			create drag_area_rectangle.make (0, 0, 0, 0)
		end

	enable_drag_area
			-- Show drag area which is located at the head
		require
			not_destroyed: not is_destroyed
		do
			if not is_floating then
				set_drag_area (not is_vertical)
			end
		end

	update_drag_area
			--Update drag area sizes
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.set_need_calculate_size (True)
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (not is_vertical)
			else
				disable_drag_area
			end
		end

	float (a_screen_x, a_screen_y: INTEGER; a_visible: BOOLEAN)
			-- Float to `a_screen_x' and `a_screen_y'
		require
			not_destroyed: not is_destroyed
		local
			l_platform: PLATFORM
			l_floating_tool_bar: like floating_tool_bar
		do
			destroy_parent_containers

			if is_vertical then
				change_direction (True)
			end
			disable_drag_area

			create l_floating_tool_bar.make (docking_manager)
			floating_tool_bar := l_floating_tool_bar
			if attached {EV_WIDGET} tool_bar as lt_widget then
				if attached lt_widget.parent as l_parent then
					l_parent.prune (lt_widget)
				end
			else
				check not_possible: False end
			end

			l_floating_tool_bar.extend (Current)

			prune (tail_indicator)

			-- We have to compute minimum width, because the tail tool bar option button is removed
			compute_minmum_size

			l_floating_tool_bar.set_position (a_screen_x, a_screen_y)
			if attached assistant.last_state.floating_group_info as l_last_info then
				l_floating_tool_bar.assistant.position_groups (l_last_info)
			end
			if a_visible then
				l_floating_tool_bar.show
			end

			-- We have to set position again after showing on Solaris. Otherwise it will cause bug#12873
			-- The vertical position problem only happens on Solaris JDS. Not happens on Windows, Ubuntu (both GNome and KDE) and
			-- Solaris CDE. Maybe it's a bug of JDS
			create l_platform
			if l_platform.is_unix then
				l_floating_tool_bar.set_position (a_screen_x, a_screen_y)
			end

			docking_manager.tool_bar_manager.floating_tool_bars.extend (l_floating_tool_bar)

			assistant.update_indicator
		ensure
			pruned: (attached row as l_row and then attached {EV_WIDGET} tool_bar as lt_widget_2) implies not l_row.has (lt_widget_2)
			is_floating: is_floating
		end

	dock
			-- Dock to a tool bar area
		require
			not_destroyed: not is_destroyed
			is_floating: is_floating
		local
			l_floating_tool_bar: like floating_tool_bar
		do
			l_floating_tool_bar := floating_tool_bar
			check l_floating_tool_bar /= Void end -- Implied by precondition `is_floating'
			docking_manager.tool_bar_manager.floating_tool_bars.prune_all (l_floating_tool_bar)
			-- On windows, following line is not needed,
			-- But on Gtk, we need first disable capture then enable capture,
			-- because it's off-screen widget, it'll not have capture until it show again (in SD_TOOL_BAR_HOT_ZONE).
			tool_bar.disable_capture
			if attached {EV_WIDGET} tool_bar as lt_widget then
				if attached lt_widget.parent as l_parent then
					l_parent.prune (lt_widget)
				else
					check False end -- Implied by tool bar parent not void when floating (before dock)
				end

				l_floating_tool_bar.destroy
				floating_tool_bar := Void
			else
				check not_possible: False end
			end

			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (True)
			end

			change_direction (True)
			extend_one_item (tail_indicator)
			compute_minmum_size
		ensure
			pruned: floating_tool_bar =  Void
		end

	extend (a_content: SD_TOOL_BAR_CONTENT)
			-- Extend `a_content'
		require
			not_destroyed: not is_destroyed
			a_content_not_void: a_content /= Void
			content_not_set: content = Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			internal_content := a_content
			tool_bar.set_content (a_content)
			a_content.set_zone (Current)
			l_items := a_content.items.twin
			from
				l_items.start
			until
				l_items.after
			loop
				extend_one_item (l_items.item)
				l_items.forth
			end
			extend_one_item (tail_indicator)
			tail_indicator.set_pixmap (internal_shared.icons.tool_bar_customize_indicator)
			tail_indicator.set_pixel_buffer (internal_shared.icons.tool_bar_customize_indicator_buffer)
			tail_indicator.set_tooltip (internal_shared.interface_names.tooltip_toolbar_tail_indicator)
			tail_indicator.select_actions.extend (agent assistant.on_tail_indicator_selected)

			compute_minmum_size
			update_maximum_size
		ensure
			set: content = a_content
		end

	set_position (a_screen_x, a_screen_y: INTEGER)
			-- Set position when `is_floating'
		require
			not_destroyed: not is_destroyed
			is_floating: is_floating
		local
			l_tool_bar: like floating_tool_bar
		do
			l_tool_bar := floating_tool_bar
			check l_tool_bar /= Void end -- Implied by precondition `is_floating'
			l_tool_bar.set_position (a_screen_x, a_screen_y)
		ensure
			set: (create {PLATFORM}).is_windows implies (attached floating_tool_bar as le_tool_bar and then
				(le_tool_bar.screen_x = a_screen_x and le_tool_bar.screen_y = a_screen_y))
		end

	compute_minmum_size
			-- <Precursor>
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.compute_minimum_size
			if attached {EV_WIDGET} tool_bar as lt_widget then
				if attached row as l_row and then l_row.has (lt_widget) then
					l_row.set_item_size (lt_widget, tool_bar.minimum_width, tool_bar.minimum_height)
				end
			else
				check not_possible: False end
			end
		end

	wipe_out
			-- Wipe out
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.wipe_out
			internal_content := Void
		end

	destroy
			-- Destroy
			-- Called by SD_TOOL_BAR_MANAGER.destroy
		local
			l_row: detachable SD_TOOL_BAR_ROW
		do
			prune_tool_bar_zone (Current)
			l_row := row
			if l_row /= Void then
				l_row.destroy
			end

			if internal_agents /= Void then
				agents.destroy
				internal_agents := Void
			end

			if attached tool_bar as l_tool_bar then
				l_tool_bar.destroy
				internal_tool_bar := Void
			end
			clear_docking_manager

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

	show
			-- Show
		require
			not_destroyed: not is_destroyed
		do
			if attached {EV_WIDGET} tool_bar as lt_widget then
				lt_widget.show
			else
				check not_possible: False end
			end
		end

	hide
			-- Hide
		require
			not_destroyed: not is_destroyed
		do
			if attached {EV_WIDGET} tool_bar as lt_widget then
				lt_widget.hide
			else
				check not_possible: False end
			end
		end

	prune (a_item: SD_TOOL_BAR_ITEM)
			-- Prune `a_item'
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.prune (a_item)
		end

feature -- Query

	is_floating: BOOLEAN
			-- If Current floating?
		require
			not_destroyed: not is_destroyed
		do
			Result := floating_tool_bar /= Void
		end

	is_destroyed: BOOLEAN
			-- If Current destoryed?

	customize_dialog: detachable SD_TOOL_BAR_CUSTOMIZE_DIALOG
			-- SD_TOOL_BAR_CUSTOMIZE_DIALOG if exists

	tool_bar: attached like internal_tool_bar
			-- Attached `internal_tool_bar'
		require
			set: is_tool_bar_set
		local
			l_result: like internal_tool_bar
		do
			l_result := internal_tool_bar
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	is_tool_bar_set: BOOLEAN
			-- If `internal_tool_bar' has been set?
		do
			Result := attached internal_tool_bar
		end

	is_vertical: BOOLEAN
			-- Is `Current' vertical layout or horizontal layout?

	content: attached like internal_content
			-- Attached `internal_content'
		require
			set: internal_content /= Void
		local
			l_result: like internal_content
		do
			l_result := internal_content
			check l_result /= Void end -- Implied by precondition `set'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_content: detachable SD_TOOL_BAR_CONTENT
			-- Content in `Current'

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Tool bar items on `Current' including invisible items
		require
			not_destroyed: not is_destroyed
		do
			Result := content.items
		ensure
			not_void: Result /= Void
		end

	row: detachable SD_TOOL_BAR_ROW
			-- Parent which contain `Current'
		require
			not_destroyed: not is_destroyed
		do
			if attached {EV_WIDGET} tool_bar as lt_widget then
				Result ?= lt_widget.parent
			else
				check not_possible: False end
			end
		end

	maximize_size: INTEGER
			-- Maximize width of Current if not `is_vertical'. Maximize height of Current if `is_vertical'

	size: INTEGER
			-- Current size
		require
			not_destroyed: not is_destroyed
		do
			if is_vertical then
				Result := tool_bar.minimum_height
			else
				-- On GTK, SD_TOOL_BAR `minimum_width' is not always equal `width' here
				-- On Windows, SD_TOOL_BAR `minimum_width' is always equal `width' here
				-- See bug#12651, so we use `minimum_width' for it
				-- Same for `minimum_height' and `height'
				Result := tool_bar.minimum_width
			end
		ensure
			valid: Result >= 0
		end

	position: INTEGER
			-- X position if not `is_vertical' or Y position if `is_vertical'
		require
			not_destroyed: not is_destroyed
		do
			if attached {EV_WIDGET} tool_bar as lt_widget then
				if is_vertical then
					Result := lt_widget.y_position
				else
					Result := lt_widget.x_position
				end
			else
				check not_possible: False end
			end
		end

	hidden_dialog_position: EV_COORDINATE
			-- Screen position for SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
		require
			not_destroyed: not is_destroyed
		local
			l_rect: EV_RECTANGLE
		do
			l_rect := tail_indicator.rectangle
			create Result.make (l_rect.x + tool_bar.screen_x, l_rect.y + tool_bar.screen_y)
		ensure
			not_void: Result /= Void
		end

	assistant: SD_TOOL_BAR_ZONE_ASSISTANT
			-- Assistant to manage size issues

	drag_area_rectangle: EV_RECTANGLE
			-- Drag area rectangle

	attached_floating_tool_bar: attached like floating_tool_bar
			-- Attacedh `floating_tool_bar'
		require
			floating: is_floating
		local
			l_result: like floating_tool_bar
		do
			l_result := floating_tool_bar
			check l_result /= Void end -- Implied by precondition `is_floating'
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	floating_tool_bar: detachable SD_FLOATING_TOOL_BAR_ZONE
			-- Floating tool bar zone which contain `Current' when floating

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN
			-- If Current has `a_item'?
		require
			not_destroyed: not is_destroyed
		do
			Result := tool_bar.has (a_item)
		end

	has_right_click_action (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If button at `a_screen_x', `a_screen_y' has pointer actions?
		require
			not_destroyed: not is_destroyed
		local
			l_button: detachable SD_TOOL_BAR_BUTTON
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				from
					tool_bar_items.start
				until
					tool_bar_items.after or Result
				loop
					l_button ?= tool_bar_items.item
					if l_button /= Void and then l_button.rectangle.has_x_y (a_screen_x - tool_bar.screen_x, a_screen_y - tool_bar.screen_y) then
						Result := l_button.pointer_button_press_actions.count > 0
					end
					tool_bar_items.forth
				end
			end
		end

	has_pebble_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If button at `a_screen_x', `a_screen_y' has pebble function?
		require
			not_destroyed: not is_destroyed
		local
			l_item: detachable SD_TOOL_BAR_ITEM
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				l_item := tool_bar.item_at_position (a_screen_x, a_screen_y)
				if l_item /= Void then
					Result := l_item.pebble_function /= Void
				end
			end
		end

	has_drop_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If button at `a_screen_x', `a_screen_y' has drop function?
		require
			not_destroyed: not is_destroyed
		local
			l_item: detachable SD_TOOL_BAR_ITEM
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				l_item := tool_bar.item_at_position (a_screen_x, a_screen_y)
				if l_item /= Void then
					Result := l_item.drop_actions.count >= 1
				end
			end
		end

	is_less alias "<" (a_other: SD_TOOL_BAR_ZONE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := position < a_other.position
		end

	is_equal (a_other: SD_TOOL_BAR_ZONE): BOOLEAN
			-- <Precursor>
			-- Only compare position, used by {SD_TOOL_BAR_ROW}.zones
		do
			Result := position = a_other.position
		end

feature {NONE} -- Agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER)
			-- Handle redraw drag area
		require
			not_destroyed: not is_destroyed
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

	hash_code: INTEGER
			-- Hash code is index in all tool bar zones
		do
			Result := docking_manager.tool_bar_manager.contents.index_of (content, 1)
		end

	internal_shared: SD_SHARED
			-- All singletons

	internal_tool_bar: detachable SD_GENERIC_TOOL_BAR
			-- Tool bar which managed by Current

	bar_dot: EV_PIXMAP
			-- Drag area pixmap

	internal_tool_bar_dot_drawer: SD_TOOL_BAR_DOT_DRAWER
			-- Tool bar dot drawer

	internal_drag_area_size: INTEGER = 10
			-- Drag area size
			-- It is width is Current is horizontal layout
			-- It is height is CUrrent is vertical layout

	set_drag_area (a_is_for_horizontal: BOOLEAN)
			-- Set `drag_area_rectangle' and `start_x', `start_y' for tool bar
		require
			not_destroyed: not is_destroyed
		local
			l_row_height: INTEGER
		do
			l_row_height := tool_bar.row_height
			-- Maybe the row height not setted at the moment, we use `standard_height' as default
			if l_row_height <= 0 then
				l_row_height := tool_bar.standard_height
			end
			if a_is_for_horizontal then
				-- Change to horizontal drag area
				tool_bar.set_start_x (internal_drag_area_size)
				tool_bar.set_start_y (0)
				create drag_area_rectangle.make (0, 0, internal_drag_area_size, l_row_height)
			else
				-- Change to vertical drag area
				tool_bar.set_start_x (0)
				tool_bar.set_start_y (internal_drag_area_size)
				create drag_area_rectangle.make (0, 0, l_row_height, internal_drag_area_size)
			end
		end

	internal_text: detachable ARRAYED_LIST [detachable STRING_GENERAL]
			-- When `is_vertical' we hide all texts, store orignal texts here

	internal_hidden_widget_items: detachable HASH_TABLE [SD_TOOL_BAR_WIDGET_ITEM, INTEGER]
			-- When `is_vertical' we hide all widget tool bar items, store orignal items here

	is_need_restore_hidden_items: BOOLEAN
			-- If need restore hidden items?
		require
			not_destroyed: not is_destroyed
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			if attached internal_hidden_widget_items as l_hidden_items and then is_tool_bar_set then
				if not l_hidden_items.is_empty then
					l_hidden_items.start
					l_item := l_hidden_items.item_for_iteration
					if not tool_bar.has (l_item)  then
						Result := True
					end
				end
			end
		end

	restore_hidden_widget_items
			-- Restore hidden widget items
		require
			not_destroyed: not is_destroyed
			not_void: internal_hidden_widget_items /= Void
		local
			l_item: detachable SD_TOOL_BAR_WIDGET_ITEM
			l_parent: detachable EV_CONTAINER
			l_hidden_items: like internal_hidden_widget_items
		do
			from
				l_hidden_items := internal_hidden_widget_items
				check l_hidden_items /= Void end -- Implied by precondition `not_void'
				l_hidden_items.start
			until
				l_hidden_items.after
			loop
				-- on GTK, when dragging a tool bar t swtich between the state of docking and floating constanly
				-- SD_TOOL_BAR_WIDGET_ITEM parent will not be void sometimes
				l_item := l_hidden_items.item (l_hidden_items.key_for_iteration)
				check l_item /= Void end -- Implied by `internal_hidden_widget_items' does not contain void item
				l_parent := l_item.widget.parent
				if l_parent /= Void then
					l_parent.prune (l_item.widget)
				end
				tool_bar.force (l_item, l_hidden_items.key_for_iteration)
				l_hidden_items.forth
			end
		end

feature {SD_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_HIDDEN_ITEM_DIALOG, SD_FLOATING_TOOL_BAR_ZONE, SD_GENERIC_TOOL_BAR, SD_TOOL_BAR_CONTENT} -- Internal issues

	tail_indicator: SD_TOOL_BAR_NARROW_BUTTON
			-- Button at tail of Current, which used for show hide buttons and customize dialog

	extend_one_item (a_item: SD_TOOL_BAR_ITEM)
			-- Extend `a_item' if `a_item' is_displayed
		require
			not_destroyed: not is_destroyed
		local
			l_widget_item: detachable SD_TOOL_BAR_WIDGET_ITEM
		do
			if a_item /= Void and then a_item.is_displayed then
				l_widget_item ?= a_item
				if l_widget_item /= Void then
					if attached l_widget_item.widget.parent as l_parent then
						l_parent.prune (l_widget_item.widget)
					end
				end
				tool_bar.extend (a_item)
			end
		end

	update_maximum_size
			-- Update `maximize_size'
		require
			not_destroyed: not is_destroyed
		do
			if is_vertical then
				maximize_size := tool_bar.minimum_height
			else
				maximize_size := tool_bar.minimum_width
			end
		end

	set_customize_dialog (a_dialog: detachable like customize_dialog)
			-- Set `customize_dialog' with `a_dialog'
		require
			not_destroyed: not is_destroyed
		do
			customize_dialog := a_dialog
		ensure
			set: customize_dialog = a_dialog
		end

feature {SD_FLOATING_TOOL_BAR_ZONE} -- Internal

	agents: SD_TOOL_BAR_DRAGGING_AGENTS
			-- Dragging agents
		require
			set: internal_agents /= Void
		local
			l_result: like internal_agents
		do
			l_result := internal_agents
			check l_result /= Void end
			Result := l_result
		ensure
			not_void: Result /= Void
		end

	internal_agents: detachable SD_TOOL_BAR_DRAGGING_AGENTS
			-- Instance holder of `agents'

invariant
	not_void: internal_shared /= Void
	not_void: assistant /= Void

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
