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
		rename
			make as wel_make
		redefine
			default_style
		end			

	WEL_RGN_CONSTANTS


creation
	make


feature -- Initialization

	make (a_parent: WEL_WINDOW; name: STRING) is
			-- Create the window
		do
			make_with_coordinates (a_parent, "", 0, 0, 0, 0)
		end


feature {NONE} -- Implementation
	
	default_style: INTEGER is
		once
			Result := Ws_child + Ws_visible + Ws_clipchildren
		end

end -- class EV_WEL_CONTROL_WINDOW
