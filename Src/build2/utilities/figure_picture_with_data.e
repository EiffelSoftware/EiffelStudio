indexing
	description: "Objects that represent a figure picture that has data"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIGURE_PICTURE_WITH_DATA
	
inherit
	EV_FIGURE_PICTURE
	
create
	default_create,
	make_with_point,
	make_with_pixmap

feature -- Access

	data: ANY
	
feature -- Status Setting

	set_data (a_data: ANY) is
			-- Assign `a_data' to `data'.
		do
			data := a_data
		ensure
			data_set: data = a_data
		end

end -- Class