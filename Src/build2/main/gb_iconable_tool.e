indexing
	description: "Objects that represent tools which have icons."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	GB_ICONABLE_TOOL
	
		-- This class is used to enable all tools to have a common icon
		--  which can be set when they are displayed relative to a window.
		-- This is necessary as on Windows, each relative dialog shares
		-- as icon and there seemed to be no better solution.

feature -- Access

	icon: EV_PIXMAP is
			-- Standard icon displayed in `Current'.
		deferred
		end
		
feature -- Basic operations

	restore_icon is
			-- Ensure `icon' is displayed as icon of `Current'.
		do
			set_icon_pixmap (icon)
		end
		
	set_default_icon is
			-- Assign a common default icon to `Current'.
		do
			set_icon_pixmap ((create {GB_SHARED_PIXMAPS}).Icon_build_window @ 1)
		end

feature {NONE} -- Implementation

	set_icon_pixmap (a_pixmap: EV_PIXMAP) is
			-- Ensure that `a_pixmap' is displayed as icon of `Current'.
		deferred
		end

end -- class GB_ICONABLE_TOOL
