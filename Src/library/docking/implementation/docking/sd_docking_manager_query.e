note
	description: "Docking manager queries."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_QUERY

inherit
	SD_ACCESS

	SD_DOCKING_MANAGER_HOLDER

create
	make

feature {NONE} -- Creation

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Associate new object with `a_docking_manager'.
		do
			docking_manager := a_docking_manager
		end

feature -- Querys

	auto_hide_panel (a_direction: INTEGER): SD_AUTO_HIDE_PANEL
			-- Auto hide panel at `a_direction'
		require
			a_direction_valid: a_direction = {SD_ENUMERATION}.top or a_direction = {SD_ENUMERATION}.bottom
				or a_direction = {SD_ENUMERATION}.left or a_direction = {SD_ENUMERATION}.right
		do
			inspect a_direction
			when {SD_ENUMERATION}.bottom then
				Result := docking_manager.internal_auto_hide_panel_bottom
			when {SD_ENUMERATION}.top then
				Result := docking_manager.internal_auto_hide_panel_top
			when {SD_ENUMERATION}.left then
				Result := docking_manager.internal_auto_hide_panel_left
			when {SD_ENUMERATION}.right then
				Result := docking_manager.internal_auto_hide_panel_right
			end
		ensure
			not_void: Result /= Void
		end

	content_by_title (a_unique_title: READABLE_STRING_GENERAL): detachable SD_CONTENT
			-- Content by a_title
		require
			a_title_not_void: a_unique_title /= Void and then not a_unique_title.is_empty
		do
			Result := content_by_title_for_restore (a_unique_title)
		end

	contents_editors: ARRAYED_LIST [SD_CONTENT]
			-- All editor type contents
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from
				create Result.make (5)
				l_contents := docking_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				if l_contents.item.type = {SD_ENUMERATION}.editor then
					Result.extend (l_contents.item)
				end
				l_contents.forth
			end
		ensure
			not_void: Result /= Void
		end

	zone_under_pointer: detachable SD_ZONE
			-- {SD_CONTENT} under mouse pointer
			-- Result void if not found
		local
			l_widget: EV_WIDGET
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_item: SD_ZONE
		do
			l_widget := (create {EV_SCREEN}).widget_at_mouse_pointer
			if l_widget /= Void then
				from
					l_zones := docking_manager.zones.zones
					l_zones.start
				until
					l_zones.after or Result /= Void
				loop
					l_item := l_zones.item
					if attached {EV_CONTAINER} l_item as lt_container then
						if l_widget = lt_container or lt_container.has_recursive (l_widget) then
							Result := l_item
						end
					else
						check not_possible: False end
					end

					l_zones.forth
				end
			end
		end

	has_content_visible: BOOLEAN
			--  Has visible contents except editor place holder content?
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from

				l_contents := docking_manager.contents
				l_contents.start
			until
				l_contents.after or Result
			loop
				if l_contents.item.is_visible and then l_contents.item /= docking_manager.zones.place_holder_content then
					Result := True
				end
				l_contents.forth
			end
		end

	is_opening_tools_layout: BOOLEAN
			-- If executing {SD_DOCKING_MANAGER_QUERY}.`open_tools_config'

	content_by_title_for_restore (a_unique_title: READABLE_STRING_GENERAL): detachable SD_CONTENT
			-- Content by a_unique_title. Result = Void if not found
		require
			a_unique_title_not_void: a_unique_title /= Void
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
		do
			from
				l_contents := docking_manager.contents
				l_contents.start
			until
				l_contents.after or Result /= Void
			loop
				if l_contents.item.unique_title.as_string_32.is_equal (a_unique_title.as_string_32) then
					if is_opening_tools_layout then
						-- If opening tools layout, we ignore editor content
						if l_contents.item.type /= {SD_ENUMERATION}.editor then
							Result := l_contents.item
						end
					else
						Result := l_contents.item
					end
				end
				l_contents.forth
			end

			if
				not attached Result and then
				attached docking_manager.restoration_callback as l_callback
			then
					-- Try a registed callback on the docking manager.
					-- Check callback.
				Result := l_callback (a_unique_title)
			end

			if Result = Void then
				-- Maybe place holder content not be shown, we query it here
				Result := docking_manager.zones.place_holder_content
				if not a_unique_title.as_string_32.is_equal (Result.unique_title.as_string_32) then
					Result := Void
				end
			end
		end

	inner_container_by_widget (a_widget: EV_WIDGET): SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA which has `a_widget'
		require
			a_zone_not_void: a_widget /= Void
		do
			Result := internal_inner_container (a_widget)
			if not attached Result then
				Result := inner_container_main
			end
		ensure
			not_void: Result /= Void
		end

	inner_container (a_zone: SD_ZONE): SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA which has `a_zone'
		require
			a_zone_not_void: a_zone /= Void
		do
			if attached {EV_WIDGET} a_zone as lt_widget then
				Result := internal_inner_container (lt_widget)
			end
			if not attached Result then
				Result := inner_container_main
			end
		ensure
			not_void: Result /= Void
		end

	inner_container_include_hidden (a_zone: SD_ZONE): detachable SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA which `a_zone' in, also finding in widgets which are hidden by a maximized zone
			-- Maybe void if not found
		require
			not_void: a_zone /= Void
		do
			if attached {EV_WIDGET} a_zone as lt_widget then
				Result := internal_inner_container (lt_widget)
				if Result = Void then
						-- Maybe `a_zone' is hidden, because there is a zone maximized in that dock area.
					Result := maximized_inner_container (lt_widget)
				end
				if Result = Void then
					Result := maximized_hidden_main_container (a_zone)
				end
			else
				check not_possible: False end
			end
		end

	maximized_inner_container (a_zone: EV_WIDGET): detachable SD_MULTI_DOCK_AREA
			-- Find `a_zone' only in main areas which have maximized zone
			-- Maybe void if not found
		require
			not_void: a_zone /= Void
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_dock_area: SD_MULTI_DOCK_AREA
			l_hidden_widget: detachable EV_WIDGET
		do
			from
				l_zones := docking_manager.zones.maximized_zones
				l_zones.start
			until
				l_zones.after or Result /= Void
			loop
				l_dock_area := docking_manager.query.inner_container (l_zones.item)

				l_hidden_widget := l_zones.item.main_area_widget
				if l_hidden_widget = a_zone then
					Result := l_dock_area
				else
					if attached {EV_CONTAINER} l_hidden_widget as l_container then
						if l_container.has_recursive (a_zone) then
							Result := l_dock_area
						end
					end
				end
				l_zones.forth
			end
		end

	maximized_hidden_main_container (a_zone: SD_ZONE): detachable SD_MULTI_DOCK_AREA
			-- Find the item in main area hidden widget when whole editor area maximized
		local
			l_item: detachable EV_WIDGET
		do
			l_item := docking_manager.command.orignal_whole_item
			if l_item /= Void then
				if attached {EV_WIDGET} a_zone as lt_widget then
					check not_void_at_same_tiem: docking_manager.command.orignal_editor_parent /= Void end

					if attached {EV_CONTAINER} l_item as l_container then
						if l_container.has_recursive (lt_widget) then
							Result := inner_container_main
						end
					else
						if l_item = lt_widget then
							Result := inner_container_main
						end
					end
				else
					check not_possible: False end
				end
			end
		end

	is_main_inner_container (a_area: SD_MULTI_DOCK_AREA): BOOLEAN
			-- Contract support
			-- If a_area is first one in `inner_containers'.
		require
			a_area_not_void: a_area /= Void
		local
			l_areas: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_areas := docking_manager.inner_containers
			l_areas.start
			Result := l_areas.item = a_area
		end

	inner_container_main: SD_MULTI_DOCK_AREA
			-- Container in main window
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_containers := docking_manager.inner_containers
			l_containers.start
			Result := l_containers.item
		ensure
			not_void: Result /= Void
		end

	zone_max_screen_x (a_zone: SD_ZONE): INTEGER
			-- Max screen x of a_zone
		local
			l_container: EV_WIDGET
		do
			l_container := docking_manager.top_container
			Result := l_container.screen_x + l_container.width
		end

	container_rectangle: EV_RECTANGLE
			-- Rectangle area of `center_area'
		require
			not_destroyed: not docking_manager.is_destroyed
		local
			l_center_area: EV_WIDGET
			l_auto_hide_panel: detachable SD_AUTO_HIDE_PANEL
		do
			l_auto_hide_panel := docking_manager.internal_auto_hide_panel_top
			check l_auto_hide_panel /= Void end -- Implied by precondition `not_destroyed'
			l_center_area := docking_manager.main_container.center_area
			create Result.make (l_center_area.x_position, l_center_area.y_position +
				l_auto_hide_panel.height, l_center_area.width, l_center_area.height)
		ensure
			not_void: Result /= Void
		end

	fixed_area_rectangle: EV_RECTANGLE
			-- Rectangle area of `fixed_area'
		local
			l_widget: EV_WIDGET
		do
			l_widget := docking_manager.fixed_area
			create Result.make (l_widget.x_position, l_widget.y_position, l_widget.width, l_widget.height)
		end

	container_rectangle_screen: EV_RECTANGLE
			-- Rectangle area of the `fixed_area' base on screen
		local
			l_center_area: EV_WIDGET
		do
			l_center_area := docking_manager.main_container.center_area
			create Result.make (l_center_area.screen_x, l_center_area.screen_y, l_center_area.width, l_center_area.height)
		ensure
			not_void: Result /= Void
		end

	golbal_accelerators: SEQUENCE [EV_ACCELERATOR]
			-- Golbal accelerators
		do
			Result := docking_manager.main_window.accelerators
		end

	find_window_by_widget (a_widget: EV_WIDGET): EV_WINDOW
			-- Find a window which can lock_update
		require
			a_zone_not_void: a_widget /= Void
		local
			l_main_container: SD_MULTI_DOCK_AREA
		do
			l_main_container := docking_manager.query.inner_container_by_widget (a_widget)
			Result := l_main_container.parent_floating_zone
			if not attached Result then
				Result := docking_manager.main_window
			end
		ensure
			not_void: Result /= Void
		end

	find_window_by_zone (a_zone: SD_ZONE): EV_WINDOW
			-- Find a window which can lock_update.
		require
			a_zone_not_void: a_zone /= Void
		do
			Result := docking_manager.query.inner_container (a_zone).parent_floating_zone
			if not attached Result then
				Result := docking_manager.main_window
			end
		ensure
			not_void: Result /= Void
		end

	is_zone_in_same_window (a_zone_one, a_zone_two: SD_ZONE): BOOLEAN
			-- If a_zone_one and a_zone_two in same window?
		do
			Result := find_window_by_zone (a_zone_one) = find_window_by_zone (a_zone_two)
		end

	floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			-- All floating zones in Current system
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			l_containers := docking_manager.inner_containers
			create Result.make (l_containers.count - 1)
			from
				l_containers.start
			until
				l_containers.after
			loop
				if attached l_containers.item.parent as l_parent then
					if attached l_parent.parent as l_parent_parent then
						if attached l_parent_parent.parent as l_parent_parent_parent then
							if attached {SD_FLOATING_ZONE} l_parent_parent_parent.parent as l_floating_zone then
								Result.extend (l_floating_zone)
							end
						end
					end
				end
				l_containers.forth
			end
			check count_right: l_containers.count - 1 = Result.count end
		ensure
			not_void: Result /= Void
		end

	is_floating (a_content: SD_CONTENT): BOOLEAN
			-- If `a_content' floating?
		require
			not_void: a_content /= Void
		local
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_container: SD_MULTI_DOCK_AREA
		do
			if attached a_content.state.zone as l_zone then
				from
					l_floating_zones := floating_zones
					l_floating_zones.start
				until
					l_floating_zones.after or Result
				loop
					l_container := l_floating_zones.item.inner_container
					if l_container /= Void then
						if attached {EV_WIDGET} l_zone as lt_widget then
							Result := l_container.has_recursive (lt_widget)
						else
							check not_possible: False end
						end
					end
					l_floating_zones.forth
				end
			end
		end

	unique_title_verified: BOOLEAN
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			c1, c2: like docking_manager.contents.new_cursor
			l_title: READABLE_STRING_GENERAL
		do
			l_contents := docking_manager.contents
			c1 := l_contents.new_cursor
			c2 := l_contents.new_cursor
			from
				c1.start
			until
				c1.after or not Result
			loop
				l_content := c1.item
				l_title := l_content.unique_title
				from
					c2.start
				until
					c2.after or not Result
				loop
					if l_content /= c2.item then
						Result := not l_title.same_string (c2.item.unique_title)
					end
					c2.forth
				end
				c1.forth
			end
		end

	is_unique_title_free_to_use (a_title: READABLE_STRING_GENERAL): BOOLEAN
			-- If `a_title' unique in all current contents? Not already used by other contents?
		local
			l_content: ARRAYED_LIST [SD_CONTENT]
		do
			l_content := docking_manager.contents
			from
				Result := True
				l_content.start
			until
				l_content.after or not Result
			loop
				if l_content.item.unique_title.same_string_general (a_title) then
					Result := False
				end
				l_content.forth
			end
		end

	has_auto_hide_zone: BOOLEAN
			-- If Current we have SD_AUTO_HIDE_ZONE showing?
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			l_zones := docking_manager.zones.zones
			from
				l_zones.start
			until
				l_zones.after or Result
			loop
				if attached {SD_AUTO_HIDE_ZONE} l_zones.item as l_auto_hide_zone then
					Result := True
				end
				l_zones.forth
			end
		end

	all_zones_in_widget (a_widget: EV_WIDGET): ARRAYED_LIST [SD_ZONE]
			-- All zones in `a_widget' if exist
		require
			not_void: a_widget /= Void
		do
			create Result.make (5)
			zones_recursive (a_widget, Result)
		ensure
			not_void: Result /= Void
		end

	only_one_editor_zone: detachable SD_UPPER_ZONE
			-- If Current docking layout only have one editor zone (only one SD_DOCKING_ZONE_UPPER or SD_TAB_ZONE_UPPER)?
			-- If yes, then the result is the only one editor zone
			-- If not only one, then result is Void
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_count: INTEGER
		do
			from
				l_zones := docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after
			loop
				if attached {SD_UPPER_ZONE} l_zones.item as l_upper_zone then
					l_count := l_count + 1
					Result := l_upper_zone
				end
				l_zones.forth
			end
			if l_count /= 1 then
				Result := Void
			end
		ensure
			valid: editor_zone_count = 1 implies Result /= Void
			valid: editor_zone_count /= 1 implies Result = Void
		end

	editor_zone_count: INTEGER
			-- How many editors zones (not editor content) now?
		local
			l_zones: ARRAYED_LIST [SD_ZONE]
		do
			from
				l_zones := docking_manager.zones.zones
				l_zones.start
			until
				l_zones.after
			loop
				if attached {SD_UPPER_ZONE} l_zones.item as l_upper_zone then
					Result := Result + 1
				end
				l_zones.forth
			end
		end

	docker_mediator (a_caller: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_DOCKER_MEDIATOR
			-- Factory method
		require
			not_void: a_caller /= Void
			not_void: a_docking_manager /= Void
		local
			l_tool, l_editor: BOOLEAN
		do
			if a_caller.child_zone_count = 1 and then a_caller.content /= Void then
				if a_caller.content.type = {SD_ENUMERATION}.tool and not docking_manager.is_locked then
					l_tool := True
				end
				if a_caller.content.type = {SD_ENUMERATION}.editor and not docking_manager.is_editor_locked then
					l_editor := True
				end
			end

			if ((not (attached {SD_FLOATING_ZONE} a_caller)) and then (l_tool or l_editor)) or
				((attached {SD_FLOATING_ZONE} a_caller) and not docking_manager.is_locked) then
				create Result.make (a_caller, a_docking_manager)
			else
				create {SD_VOID_DOCKER_MEDIATOR} Result.make (a_caller, a_docking_manager)
			end
		ensure
			not_void: Result /= Void
		end

	is_in_main_window (a_tool_bar: SD_GENERIC_TOOL_BAR): BOOLEAN
			-- If `a_widget' in main window?
		do
			if attached {EV_WIDGET} a_tool_bar as lt_widget then
				Result :=
					docking_manager.tool_bar_container.top.has_recursive (lt_widget) or else
					docking_manager.tool_bar_container.bottom.has_recursive (lt_widget) or else
					docking_manager.tool_bar_container.left.has_recursive (lt_widget) or else
					docking_manager.tool_bar_container.right.has_recursive (lt_widget)
			else
				check not_possible: False end
			end
		end

	restore_whole_editor_area_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically, actions will be invoked
		do
			Result := internal_restore_whole_editor_area_actions
			if not attached Result then
				create Result
				internal_restore_whole_editor_area_actions := Result
			end
		ensure
			not_void: Result /= Void
		end

	internal_restore_whole_editor_area_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically, actions will be invoked

	restore_whole_editor_area_for_minimized_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically for minimized editor area, actions will be invoked.
		do
			Result := internal_restore_whole_editor_area_for_minimized_actions
			if not attached Result then
				create Result
				internal_restore_whole_editor_area_for_minimized_actions := Result
			end
		ensure
			not_void: Result /= Void
		end

	internal_restore_whole_editor_area_for_minimized_actions: detachable EV_NOTIFY_ACTION_SEQUENCE
			-- When whole editor area restored automatically for minimized editor area, actions will be invoked

feature -- Command

	set_opening_tools_layout (a_bool: BOOLEAN)
			-- Set `is_opening_tools_layout' with `a_bool'
		do
			is_opening_tools_layout := a_bool
		ensure
			set: is_opening_tools_layout = a_bool
		end

feature {NONE} -- Implemnetation

	internal_inner_container (a_widget: EV_WIDGET): detachable SD_MULTI_DOCK_AREA
			-- SD_MULTI_DOCK_AREA which `a_zone' in
			-- Maybe void if not found
		require
			not_void: a_widget /= Void
		local
			l_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
		do
			from
				l_containers := docking_manager.inner_containers
				l_containers.start
			until
				l_containers.after or Result /= Void
			loop
				Result := l_containers.item
				if not Result.has_recursive (a_widget) then
					Result := Void
				end
				l_containers.forth
			end
		end

	zones_recursive (a_widget: EV_WIDGET; a_list: ARRAYED_LIST [SD_ZONE])
			-- Add all zones in `a_widget' to `a_list'
		require
			a_widget_not_void: a_widget /= Void
			a_list_not_void: a_list /= Void
		local
			l_list: LINEAR [EV_WIDGET]
		do
			-- Must first judge if is a SD_ZONE, becaue a SD_ZONE is a EV_CONTAINER too
			if attached {SD_ZONE} a_widget as l_zone then
				a_list.extend (l_zone)
			elseif attached {EV_CONTAINER} a_widget as l_container then
				l_list := l_container.linear_representation
				from
					l_list.start
				until
					l_list.after
				loop
					zones_recursive (l_list.item, a_list)
					l_list.forth
				end
			end
		end

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
