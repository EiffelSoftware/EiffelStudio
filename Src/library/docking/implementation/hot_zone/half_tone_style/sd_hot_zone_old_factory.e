indexing
	description: "Factory produce all the Visual Studio 2003 style feedbacks"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_OLD_FACTORY

inherit
	SD_HOT_ZONE_ABSTRACT_FACTORY

feature -- Factory method

	hot_zone (a_zone: SD_ZONE): SD_HOT_ZONE is
			-- Facotry method
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

		ensure then
			result_not_void: Result /= Void
		end

	hot_zone_main (a_docking_manager: SD_DOCKING_MANAGER): SD_HOT_ZONE is
			--
		do
			Result := create {SD_HOT_ZONE_OLD_MAIN}.make (a_docking_manager)
		end


feature {NONE}-- Implementation

	hot_zone_docking (a_zone: SD_DOCKING_ZONE): SD_HOT_ZONE_OLD_DOCKING is
			--
		do
			create Result.make (a_zone)
		end

	hot_zone_tab (a_zone: SD_TAB_ZONE): SD_HOT_ZONE_OLD_TAB is
			--
		do
			create Result
		end

end
