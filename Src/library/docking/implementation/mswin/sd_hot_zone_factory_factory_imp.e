indexing
	description: "Implementation of SD_HOT_ZONE_FACTORY_FACTORY."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_HOT_ZONE_FACTORY_FACTORY_IMP

inherit
	SD_HOT_ZONE_FACTORY_FACTORY

feature -- Hot zone factory

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY is
			-- Redefine
		local
			l_version: WEL_WINDOWS_VERSION
		do
			create l_version
			if l_version.is_windows_2000_compatible and then not is_terminal_service then
				create {SD_HOT_ZONE_TRIANGLE_FACTORY} Result
			else
				create {SD_HOT_ZONE_OLD_FACTORY} Result
			end
		end


feature -- Implementation

	is_terminal_service: BOOLEAN is
			-- If window in terminal service (Remote Desktop)?
		require
			after_2000: (create {WEL_WINDOWS_VERSION}).is_windows_2000_compatible
		do
			c_is_terminal_service ($Result)
		end

	c_is_terminal_service (a_result: TYPED_POINTER [BOOLEAN]) is
			-- If window in terminal service (Remote Desktop)?
		external
			"C inline use <Windows.h>"
		alias
			"[
			{
				*(EIF_BOOLEAN *) $a_result = GetSystemMetrics(SM_REMOTESESSION);
			}
			]"
		end

end
