indexing
	description: "Windows implementation of SD_DEPENDENCY_CHECKER."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DEPENDENCY_CHECKER_IMP

inherit
	SD_DEPENDENCY_CHECKER

feature -- Command

	check_dependency (a_parent_window: EV_WINDOW) is
			-- Check if GDI+ exists.
		local
			l_starter: WEL_GDIP_STARTER
			l_warning: EV_WARNING_DIALOG
		do
			create l_starter
			if not l_starter.is_gdi_plus_installed then
				create l_warning.make_with_text ("GDI+ dll not found! Some functionalities will not work properly. Please install GDI+.")
				l_warning.show_modal_to_window (a_parent_window)
			end
		end

	is_solaris_cde: BOOLEAN is
			-- Redefine
		do
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
