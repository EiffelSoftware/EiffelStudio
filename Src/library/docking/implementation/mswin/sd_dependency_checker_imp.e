indexing
	description: "Windows implementation of SD_DEPENDENCY_CHECKER."
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
			l_starter: WEL_GDI_PLUS_STARTER
			l_warning: EV_WARNING_DIALOG
		do
			create l_starter
			if not l_starter.is_gdi_plus_installed then
				create l_warning.make_with_text ("GDI+ dll not found! Some functionalities will not work properly. Please install GDI+.")
				l_warning.show_modal_to_window (a_parent_window)
			end
		end

end
