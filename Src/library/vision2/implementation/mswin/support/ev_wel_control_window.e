indexing
	description: "EiffelVision wel_control_window is a certain kind of %
				  % wel_control_window designed for ev."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_CONTROL_WINDOW

inherit
	WEL_CONTROL_WINDOW
		redefine
			on_wm_erase_background
		end			

creation
	make_with_coordinates



feature {NONE} -- Implementation

	on_wm_erase_background (wparam: INTEGER) is
		do
			disable_default_processing
		end


end -- class EV_WEL_CONTROL_WINDOW
