indexing
	description: "Objects that is the factory produce all the Visual Studio 2005 style feedbacks"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TRIANGLE_FACTORY

inherit
	SD_HOT_ZONE_ABSTRACT_FACTORY
	
feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE is
			-- Facotry method
		local
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
			l_floating_zone: SD_FLOATING_ZONE
		do
			l_docking_zone ?= a_zone
			if l_docking_zone /= Void then
				Result := hot_zone_docking (l_docking_zone)
			end
			
			l_tab_zone ?= a_zone
			if l_tab_zone /= Void then
				Result := hot_zone_tab (l_tab_zone)
			end
			
			l_floating_zone ?= a_zone
			if l_floating_zone /= Void then
				Result := hot_zone_floating (l_floating_zone)
			end
			
			Result.set_type (a_zone.content.type)
		ensure then
			result_not_void: Result /= Void
		end
		
	hot_zone_main: SD_HOT_ZONE is
			-- 
		do
			Result := create {SD_HOT_ZONE_MAIN}.make 
		end
		
		
feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE): SD_HOT_ZONE_DOCKING is
			-- 
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		end
		
	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_TAB is
			-- 
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		end
		
	hot_zone_floating (a_zone: SD_FLOATING_ZONE): SD_HOT_ZONE_FLOATING is
			-- Get a SD_HOT_ZONE_FLOATING.
		do
			create Result.make (a_zone)
		end
		
end
