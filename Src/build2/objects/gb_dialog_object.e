indexing
	description: "A GB_OBJECT representing an EV_DIALOG"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_DIALOG_OBJECT
	
inherit
	GB_TITLED_WINDOW_OBJECT
		redefine
			object
		end
		
create
	make_with_type,
	make_with_type_and_object
		
feature -- Access
		
	object: EV_DIALOG
		-- The vision2 object that `Current' represents.
		-- This is used in the display window.

end -- class GB_DIALOG_OBJECT
