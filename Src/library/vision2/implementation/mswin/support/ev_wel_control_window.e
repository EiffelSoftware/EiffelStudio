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

	make (a_parent: WEL_WINDOW) is
			-- Create the window
		require
			a_parent_not_void: a_parent /= Void
		do
			make_with_coordinates (a_parent, "", 0, 0, 0, 0)
		end

feature {NONE} -- Implementation
	
	default_style: INTEGER is
		once
			Result := Ws_child + Ws_visible + Ws_clipchildren
		end

end -- class EV_WEL_CONTROL_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
