note
	description: "Factory produce all the Visual Studio 2003 style feedbacks"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_FACTORY

inherit
	SD_HOT_ZONE_ABSTRACT_FACTORY

create
	make

feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE
			-- <Precursor>
		do
			if attached {SD_DOCKING_ZONE} a_zone as l_docking_zone then
				Result := hot_zone_docking (l_docking_zone)
			elseif attached {SD_TAB_ZONE} a_zone as l_tab_zone then
				Result := hot_zone_tab (l_tab_zone)
			else
				check
					from_precondition_valid: False
				then
				end
			end
		end

	hot_zone_main (a_zone: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE
			-- <Precursor>
		do
			if a_zone.type = {SD_ENUMERATION}.tool then
				Result := create {SD_HOT_ZONE_OLD_MAIN}.make (docker_mediator, a_docking_manager)
			else
				check must_be_editor: a_zone.type = {SD_ENUMERATION}.editor end
				Result := create {SD_HOT_ZONE_OLD_MAIN_EDITOR}.make (docker_mediator, a_docking_manager)
			end
		end

feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE): SD_HOT_ZONE_OLD_DOCKING
			-- Hot zone for SD_DOCKING_ZONE
		do
			create Result.make (a_zone, docker_mediator)
		end

	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_OLD_TAB
			-- Hot zone for SD_TAB_ZONE
		do
			create Result.make (a_zone, docker_mediator)
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
