indexing
	description: "Objects that allow insertion of a Vision2 control%
		%within a WEL system."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WEL_EV_CONTAINER_I
	
inherit
	EV_CELL_I
		redefine
			interface
		end

feature {WEL_EV_CONTAINER} -- Initialization

	set_real_parent (a_parent: WEL_WINDOW; x_pos, y_pos, a_width, a_height: INTEGER) is
			-- Actually target `Current' to `a_parent' and set x_position to `x_pos',
			-- y_position to `y_pos', width to `a_width' and height to `a_height'.
		deferred
		end
		

feature -- Access

	implementation_window: WEL_WINDOW is
			-- Window containing `item'.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: WEL_EV_CONTAINER

end -- class WEL_EV_CONTAINER_I

--|----------------------------------------------------------------
--| EiffelVision2 Extension: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

