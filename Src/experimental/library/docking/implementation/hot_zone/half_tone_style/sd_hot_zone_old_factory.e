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

feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE
			-- <Precursor>
		local
			l_result: detachable like hot_zone
		do
			if attached {SD_DOCKING_ZONE} a_zone as l_docking_zone then
				l_result := hot_zone_docking (l_docking_zone)
			elseif attached {SD_TAB_ZONE} a_zone as l_tab_zone then
				l_result := hot_zone_tab (l_tab_zone)
			end
			check l_result /= Void end -- Implied by precondition `valid'
			Result := l_result
		ensure then
			result_not_void: Result /= Void
		end

	hot_zone_main (a_zone: SD_ZONE; a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE
			-- <Precursor>
		local
			l_dock_mediator: like docker_mediator
		do
			l_dock_mediator := docker_mediator
			check l_dock_mediator /= Void end -- Implied by precondition `set'			
			if a_zone.type = {SD_ENUMERATION}.tool then
				Result := create {SD_HOT_ZONE_OLD_MAIN}.make (l_dock_mediator, a_docking_manager)
			else
				check must_be_editor: a_zone.type = {SD_ENUMERATION}.editor end
				Result := create {SD_HOT_ZONE_OLD_MAIN_EDITOR}.make (l_dock_mediator, a_docking_manager)
			end
		end

feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE): SD_HOT_ZONE_OLD_DOCKING
			-- Hot zone for SD_DOCKING_ZONE
		require
			set: docker_mediator /= Void
		local
			l_dock_mediator: like docker_mediator
		do
			l_dock_mediator := docker_mediator
			check l_dock_mediator /= Void end -- Implied by precondition `set'
			create Result.make (a_zone, l_dock_mediator)
		end

	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_OLD_TAB
			-- Hot zone for SD_TAB_ZONE
		require
			set: docker_mediator /= Void
		local
			l_dock_mediator: like docker_mediator
		do
			l_dock_mediator := docker_mediator
			check l_dock_mediator /= Void end -- Implied by precondition `set'
			create Result.make (a_zone, l_dock_mediator)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
