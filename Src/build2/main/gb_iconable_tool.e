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
		
		-- UPDATE!! The bug on Windows has been fixed so this class is no longer
		-- required. The implementation of `restore_icon' and `set_default_icon' have
		-- been removed so they do nothing. Unless more problems arise, this class
		-- can be removed in the future.

feature -- Access

	icon: EV_PIXMAP is
			-- Standard icon displayed in `Current'.
		deferred
		end
		
feature -- Basic operations

	restore_icon is
			-- Ensure `icon' is displayed as icon of `Current'.
		do
		end
		
	set_default_icon is
			-- Assign a common default icon to `Current'.
		do
		end

feature {NONE} -- Implementation

	set_icon_pixmap (a_pixmap: EV_PIXMAP) is
			-- Ensure that `a_pixmap' is displayed as icon of `Current'.
		deferred
		end

end -- class GB_ICONABLE_TOOL
