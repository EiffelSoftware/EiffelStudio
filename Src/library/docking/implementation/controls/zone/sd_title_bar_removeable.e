indexing
	description: "SD_ZONE which title bar is removeable (such as: SD_DOCKING_ZONE, SD_TAB_ZONE) inherited this object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_TITLE_BAR_REMOVEABLE

feature -- Basic operation

	set_show_normal_max (a_show: BOOLEAN) is
			-- Show normal\max button if `a_show' True.
		deferred
		end

	set_show_stick (a_show: BOOLEAN) is
			-- Show stick button if `a_show' True.
		deferred
		end

indexing
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
