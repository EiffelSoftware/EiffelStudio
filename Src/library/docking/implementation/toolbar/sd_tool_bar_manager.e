note
	description: "Manager that manage all toolbars. This manager directly under SD_DOCKING_MANAGER's control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_MANAGER

inherit
	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

create
	{SD_DOCKING_MANAGER} make

feature {NONE} -- Initialization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_docking_manager'.
		do
			docking_manager := a_docking_manager
			create internal_shared
			create contents
			create floating_tool_bars.make (1)
			application_right_click_agent := agent on_menu_area_click
		end

feature {SD_DOCKING_MANAGER} -- Initialization

	add_actions
			-- Register required actions.
		local
			l_platform: PLATFORM
		do
				-- Initialize right click menu.
			create l_platform
				-- We will use pointer release actions only in the future. Larry 2007-6-7
			if l_platform.is_windows then
				ev_application.pointer_button_press_actions.extend (application_right_click_agent)
			else
				ev_application.pointer_button_release_actions.extend (application_right_click_agent)
			end
			contents.add_actions.extend (agent on_add_tool_bar_content)
			contents.remove_actions.extend (agent on_remove_tool_bar_content)
		ensure
			action_added: contents.add_actions.count = 1 and contents.remove_actions.count = 1
		end

feature -- Query

	contents: ACTIVE_LIST [SD_TOOL_BAR_CONTENT]
			-- All tool bar contents.

	content_by_title (a_title: READABLE_STRING_GENERAL): SD_TOOL_BAR_CONTENT
			-- SD_TOOL_BAR_CONTENT which has `a_title'.
		require
			not_destroyed: not is_destroyed
			a_title_not_void: a_title /= Void
			has: has (a_title)
		do
			across
				contents as l_content
			until
				attached Result
			loop
				if a_title.same_string (l_content.unique_title) then
					Result := l_content
				end
			end
			check has: Result /= Void then
				-- See the precondition  `has: has (a_title)`
			end
		end

	has (a_unique_title: READABLE_STRING_GENERAL): BOOLEAN
			-- If `content' has item which unique title is `a_unique_title'?
		require
			a_unique_title_not_void: a_unique_title /= Void
		do
			across
				contents as l_content
			until
				Result
			loop
				Result := a_unique_title.same_string (l_content.unique_title)
			end
		end

	is_locked: BOOLEAN
			-- If docking disabled?

	is_destroyed: BOOLEAN
			-- If Current destroyed?

feature -- Command

	lock
			-- Disable drag area for docked tool bars.
			-- Disable dock for floating tool bars.
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			loop
				if attached l_content.zone as l_zone then
					l_zone.disable_drag_area
				end
			end
			docking_manager.command.resize (True)
			is_locked := True
		ensure
			locked: is_locked
		end

	unlock
			-- Enable drag area for docked tool bars.
			-- Enable dock for floating tool bars.
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			loop
				if attached l_content.zone as l_zone then
					l_zone.enable_drag_area
				end
			end
			docking_manager.command.resize (True)
			is_locked := False
		ensure
			unlocked: not is_locked
		end

	destroy
			-- Release hooks
		local
			l_floating_tool_bars: like floating_tool_bars
			l_platform: PLATFORM
		do
			from
				l_floating_tool_bars := floating_tool_bars
				l_floating_tool_bars.start
			until
				l_floating_tool_bars.after
			loop
				l_floating_tool_bars.item.destroy
				l_floating_tool_bars.forth
			end
			create l_platform
			if l_platform.is_windows then
				ev_application.pointer_button_press_actions.prune_all (application_right_click_agent)
			else
				ev_application.pointer_button_release_actions.prune_all (application_right_click_agent)
			end

			contents.do_all (agent (ia_content: SD_TOOL_BAR_CONTENT)
										require
											ia_content_attached: ia_content /= Void
										do
											ia_content.destroy
										end)
			contents.wipe_out
			clear_docking_manager

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

