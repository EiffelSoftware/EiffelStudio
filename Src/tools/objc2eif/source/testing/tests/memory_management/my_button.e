note
	description: "Summary description for {MY_BUTTON}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MY_BUTTON

inherit
	NS_BUTTON

create
	make_with_frame_

feature -- Setter

	set_saved_data (a_string: like saved_data)
			-- Set `saved_data' with `a_string'.
		do
			saved_data := a_string
		end

feature -- Access

	saved_data: detachable STRING assign set_saved_data
			-- Data to be saved in this object.

end
