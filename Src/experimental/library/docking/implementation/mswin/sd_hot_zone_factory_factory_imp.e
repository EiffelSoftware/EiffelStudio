note
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

	hot_zone_factory: SD_HOT_ZONE_ABSTRACT_FACTORY
			-- <Precursor>
		local
			l_version: WEL_WINDOWS_VERSION
			l_shared: SD_SHARED
			l_line_drawer: SD_LINE_DRAWER
			l_system: SD_SYSTEM_SETTER
		do
			create l_version
			create {SD_SYSTEM_SETTER_IMP} l_system
			if l_version.is_windows_2000_compatible and then not l_system.is_remote_desktop then
				create {SD_HOT_ZONE_TRIANGLE_FACTORY} Result
			else
				create {SD_HOT_ZONE_OLD_FACTORY} Result
				create l_shared
				l_line_drawer := l_shared.feedback.line_drawer
				l_line_drawer.reset_screen
			end
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
