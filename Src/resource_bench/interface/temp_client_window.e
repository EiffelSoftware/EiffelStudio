indexing
	description: "Client Window of the Resource Bench's main window"
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

class
	TEMP_CLIENT_WINDOW

inherit
	WEL_CONTROL_WINDOW
		redefine
			default_ex_style
		end

creation
	make

feature {NONE} -- Implementation

	default_ex_style: INTEGER is 768
			-- Default_style.

end -- class CLIENT_WINDOW
