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

	SD_WIDGETS_LISTS
		undefine
			is_equal,
			copy
		end

	SD_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_vertical: BOOLEAN; a_docking_manager: SD_DOCKING_MANAGER; a_is_menu_bar: BOOLEAN) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			create internal_shared
			docking_manager := a_docking_manager
			if not a_is_menu_bar then
				create {SD_WIDGET_TOOL_BAR} tool_bar.make (create {SD_TOOL_BAR}.make)
			else
				create {SD_MENU_BAR} tool_bar.make
			end

			is_vertical := a_vertical

			create internal_tool_bar_dot_drawer.make (tool_bar.background_color)
			create bar_dot.make_with_size (3, 3)
			internal_tool_bar_dot_drawer.draw (bar_dot)

			create assistant.make (Current)

			init_drag_area

			add_tool_bar_zone (Current)
		ensure
			set: is_vertical = a_vertical
			set: docking_manager = a_docking_manager
			tool_bar_not_void: tool_bar /= Void
		end

	init_drag_area is
			-- Initlization of `drag_area'.
		do
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (True)
			else
				disable_drag_area
			end

			tool_bar.expose_actions.extend (agent on_redraw_drag_area)

			create agents.make (docking_manager, Current)
			tool_bar.pointer_button_press_actions.extend (agent agents.on_drag_area_pressed)
			tool_bar.pointer_motion_actions.extend (agent agents.on_drag_area_motion)
			tool_bar.pointer_button_release_actions.extend (agent agents.on_drag_area_release)
			tool_bar.pointer_double_press_actions.extend (agent agents.on_drag_area_pointer_double_press)
		end

feature -- Command

	change_direction (a_horizontal: BOOLEAN) is
			-- Change layout direction.
		require
			not_destroyed: not is_destroyed
		local
			l_button: SD_TOOL_BAR_BUTTON
			l_separator: SD_TOOL_BAR_SEPARATOR
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			l_widget_button: SD_TOOL_BAR_WIDGET_ITEM
		do
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (a_horizontal)
			end

			from
				if not a_horizontal then
					create internal_text.make (1)
					create internal_hidden_widget_items.make (1)
				else
					if internal_text /= Void then
						internal_text.start
					end
					if internal_hidden_widget_items /= Void then
						internal_hidden_widget_items.start
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
					-- We may record Void text here.
					internal_text.extend (l_button.text)
					l_button.set_text ("")
				elseif a_horizontal and l_button /= Void then
					if internal_text /= Void then
						l_button.set_text (internal_text.item)
						internal_text.forth
					end
				end

				l_widget_button ?= l_items.item
				if not a_horizontal and l_widget_button /= Void then
					internal_hidden_widget_items.force_last (l_widget_button, l_items.index)
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

	destroy_parent_containers is
			-- Destroy related parent containers
		require
			not_destroyed: not is_destroyed
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
		end

	disable_drag_area is
			-- Remove drag area which is located at head.
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.set_start_x (0)
			tool_bar.set_start_y (0)
			create drag_area_rectangle.make (0, 0, 0, 0)
		end

	enable_drag_area is
			-- Show drag area which is located at the head.
		require
			not_destroyed: not is_destroyed
		do
			if not is_floating then
				set_drag_area (not is_vertical)
			end
		end

	update_drag_area is
			--Update drag area sizes.
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.need_calculate_size
			if not docking_manager.tool_bar_manager.is_locked then
				set_drag_area (not is_vertical)
			else
				disable_drag_area
			end
		end

	float (a_screen_x, a_screen_y: INTEGER; a_visible: BOOLEAN) is
			-- Float to `a_screen_x' and `a_screen_y'.
		require
			not_destroyed: not is_destroyed
		local
			l_platform: PLATFORM
		do
			destroy_parent_containers

			if is_vertical then
				change_direction (True)
			end
			disable_drag_area

			create floating_tool_bar.make (docking_manager)
			if tool_bar.parent /= Void then
				tool_bar.parent.prune (tool_bar)
			end
			floating_tool_bar.extend (Current)

			prune (tail_indicator)

			-- We have to compute minimum width, because the tail tool bar option button is removed.
			compute_minmum_size

			floating_tool_bar.set_position (a_screen_x, a_screen_y)
			if assistant.last_state.floating_group_info /= Void then
				floating_tool_bar.assistant.position_groups (assistant.last_state.floating_group_info)
			end
			if a_visible then
				floating_tool_bar.show
			end

			-- We have to set position again after showing on Solaris. Otherwise it will cause bug#12873.
			-- The vertical position problem only happens on Solaris JDS. Not happens on Windows, Ubuntu (both GNome and KDE) and
			-- Solaris CDE. Maybe it's a bug of JDS.
			create l_platform
			if l_platform.is_unix then
				floating_tool_bar.set_position (a_screen_x, a_screen_y)
			end

			docking_manager.tool_bar_manager.floating_tool_bars.extend (floating_tool_bar)

			assistant.update_indicator
		ensure
			pruned: row /= Void implies not row.has (tool_bar)
			is_floating: is_floating
		end

	dock is
			-- Dock to a tool bar area.
		require
			not_destroyed: not is_destroyed
			is_floating: is_floating
		do
			docking_manager.tool_bar_manager.floating_tool_bars.prune_all (floating_tool_bar)
			-- On windows, following line is not needed,
			-- But on Gtk, we need first disable capture then enable capture,
			-- because it's off-screen widget, it'll not have capture until it show again (in SD_TOOL_BAR_HOT_ZONE).
			tool_bar.disable_capture

			floating_tool_bar.prune (tool_bar)
			floating_tool_bar.destroy
			floating_tool_bar := Void

			if tool_bar.parent /= Void then
				tool_bar.parent.prune (tool_bar)
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

	extend (a_content: SD_TOOL_BAR_CONTENT) is
			-- Extend `a_content'.
		require
			not_destroyed: not is_destroyed
			a_content_not_void: a_content /= Void
			content_not_set: content = Void
		local
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			content := a_content
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
			create tail_indicator.make
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

	set_position (a_screen_x, a_screen_y: INTEGER) is
			-- Set position when `is_floating'.
		require
			not_destroyed: not is_destroyed
			is_floating: is_floating
		do
			floating_tool_bar.set_position (a_screen_x, a_screen_y)
		ensure
			set: floating_tool_bar.screen_x = a_screen_x and floating_tool_bar.screen_y = a_screen_y
		end

	compute_minmum_size is
			-- Redefine
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.compute_minimum_size
			if row /= Void and row.has (tool_bar) then
				row.set_item_size (tool_bar, tool_bar.minimum_width, tool_bar.minimum_height)
			end
		end

	wipe_out is
			-- Wipe out
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.wipe_out
			content := Void
		end

	destroy is
			-- Destroy
			-- Called by SD_TOOL_BAR_MANAGER.destroy
		local
			l_row: SD_TOOL_BAR_ROW
		do
			prune_tool_bar_zone (Current)
			l_row := row
			if l_row /= Void then
				l_row.destroy
			end
			if agents /= Void then
				agents.destroy
				agents := Void
			end
			if tool_bar /= Void then
				tool_bar.destroy
				tool_bar := Void
			end
			docking_manager := Void

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

	show is
			-- Show
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.show
		end

	hide is
			-- Hide
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.hide
		end

	prune (a_item: SD_TOOL_BAR_ITEM) is
			-- Prune `a_item'
		require
			not_destroyed: not is_destroyed
		do
			tool_bar.prune (a_item)
		end

feature -- Query

	is_floating: BOOLEAN is
			-- If Current floating?
		require
			not_destroyed: not is_destroyed
		do
			Result := floating_tool_bar /= Void
		end

	is_destroyed: BOOLEAN
			-- If Current destoryed?

	customize_dialog: SD_TOOL_BAR_CUSTOMIZE_DIALOG
			-- SD_TOOL_BAR_CUSTOMIZE_DIALOG if exists.

	tool_bar: SD_TOOL_BAR
			-- Tool bar which managed by Current.

	is_vertical: BOOLEAN
			-- Is `Current' vertical layout or horizontal layout?

	content: SD_TOOL_BAR_CONTENT
			-- Content in `Current'.

	tool_bar_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM] is
			-- Tool bar items on `Current' including invisible items.
		require
			not_destroyed: not is_destroyed
		do
			Result := content.items
		ensure
			not_void: Result /= Void
		end

	row: SD_TOOL_BAR_ROW is
			-- Parent which contain `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result ?= tool_bar.parent
		end

	maximize_size: INTEGER
			-- Maximize width of Current if not `is_vertical'. Maximize height of Current if `is_vertical'.

	size: INTEGER is
			-- Current size.
		require
			not_destroyed: not is_destroyed
		do
			if is_vertical then
				Result := tool_bar.minimum_height
			else
				-- On GTK, SD_TOOL_BAR `minimum_width' is not always equal `width' here.
				-- On Windows, SD_TOOL_BAR `minimum_width' is always equal `width' here.
				-- See bug#12651, so we use `minimum_width' for it.
				-- Same for `minimum_height' and `height'.
				Result := tool_bar.minimum_width
			end
		ensure
			valid: Result >= 0
		end

	position: INTEGER is
			-- X position if not `is_vertical' or Y position if `is_vertical'.
		require
			not_destroyed: not is_destroyed
		do
			if is_vertical then
				Result := tool_bar.y_position
			else
				Result := tool_bar.x_position
			end
		end

	hidden_dialog_position: EV_COORDINATE is
			-- Screen position for SD_TOOL_BAR_HIDDEN_ITEM_DIALOG.
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
			-- Assistant to manage size issues.

	drag_area_rectangle: EV_RECTANGLE
			-- Drag area rectangle

	floating_tool_bar: SD_FLOATING_TOOL_BAR_ZONE
			-- Floating tool bar zone which contain `Current' when floating.

	has (a_item: SD_TOOL_BAR_ITEM): BOOLEAN is
			-- If Current has `a_item'?
		require
			not_destroyed: not is_destroyed
		do
			Result := tool_bar.has (a_item)
		end

	has_right_click_action (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If button at `a_screen_x', `a_screen_y' has pointer actions?
		require
			not_destroyed: not is_destroyed
		local
			l_button: SD_TOOL_BAR_BUTTON
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				from
					tool_bar_items.start
				until
					tool_bar_items.after or Result
				loop
					l_button ?= tool_bar_items.item
					if l_button /= Void and l_button.rectangle.has_x_y (a_screen_x - tool_bar.screen_x, a_screen_y - tool_bar.screen_y) then
						Result := l_button.pointer_button_press_actions.count > 0
					end
					tool_bar_items.forth
				end
			end
		end

	has_pebble_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If button at `a_screen_x', `a_screen_y' has pebble function?
		require
			not_destroyed: not is_destroyed
		local
			l_item: SD_TOOL_BAR_ITEM
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				l_item := tool_bar.item_at_position (a_screen_x, a_screen_y)
				if l_item /= Void then
					Result := l_item.pebble_function /= Void
				end
			end
		end

	has_drop_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN is
			-- If button at `a_screen_x', `a_screen_y' has drop function?
		require
			not_destroyed: not is_destroyed
		local
			l_item: SD_TOOL_BAR_ITEM
		do
			if tool_bar.is_item_position_valid (a_screen_x, a_screen_y) then
				l_item := tool_bar.item_at_position (a_screen_x, a_screen_y)
				if l_item /= Void then
					Result := l_item.drop_actions.count >= 1
				end
			end
		end

feature {NONE} -- Agents

	on_redraw_drag_area (a_x: INTEGER; a_y: INTEGER; a_width: INTEGER; a_height: INTEGER) is
			-- Handle redraw drag area.
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

	hash_code: INTEGER is
			-- Hash code is index in all tool bar zones.
		do
			Result := docking_manager.tool_bar_manager.contents.index_of (content, 1)
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
		require
			not_destroyed: not is_destroyed
		local
			l_row_height: INTEGER
		do
			l_row_height := tool_bar.row_height
			-- Maybe the row height not setted at the moment, we use `standard_height' as default.
			if l_row_height <= 0 then
				l_row_height := tool_bar.standard_height
			end
			if a_is_for_horizontal then
				-- Change to horizontal drag area.
				tool_bar.set_start_x (internal_drag_area_size)
				tool_bar.set_start_y (0)
				create drag_area_rectangle.make (0, 0, internal_drag_area_size, l_row_height)
			else
				-- Change to vertical drag area.
				tool_bar.set_start_x (0)
				tool_bar.set_start_y (internal_drag_area_size)
				create drag_area_rectangle.make (0, 0, l_row_height, internal_drag_area_size)
			end
		end

	internal_text: ARRAYED_LIST [STRING_GENERAL]
			-- When `is_vertical' we hide all texts, store orignal texts here.

	internal_hidden_widget_items: DS_HASH_TABLE [SD_TOOL_BAR_WIDGET_ITEM, INTEGER]
			-- When `is_vertical' we hide all widget tool bar items, store orignal items here.

	is_need_restore_hidden_items: BOOLEAN is
			-- If need restore hidden items?
		require
			not_destroyed: not is_destroyed
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			if internal_hidden_widget_items /= Void and tool_bar /= Void then
				if not internal_hidden_widget_items.is_empty then
					l_item := internal_hidden_widget_items.first
					if not tool_bar.has (l_item)  then
						Result := True
					end
				end
			end
		end

	restore_hidden_widget_items is
			-- Restore hidden widget items
		require
			not_destroyed: not is_destroyed
			not_void: internal_hidden_widget_items /= Void
		local
			l_item: SD_TOOL_BAR_WIDGET_ITEM
			l_parent: EV_CONTAINER
		do
			from
				internal_hidden_widget_items.start
			until
				internal_hidden_widget_items.after
			loop
				-- on GTK, when dragging a tool bar t swtich between the state of docking and floating constanly.
				-- SD_TOOL_BAR_WIDGET_ITEM parent will not be void sometimes.
				l_item := internal_hidden_widget_items.item (internal_hidden_widget_items.key_for_iteration)
				l_parent := l_item.widget.parent
				if l_parent /= Void then
					l_parent.prune (l_item.widget)
				end
				tool_bar.force (l_item, internal_hidden_widget_items.key_for_iteration)
				internal_hidden_widget_items.forth
			end
		end

feature {SD_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_HIDDEN_ITEM_DIALOG, SD_FLOATING_TOOL_BAR_ZONE, SD_TOOL_BAR, SD_TOOL_BAR_CONTENT} -- Internal issues

	tail_indicator: SD_TOOL_BAR_NARROW_BUTTON
			-- Button at tail of Current, which used for show hide buttons and customize dialog.

	docking_manager: SD_DOCKING_MANAGER
			-- Docking manager manage Current.

	extend_one_item (a_item: SD_TOOL_BAR_ITEM) is
			-- Extend `a_item' if `a_item' is_displayed.
		require
			not_destroyed: not is_destroyed
		local
			l_widget_item: SD_TOOL_BAR_WIDGET_ITEM
		do
			if a_item /= Void and then a_item.is_displayed then
				l_widget_item ?= a_item
				if l_widget_item /= Void then
					if l_widget_item.widget.parent /= Void then
						l_widget_item.widget.parent.prune (l_widget_item.widget)
					end
				end
				tool_bar.extend (a_item)
			end
		end

	update_maximum_size is
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

	set_customize_dialog (a_dialog: like customize_dialog) is
			-- Set `customize_dialog' with `a_dialog'
		require
			not_destroyed: not is_destroyed
		do
			customize_dialog := a_dialog
		ensure
			set: customize_dialog = a_dialog
		end

feature {SD_FLOATING_TOOL_BAR_ZONE} -- Internal issues.

	agents: SD_TOOL_BAR_DRAGGING_AGENTS
			-- Dragging agents.
invariant

	not_void: internal_shared /= Void
	not_void: assistant /= Void

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