feature {SD_DOCKING_MANAGER_AGENTS, SD_OPEN_CONFIG_MEDIATOR, SD_TOOL_BAR_ZONE_ASSISTANT, SD_TOOL_BAR_CONTENT} -- Internal functions.

	on_resize (a_x, a_y, a_width, a_height: INTEGER; a_force: BOOLEAN)
			-- Handle main window resize event.
		require
			not_destroyed: not is_destroyed
		do
			if last_width /= a_width or last_height /= a_height or a_force then
				if last_width /= a_width or a_force then
					notify_four_area (a_width, a_height, True)
				end
				if last_height /= a_height or a_force then
					notify_four_area (a_width, a_height, False)
				end
			 	last_width := a_width
			 	last_height := a_height
			end
		end

	hide_all_floating
			-- Hide all floating tool bars.
		require
			not_destroyed: not is_destroyed
		local
			l_snapshot: like floating_tool_bars
		do
			from
				l_snapshot := floating_tool_bars.twin
				l_snapshot.start
			until
				l_snapshot.after
			loop
				l_snapshot.item.hide
				l_snapshot.forth
			end
		end

	show_all_floating
			-- Show all floating tool bars.
		require
			not_destroyed: not is_destroyed
		local
			l_snapshot: like floating_tool_bars
		do
			if not is_all_floating_displayed then
				from
					l_snapshot := floating_tool_bars.twin
					l_snapshot.start
				until
					l_snapshot.after
				loop
					l_snapshot.item.show
					l_snapshot.forth
				end
			end
		end

	is_all_floating_displayed: BOOLEAN
			-- If floating tool bar zones hidden?
		require
			not_destroyed: not is_destroyed
		local
			l_floating_tool_bars: like floating_tool_bars
		do
			from
				Result := True
				l_floating_tool_bars := floating_tool_bars
				l_floating_tool_bars.start
			until
				l_floating_tool_bars.after or not Result
			loop
				Result := l_floating_tool_bars.item.is_displayed
				l_floating_tool_bars.forth
			end
		end

	set_top (a_content: SD_TOOL_BAR_CONTENT; a_direction: INTEGER)
			-- Set `a_content' dock at `a_direction'
		require
			not_destroyed: not is_destroyed
			direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
			not_void: a_content /= Void
			main_window_not_has:
		local
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			create l_tool_bar_row.make (docking_manager, False)
			tool_bar_container (a_direction).extend (l_tool_bar_row)
			set_top_imp (a_content, l_tool_bar_row)
		end

	set_top_with (a_source_content, a_target_content: SD_TOOL_BAR_CONTENT)
			-- Set `a_source_content' docking at same row/column of `a_target_content'.
		require
			not_destroyed: not is_destroyed
			not_void: a_source_content /= Void and a_target_content /= Void
			docking: a_target_content.is_docking
			not_floating: not a_target_content.is_floating
		do
			if
				attached a_target_content.zone as l_zone and then
				attached l_zone.row as l_tool_bar_row
			then
				set_top_imp (a_source_content, l_tool_bar_row)
			else
				check
					from_precondition_docking: False
				end
			end
		end

feature {SD_DOCKING_MANAGER_AGENTS, SD_OPEN_CONFIG_MEDIATOR, SD_SAVE_CONFIG_MEDIATOR,
			SD_TOOL_BAR_ZONE_ASSISTANT,	SD_TOOL_BAR_ZONE, SD_DEBUG_ACCESS, SD_GENERIC_TOOL_BAR,
			SD_TOOL_BAR_CONTENT, SD_ACCESS} -- Internal querys

	tool_bar_container (a_direction: INTEGER): EV_BOX
			-- Tool bar container base on `a_direction'.
		require
			not_destroyed: not is_destroyed
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			inspect
				a_direction
			when {SD_ENUMERATION}.top then
				Result := docking_manager.tool_bar_container.top
			when {SD_ENUMERATION}.bottom then
				Result := docking_manager.tool_bar_container.bottom
			when {SD_ENUMERATION}.left then
				Result := docking_manager.tool_bar_container.left
			when {SD_ENUMERATION}.right then
				Result := docking_manager.tool_bar_container.right
			end
		ensure
			not_void: Result /= Void
		end

	container_direction (a_tool_bar: SD_TOOL_BAR_ZONE): INTEGER
			-- Tool bar container directions.
		require
			not_destroyed: not is_destroyed
			not_void: a_tool_bar /= Void
			not_floating: not a_tool_bar.is_floating
--TODO			has: attached a_tool_bar.content as c and then contents.has (c)
		do
			if attached {EV_WIDGET} a_tool_bar.tool_bar as lt_widget then
				if docking_manager.tool_bar_container.top.has_recursive (lt_widget) then
					Result := {SD_ENUMERATION}.top
				elseif docking_manager.tool_bar_container.bottom.has_recursive (lt_widget) then
					Result := {SD_ENUMERATION}.bottom
				elseif docking_manager.tool_bar_container.left.has_recursive (lt_widget) then
					Result := {SD_ENUMERATION}.left
				elseif docking_manager.tool_bar_container.right.has_recursive (lt_widget) then
					Result := {SD_ENUMERATION}.right
				end
			else
				check not_possible: False end
			end
		ensure
			vaild: Result = {SD_ENUMERATION}.top or Result = {SD_ENUMERATION}.bottom
				or Result = {SD_ENUMERATION}.left or Result = {SD_ENUMERATION}.right
		end

	floating_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			-- All floating tool bars.

	hidden_docking_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			-- Hidden docking contents.
		require
			not_destroyed: not is_destroyed
		do
			create Result.make (contents.count)
			Result.append (contents)

			across
				floating_tool_bars.twin as l_item
			loop
				-- FIXIT: There is a bug in prune_all of ACTIVE_LIST
				Result.start
				Result.prune (l_item.content)
			end
		end

	content_of (a_tool_bar: SD_GENERIC_TOOL_BAR): detachable SD_TOOL_BAR_CONTENT
			-- Content of `a_tool_bar'
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			until
				Result /= Void
			loop
				if attached l_content.zone as l_zone and then l_zone.tool_bar = a_tool_bar then
					Result := l_content
				end
			end
		end

