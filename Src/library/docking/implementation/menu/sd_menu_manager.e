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
			create internal_all_menu_zone_items.make (0)
		end
		
feature -- Basic operations

	add_tool_bar (a_tool_bar: EV_TOOL_BAR) is
			-- 
		require
			a_tool_bar_not_void: a_tool_bar /= Void
			a_tool_bar_has_item: a_tool_bar.count >= 1
		local
			l_menu: SD_MENU_ZONE
			l_row: SD_MENU_ROW
		do
			extend (a_tool_bar)
			create l_menu.make (False)
			menu_items_finish
			l_menu.extend_items (menu_items_one_zone)
			create l_row.make (False)
			l_row.extend (l_menu)
			internal_shared.docking_manager.menu_container.top.extend (l_row)
		end
	
--	add_tool_bar_with_position (a_tool_bar: EV_TOOL_BAR; a_direcition: INTEGER) is
--			-- 
--		require
--			a_tool_bar_not_void: a_tool_bar /= Void
--		local
--			l_menu: SD_MENU_ZONE
--			l_row: SD_MENU_ROW
--		do
--			extend (a_tool_bar)
--			
--			inspect 
--				a_direcition
--			when {SD_SHARED}.dock_top then
--				create l_menu.make (False)
----				l_menu.extend_tool_bar (a_tool_bar)
--				create l_row.make (False)
--				l_row.extend (l_menu)
----				internal_shared. .top.extend (l_row)	
--			when {SD_SHARED}.dock_left then
--				create l_menu.make (True)
----				l_menu.extend_tool_bar (a_tool_bar)
--				create l_row.make (True)
--				l_row.extend (l_menu)
----				internal_menu_container.left.extend (l_row)							
--			else
--				
--			end

--			internal_menu_zones.extend (l_menu)
--		end
		
	extend (a_tool_bar: EV_TOOL_BAR) is
			-- 
		require
			a_tool_bar_not_void: a_tool_bar /= Void
		local
			l_item: EV_TOOL_BAR_ITEM
			l_one_menu_zone_items: like internal_one_menu_zone_items
		do
			from 
				a_tool_bar.start
				create l_one_menu_zone_items.make (0)
			until
				a_tool_bar.after
			loop
				l_item := a_tool_bar.item
				if a_tool_bar.parent /= Void then
					a_tool_bar.item.parent.prune (a_tool_bar.item)
				end
				l_one_menu_zone_items.extend (l_item)
				a_tool_bar.forth
			end
			internal_all_menu_zone_items.extend (l_one_menu_zone_items)
		end
	
	menu_items_one_zone: like internal_one_menu_zone_items is
			-- 
		do
			Result := internal_all_menu_zone_items.item
		end
	
	menu_items_finish is
			-- Go to last menu item.
		do
			internal_all_menu_zone_items.finish
		end
		
feature {SD_MENU_DOCKER_MEDIATOR}
	menus: like internal_menu_zones is
			--  
		do
			Result := internal_menu_zones
		end
		
feature {NONE} -- Implementation

	internal_one_menu_zone_items: ARRAYED_LIST [EV_TOOL_BAR_ITEM] is
			-- Anchor type.
		require
			False
		do
		end
		
	internal_all_menu_zone_items: ARRAYED_LIST [like internal_one_menu_zone_items]
			-- All menu zone items.

	internal_menu_zones: ARRAYED_LIST [SD_MENU_ZONE]
			-- All SD_MENU_ZONEs in system
	
	internal_shared: SD_SHARED
			-- All singletons.
end
