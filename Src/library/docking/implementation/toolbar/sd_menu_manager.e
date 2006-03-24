indexing
	description: "Manager that manage all toolbars. This manager directly under SD_DOCKING_MANAGER's control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_MANAGER

create
	make

feature {NONE} -- Initialization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			create internal_shared
			create contents
			contents.add_actions.extend (agent on_add_tool_bar_content)
			contents.remove_actions.extend (agent on_remove_tool_bar_content)
			create floating_tool_bars.make (1)

		ensure
			action_added: contents.add_actions.count = 1 and contents.remove_actions.count = 1
			set: internal_docking_manager = a_docking_manager
		end

feature -- Query

	contents: ACTIVE_LIST [SD_TOOL_BAR_CONTENT]
			-- All tool bar contents.

	content_by_title (a_title: STRING): SD_TOOL_BAR_CONTENT is
			-- SD_tool_bar_CONTENT which has `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			from
				contents.start
			until
				contents.after or Result /= Void
			loop
				if contents.item.title.is_equal (a_title) then
					Result := contents.item
				end
				contents.forth
			end
		end

feature {SD_DOCKING_MANAGER_AGENTS, SD_CONFIG_MEDIATOR, SD_TOOL_BAR_ZONE_ASSISTANT} -- Internal functions.

	on_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Handle main window resize event.
		do
			if last_width /= a_width or last_height /= a_height then
				internal_docking_manager.command.lock_update (Void, True)
				if last_width /= a_width then
					notify_four_area (a_width, a_height, True)
				end
				if last_height /= a_height then
					notify_four_area (a_width, a_height, False)
				end
				internal_docking_manager.command.unlock_update
			 	last_width := a_width
			 	last_height := a_height
			end
		end

	hide_all_floating is
			-- Hide all floating tool bars.
		do
			from
				floating_tool_bars.start
			until
				floating_tool_bars.after
			loop
				floating_tool_bars.item.hide
				floating_tool_bars.forth
			end
		end

	show_all_floating is
			-- Show all floating tool bars.
		do
			from
				floating_tool_bars.start
			until
				floating_tool_bars.after
			loop
				floating_tool_bars.item.show
				floating_tool_bars.forth
			end
		end

feature {SD_DOCKING_MANAGER_AGENTS, SD_CONFIG_MEDIATOR, SD_TOOL_BAR_ZONE_ASSISTANT,
			SD_TOOL_BAR_ZONE} -- Internal querys

	tool_bar_container (a_direction: INTEGER): EV_BOX is
			-- Tool bar container base on `a_direction'.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				Result := internal_docking_manager.tool_bar_container.top
			when {SD_DOCKING_MANAGER}.dock_bottom then
				Result := internal_docking_manager.tool_bar_container.bottom
			when {SD_DOCKING_MANAGER}.dock_left then
				Result := internal_docking_manager.tool_bar_container.left
			when {SD_DOCKING_MANAGER}.dock_right then
				Result := internal_docking_manager.tool_bar_container.right
			end
		ensure
			not_void: Result /= Void
		end

	container_direction (a_tool_bar: SD_TOOL_BAR_ZONE): INTEGER is
			-- Tool bar container directions.
		require
			not_void: a_tool_bar /= Void
			not_floating: not a_tool_bar.is_floating
			has: contents.has (a_tool_bar.content)
		do
			if internal_docking_manager.tool_bar_container.top.has_recursive (a_tool_bar) then
				Result := {SD_DOCKING_MANAGER}.dock_top
			elseif internal_docking_manager.tool_bar_container.bottom.has_recursive (a_tool_bar) then
				Result := {SD_DOCKING_MANAGER}.dock_bottom
			elseif internal_docking_manager.tool_bar_container.left.has_recursive (a_tool_bar) then
				Result := {SD_DOCKING_MANAGER}.dock_left
			elseif internal_docking_manager.tool_bar_container.right.has_recursive (a_tool_bar) then
				Result := {SD_DOCKING_MANAGER}.dock_right
			end
		ensure
			vaild: Result = {SD_DOCKING_MANAGER}.dock_top or Result = {SD_DOCKING_MANAGER}.dock_bottom
				or Result = {SD_DOCKING_MANAGER}.dock_left or Result = {SD_DOCKING_MANAGER}.dock_right
		end

	floating_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			-- All floating tool bars.

feature {NONE} -- Agents

	on_add_tool_bar_content (a_content: SD_TOOL_BAR_CONTENT) is
			-- Handle add tool bar content.
		require
			a_tool_bar_item_not_void: a_content /= Void
		local
			l_tool_bar_zone: SD_TOOL_BAR_ZONE
			l_tool_bar_row: SD_TOOL_BAR_ROW
		do
			a_content.set_manager (Current)
			create l_tool_bar_zone.make (False, internal_docking_manager)
			l_tool_bar_zone.extend (a_content)
			a_content.set_zone (l_tool_bar_zone)
			create l_tool_bar_row.make (False)
			l_tool_bar_row.set_ignore_resize (True)
			l_tool_bar_row.extend (l_tool_bar_zone)
			l_tool_bar_row.record_state
			l_tool_bar_row.set_ignore_resize (False)
			internal_docking_manager.tool_bar_container.top.extend (l_tool_bar_row)
		ensure
			top_added_new_tool_bar: old internal_docking_manager.tool_bar_container.top.count + 1
				= internal_docking_manager.tool_bar_container.top.count
		end

	on_remove_tool_bar_content (a_content: SD_TOOL_BAR_CONTENT) is
			-- Handle remove tool bar content.
		require
			a_tool_bar_item_not_void: a_content /= Void
		do
			if a_content.manager = Current then
				a_content.set_manager (Void)
			end
		end

feature {NONE} -- Implementation

	notify_four_area (a_width, a_height: INTEGER; a_resize_horizontal: BOOLEAN) is
			-- Called by `on_resize'. Notify four tool bar area.
		local
			l_container: EV_CONTAINER
		do
			if a_resize_horizontal then
				l_container := tool_bar_container ({SD_DOCKING_MANAGER}.dock_top)
				notify_each_row (l_container, a_width)
				l_container := tool_bar_container ({SD_DOCKING_MANAGER}.dock_bottom)
				notify_each_row (l_container, a_width)
			else
				l_container := tool_bar_container ({SD_DOCKING_MANAGER}.dock_left)
				notify_each_row (l_container, a_height)
				l_container := tool_bar_container ({SD_DOCKING_MANAGER}.dock_right)
				notify_each_row (l_container, a_height)
			end
		end

	notify_each_row (a_tool_bar_container: EV_CONTAINER; a_size: INTEGER) is
			-- Notify each row in a_tool_bar_container reisze to a_size.
			-- a_size is width for top, bottom tool bar container.
			-- a_size is height for left, right tool bar container.
		require
			not_void: a_tool_bar_container /= Void
		local
			l_row: SD_TOOL_BAR_ROW
			l_rows: LINEAR [EV_WIDGET]
		do
			from
				l_rows := a_tool_bar_container.linear_representation
				l_rows.start
			until
				l_rows.after
			loop
				l_row ?= l_rows.item
				check not_void: l_row /= Void end
				l_row.on_resize (a_size)
				l_rows.forth
			end
		end

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager Current belong to.

	internal_shared: SD_SHARED
			-- All singletons.

	last_width, last_height: INTEGER
			-- Record last time tool bar container width/height, to improve efficiency.
invariant

	not_void: internal_shared /= Void
	not_void: contents /= Void
	not_void: floating_tool_bars /= Void

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
