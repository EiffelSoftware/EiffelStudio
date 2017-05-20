note
	description: "[
		Factory that produce all new style feedback hot zones, which have indicators and
		transparent feedback.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_TRIANGLE_FACTORY

inherit
	SD_HOT_ZONE_ABSTRACT_FACTORY

create
	make

feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE
			-- <Precursor>
		do
			if attached {SD_DOCKING_ZONE_NORMAL} a_zone as l_docking_zone then
				Result := hot_zone_docking (l_docking_zone)
			elseif attached {SD_DOCKING_ZONE_UPPER} a_zone as l_docking_zone_upper then
				Result := hot_zone_docking_upper (l_docking_zone_upper)
			elseif attached {SD_TAB_ZONE_UPPER} a_zone as l_tab_zone_upper then
				Result := hot_zone_tab_upper (l_tab_zone_upper)
			elseif attached {SD_TAB_ZONE} a_zone as l_tab_zone then
				Result := hot_zone_tab (l_tab_zone)
			else
				check
					hot_zone: False
				then
				end
			end
		end

	hot_zone_main (a_zone: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE
			-- <Precursor>
		do
			if a_zone.type = {SD_ENUMERATION}.editor then
				Result := create {SD_HOT_ZONE_MAIN_EDITOR}.make (docker_mediator)
			else
				check type_valid: a_zone.type = {SD_ENUMERATION}.tool end
				Result := create {SD_HOT_ZONE_MAIN}.make (docker_mediator, a_docking_manager)
			end
		end

feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE_NORMAL): SD_HOT_ZONE_DOCKING
			-- Hot zone for SD_DOCKING_ZONE
		require
			a_zone_not_void: a_zone /= Void
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height), docker_mediator)
		ensure
			not_void: Result /= Void
		end

	hot_zone_docking_upper (a_zone: SD_DOCKING_ZONE_UPPER): SD_HOT_ZONE_DOCKING_UPPER
			-- Hot zone for SD_DOCKING_ZONE
		require
			a_zone_not_void: a_zone /= Void
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height), docker_mediator)
		ensure
			not_void: Result /= Void
		end

	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_TAB
			-- Hot zone for SD_TAB_ZONE
		require
			a_zone_not_void: a_zone /= Void
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height), docker_mediator)
		ensure
			not_void: Result /= Void
		end

	hot_zone_tab_upper (a_zone: SD_TAB_ZONE_UPPER): SD_HOT_ZONE_TAB_UPPER
			-- Hot zone for SD_TAB_ZONE_UPPER
		require
			not_void: a_zone /= Void
		do
			create Result.make (a_zone, create {EV_RECTANGLE}.make (a_zone.screen_x, a_zone.screen_y, a_zone.width, a_zone.height), docker_mediator)
		ensure
			not_void: Result /= Void
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
