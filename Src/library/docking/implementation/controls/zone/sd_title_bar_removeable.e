indexing
	description: "SD_ZONE which title bar is removeable (such as: SD_DOCKING_ZONE, SD_TAB_ZONE) inherited this object."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TITLE_BAR_REMOVEABLE

feature -- Basic operation

	set_show_min_max (a_show: BOOLEAN) is
			-- Show min\max button if `a_show' True.
		deferred
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Show stick button if `a_show' True.
		deferred
		end

end
