indexing
	description: "Windows implementation of SD_HOT_ZONE_FACTORY_FACTORY."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
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
