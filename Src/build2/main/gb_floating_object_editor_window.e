indexing
	description: "Objects that represent a floating object editor window"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_FLOATING_OBJECT_EDITOR_WINDOW
	
inherit
	
	EV_DIALOG
		redefine
			initialize
		end
	
	GB_ICONABLE_TOOL
		undefine
			default_create, copy
		end
	
	GB_SHARED_SYSTEM_STATUS
		undefine
			default_create, copy
		end
	
feature {NONE} -- Initialize

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_DIALOG}
				-- We must allocate the pixmap correctly during
				-- creation, and before it is displayed.
				-- Must be done due to the Windows icon pixmap bug.
				-- If we only set it as it is displayed, all other
				-- floating windows, will have their icons flash to the
				-- default icon for a split second which is ugly.
			if system_status.tools_always_on_top then
				set_default_icon
			else
				restore_icon
			end
		end
		

feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_object_window @ 1
		end


end -- class GB_FLOATING_OBJECT_EDITOR_WINDOW
