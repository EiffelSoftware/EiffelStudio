indexing
	description: "Objects that represent a visible representation of an%
		%invisible container in the display window."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_WIDGET_LIST_DISPLAY_OBJECT

inherit
	GB_DISPLAY_OBJECT
		redefine
			child
		end

create
	make_with_name_and_child

feature -- Access

	child: EV_WIDGET_LIST

end -- class GB_DISPLAY_CONTAINER
