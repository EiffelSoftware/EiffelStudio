indexing
	description: "Objects that represent a visible representation of an%
		%EV_SPLIT_AREA."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SPLIT_AREA_DISPLAY_OBJECT

inherit
	GB_DISPLAY_OBJECT
		redefine
			child
		end

create
	make_with_name_and_child

feature -- Access

	child: EV_SPLIT_AREA
		-- The actual split area that we are representing.

end -- class GB_SPLIT_AREA_DISPLAY_OBJECT