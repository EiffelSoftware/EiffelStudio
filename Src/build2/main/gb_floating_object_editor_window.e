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
		
feature {NONE} -- Initialization

	initialize is
		do
			Precursor {EV_DIALOG}
			set_icon_pixmap (icon)
		end

feature -- Access

	icon: EV_PIXMAP is
			-- Icon displayed in title of `Current'.
		once
			Result := (create {GB_SHARED_PIXMAPS}).Icon_object_window @ 1
		end


end -- class GB_FLOATING_OBJECT_EDITOR_WINDOW