feature {NONE} -- Agents

	on_add_tool_bar_content (a_content: SD_TOOL_BAR_CONTENT)
			-- Handle add tool bar content.
		require
			not_destroyed: not is_destroyed
			a_tool_bar_item_not_void: a_content /= Void
		do
			a_content.set_manager (Current)
		end

	on_remove_tool_bar_content (a_content: SD_TOOL_BAR_CONTENT)
			-- Handle remove tool bar content.
		require
			not_destroyed: not is_destroyed
			a_tool_bar_item_not_void: a_content /= Void
		do
			if a_content.manager = Current then
				a_content.set_manager (Void)
			end
		end

	on_menu_area_click (a_widget: EV_WIDGET; a_button, a_screen_x, a_screen_y: INTEGER)
			-- Handle menu area right click.
		require
			not_destroyed: not is_destroyed
		do
			-- End user not dragging a tool bar.
			if internal_shared.tool_bar_docker_mediator_cell.item = Void then
				if
					a_button = {EV_POINTER_CONSTANTS}.right and then
					is_at_menu_area (a_widget) and then
					not has_pointer_actions (a_screen_x, a_screen_y) and then
					not has_pebble_function (a_screen_x, a_screen_y) and then
					not has_drop_function (a_screen_x, a_screen_y) and then
					not (attached {EV_COMBO_BOX} a_widget)
				then
					-- We query if a button `has_drop_function' before showing the menu, because if a
					-- pick action starts from a widget which is same as the widget receive the drop
					-- action, then there will be an additional pointer click actions called after drop
					-- action. If the pick action not from the same widget which receive the drop action,
					-- then there won't be a pointer click actions action called after drop action. I think
					-- this is a bug.		 Larry Apr. 27th 2007.
					right_click_menu.show
				end
			end
		end

feature {NONE} -- Implementation

	notify_four_area (a_width, a_height: INTEGER; a_resize_horizontal: BOOLEAN)
			-- Called by `on_resize'. Notify four tool bar area.
		require
			not_destroyed: not is_destroyed
		local
			l_container: EV_CONTAINER
			l_vertical_height: INTEGER
			l_tool_bar_container: SD_TOOL_BAR_CONTAINER
		do
			if a_resize_horizontal then
				l_container := tool_bar_container ({SD_ENUMERATION}.top)
				notify_each_row (l_container, a_width)
				l_container := tool_bar_container ({SD_ENUMERATION}.bottom)
				notify_each_row (l_container, a_width)
			else
				l_tool_bar_container := docking_manager.tool_bar_container
				l_vertical_height := a_height - l_tool_bar_container.top.height - l_tool_bar_container.bottom.height
				if l_vertical_height >= 0  then
					l_container := tool_bar_container ({SD_ENUMERATION}.left)
					notify_each_row (l_container, l_vertical_height)
					l_container := tool_bar_container ({SD_ENUMERATION}.right)
					notify_each_row (l_container, l_vertical_height)
				end
			end
		end

	notify_each_row (a_tool_bar_container: EV_CONTAINER; a_size: INTEGER)
			-- Notify each row in a_tool_bar_container reisze to a_size.
			-- a_size is width for top, bottom tool bar container.
			-- a_size is height for left, right tool bar container.
		require
			not_destroyed: not is_destroyed
			not_void: a_tool_bar_container /= Void
			valid: a_size >= 0
		do
			across
				a_tool_bar_container as l_item
			loop
				if attached {SD_TOOL_BAR_ROW} l_item as l_row then
					l_row.on_resize (a_size)
				else
					check not_void: False end -- Implied by design of tool bar container
				end
			end
		end

	is_at_menu_area (a_widget: EV_WIDGET): BOOLEAN
			-- If `a_widget' in menus area?
		require
			not_destroyed: not is_destroyed
		local
			tbc: SD_TOOL_BAR_CONTAINER
		do
			tbc := docking_manager.tool_bar_container
			Result := tbc.top.has_recursive (a_widget)
					or tbc.bottom.has_recursive (a_widget)
					or tbc.left.has_recursive (a_widget)
					or tbc.right.has_recursive (a_widget)

			if not Result then
				across
					floating_tool_bars as l_item
				until
					Result
				loop
					Result := l_item.has_recursive (a_widget)
				end
			end
		end

	has_pointer_actions (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If SD_TOOL_BAR_BUTTON at `a_screen_x', `a_screen_y' has pointer button actions?
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			until
				Result
			loop
				if attached l_content.zone as l_zone then
					Result := l_zone.has_right_click_action (a_screen_x, a_screen_y)
				end
			end
		end

	has_pebble_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If SD_TOOL_BAR_ITEM at `a_screen_x', `a_screen_y' had pebble function?
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			until
				Result
			loop
				if attached l_content.zone as l_zone then
					Result := l_zone.has_pebble_function (a_screen_x, a_screen_y)
				end
			end
		end

	has_drop_function (a_screen_x, a_screen_y: INTEGER): BOOLEAN
			-- If SD_TOOL_BAR_ITEM at `a_screen_x', `a_screen_y' had pebble function?
		require
			not_destroyed: not is_destroyed
		do
			across
				contents as l_content
			until
				Result
			loop
				if attached l_content.zone as l_zone then
					Result := l_zone.has_drop_function (a_screen_x, a_screen_y)
				end
			end
		end

	right_click_menu: EV_MENU
			-- Construct a right click menu
		require
			not_destroyed: not is_destroyed
		local
			l_menu_item: EV_CHECK_MENU_ITEM
			l_custom_dialog: SD_TOOL_BAR_HIDDEN_ITEM_DIALOG
			l_string: READABLE_STRING_GENERAL
		do
			create Result
			across
				contents as l_content
			loop
				create l_menu_item.make_with_text (l_content.title)
				if l_content.is_visible then
					l_menu_item.enable_select
					l_menu_item.select_actions.extend (agent (ia_content: SD_TOOL_BAR_CONTENT)
															require
																not_void: ia_content /= Void
															do
																ia_content.close_request_actions.call ([])
															end (l_content))
				else
					l_menu_item.disable_select
					l_menu_item.select_actions.extend (agent (ia_content: SD_TOOL_BAR_CONTENT)
															require
																not_void: ia_content /= Void
															do
																ia_content.show_request_actions.call ([])
															end (l_content))
				end
				Result.extend (l_menu_item)
			end

			Result.extend (create {EV_MENU_SEPARATOR})
			-- Customize menu items

			across
				contents as l_content
			loop
				if attached l_content.zone as l_zone then
					create l_custom_dialog.make_for_menu (l_zone)
					l_string := internal_shared.interface_names.tool_bar_right_click_customize (l_content.title)
					create l_menu_item.make_with_text_and_action (l_string, agent l_custom_dialog.on_customize)
					Result.extend (l_menu_item)
				end
			end
		end

	set_top_imp (a_content: SD_TOOL_BAR_CONTENT; a_row: SD_TOOL_BAR_ROW)
			-- Common part of `set_top' and `set_top_with'.
		require
			not_destroyed: not is_destroyed
			not_void: a_content /= Void
			not_void: a_row /= Void
		local
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
		do
			a_content.set_manager (Current)
			create l_tool_bar_zone.make (False, a_content.is_menu_bar, a_content, docking_manager)

			a_row.set_ignore_resize (True)
			a_row.extend (l_tool_bar_zone)
			a_row.record_state
			a_row.set_ignore_resize (False)

			docking_manager.command.resize (True)
		end

	application_right_click_agent: PROCEDURE [EV_WIDGET, INTEGER_32, INTEGER_32, INTEGER_32]
			-- Pointer button right click hander instance.

	internal_shared: SD_SHARED
			-- All singletons.

	last_width, last_height: INTEGER
			-- Record last time tool bar container width/height, to improve efficiency.
invariant

	not_void: internal_shared /= Void
	not_void: contents /= Void
	not_void: floating_tool_bars /= Void
	items_not_void: contents.for_all (agent (v: SD_TOOL_BAR_CONTENT): BOOLEAN do Result := v /= Void end)

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
