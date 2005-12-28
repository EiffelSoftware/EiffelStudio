indexing
	description: "[
		Factory that produce all new style feedback hot zones, which have indicators and
		transparent feedback.
																						]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TRIANGLE_FACTORY

inherit
	SD_HOT_ZONE_ABSTRACT_FACTORY

feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE is
			-- Redefine.
		local
			l_docking_zone: SD_DOCKING_ZONE
			l_tab_zone: SD_TAB_ZONE
		do
			l_docking_zone ?= a_zone
			if l_docking_zone /= Void then
				Result := hot_zone_docking (l_docking_zone)
			end

			l_tab_zone ?= a_zone
			if l_tab_zone /= Void then
				Result := hot_zone_tab (l_tab_zone)
			end

			Result.set_type (a_zone.content.type)
		end

	hot_zone_main (a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE is
			-- Redefine.
		do
			Result := create {SD_HOT_ZONE_MAIN}.make (docker_mediator, a_docking_manager)
		end

feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE): SD_HOT_ZONE_DOCKING is
			-- Hot zone for SD_DOCKING_ZONE.
		require
			a_zone_not_void: a_zone /= Void
		do
			create Result.make (docker_mediator, a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height))
		ensure
			not_void: Result /= Void
		end

	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_TAB is
			-- Hot zone for SD_TAB_ZONE.
		require
			a_zone_not_void: a_zone /= Void
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height), docker_mediator)
		ensure
			not_void: Result /= Void
		end

--	hot_zone_floating (a_zone: SD_FLOATING_ZONE): SD_HOT_ZONE_FLOATING is
--			-- Get a SD_HOT_ZONE_FLOATING.
--		do
--			create Result.make (a_zone)
--		end

end
