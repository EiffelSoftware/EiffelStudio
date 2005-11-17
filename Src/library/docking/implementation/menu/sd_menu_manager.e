indexing
	description: "Objects that manage all menus."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_MENU_MANAGER

create
	make

feature {NONE} -- Initialization

	make is
			--
		require

		do
			create internal_shared
			create menu_contents
			menu_contents.add_actions.extend (agent on_add_menu_content)
			menu_contents.remove_actions.extend (agent on_remove_menu_content)
			create floating_menus.make (1)
		end

feature -- Access

	floating_menus: ARRAYED_LIST [SD_FLOATING_MENU_ZONE]

	menu_contents: ACTIVE_LIST [SD_MENU_CONTENT]
			-- All menu contents.

	menu_container (a_direction: INTEGER): EV_CONTAINER is
			--
		require
			a_direction_valid: a_direction = {SD_DOCKING_MANAGER}.dock_top or a_direction = {SD_DOCKING_MANAGER}.dock_bottom
				or a_direction = {SD_DOCKING_MANAGER}.dock_left or a_direction = {SD_DOCKING_MANAGER}.dock_right
		do
			inspect
				a_direction
			when {SD_DOCKING_MANAGER}.dock_top then
				Result := internal_shared.docking_manager.menu_container.top
			when {SD_DOCKING_MANAGER}.dock_bottom then
				Result := internal_shared.docking_manager.menu_container.bottom
			when {SD_DOCKING_MANAGER}.dock_left then
				Result := internal_shared.docking_manager.menu_container.left
			when {SD_DOCKING_MANAGER}.dock_right then
				Result := internal_shared.docking_manager.menu_container.right
			end
		ensure
			not_void: Result /= Void
		end

feature -- Basic operations

	content_by_title (a_title: STRING): SD_MENU_CONTENT is
			--
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

--feature {SD_MENU_ROW} -- Implementation

--	content_by_menu_items (a_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM]): SD_MENU_CONTENT is
--			--
--		do
--			from
--				menu_contents.start
--			until
--				menu_contents.after or Result /= Void
--			loop
--				-- Only compare address
--				if menu_contents.item.menu_items = a_items then
--					Result := menu_contents.item
--				end
--				menu_contents.forth
--			end
--		end

feature {NONE} -- Implementation

	on_add_menu_content (a_menu_item: SD_MENU_CONTENT) is
			--
		require
			a_menu_item_not_void: a_menu_item /= Void
		local
			l_menu_zone: SD_MENU_ZONE
			l_menu_row: SD_MENU_ROW
		do
			create l_menu_zone.make (False)
			l_menu_zone.extend (a_menu_item)
			create l_menu_row.make (False)
			l_menu_row.extend (l_menu_zone)
			internal_shared.docking_manager.menu_container.top.extend (l_menu_row)
		end

	on_remove_menu_content (a_menu_item: SD_MENU_CONTENT) is
			--
		do

		end

feature -- States report


feature {SD_MENU_DOCKER_MEDIATOR}

	menus: ARRAYED_LIST [SD_MENU_ZONE]
			-- All SD_MENU_ZONEs in system

feature {NONE} -- Implementation

	internal_shared: SD_SHARED
			-- All singletons.
end
