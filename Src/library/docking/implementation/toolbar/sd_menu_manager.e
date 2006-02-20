indexing
	description: "Manager that manage all menus. This manager directly under SD_DOCKING_MANAGER control."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_MANAGER

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
			create menu_contents
			menu_contents.add_actions.extend (agent on_add_menu_content)
			menu_contents.remove_actions.extend (agent on_remove_menu_content)
			create floating_menus.make (1)

		ensure
			action_added: menu_contents.add_actions.count = 1 and menu_contents.remove_actions.count = 1
			set: internal_docking_manager = a_docking_manager
		end

feature -- Access

	floating_menus: ARRAYED_LIST [SD_FLOATING_MENU_ZONE]
			-- All floating menus.

	menu_contents: ACTIVE_LIST [SD_MENU_CONTENT]
			-- All menu contents.

	menus: ARRAYED_LIST [SD_MENU_ZONE]
			-- All SD_MENU_ZONEs in system

	menu_container (a_direction: INTEGER): EV_CONTAINER is
			-- Menu container base on `a_direction'.
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				Result := internal_docking_manager.menu_container.top
			when {SD_DOCKING_MANAGER}.dock_bottom then
				Result := internal_docking_manager.menu_container.bottom
			when {SD_DOCKING_MANAGER}.dock_left then
				Result := internal_docking_manager.menu_container.left
			when {SD_DOCKING_MANAGER}.dock_right then
				Result := internal_docking_manager.menu_container.right
			end
		ensure
			not_void: Result /= Void
		end

	content_by_title (a_title: STRING): SD_MENU_CONTENT is
			-- SD_MENU_CONTENT which has `a_title'.
		require
			a_title_not_void: a_title /= Void
		do
			from
				menu_contents.start
			until
				menu_contents.after or Result /= Void
			loop
				if menu_contents.item.title.is_equal (a_title) then
					Result := menu_contents.item
				end
				menu_contents.forth
			end
		end

feature -- Command

	add_menu (a_menu: SD_MENU_CONTENT) is
			-- Add `a_menu' to menus.
		do

		end

feature {NONE} -- Agents

	on_add_menu_content (a_menu_item: SD_MENU_CONTENT) is
			-- Handle add menu content.
		require
			a_menu_item_not_void: a_menu_item /= Void
		local
			l_menu_zone: SD_MENU_ZONE
			l_menu_row: SD_MENU_ROW
		do
			create l_menu_zone.make (False, internal_docking_manager)
			l_menu_zone.extend (a_menu_item)
			create l_menu_row.make (False)
			l_menu_row.extend (l_menu_zone)
			internal_docking_manager.menu_container.top.extend (l_menu_row)
		ensure
			top_added_new_menu: old internal_docking_manager.menu_container.top.count + 1
				= internal_docking_manager.menu_container.top.count
		end

	on_remove_menu_content (a_menu_item: SD_MENU_CONTENT) is
			-- Handle remove menu content.
		require
			a_menu_item_not_void: a_menu_item /= Void
		do

		end

feature {NONE} -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager Current belong to.

	internal_shared: SD_SHARED
			-- All singletons.

invariant

	internal_shared_not_void: internal_shared /= Void
	menu_contents_not_void: menu_contents /= Void
	floating_menus_not_void: floating_menus /= Void

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
