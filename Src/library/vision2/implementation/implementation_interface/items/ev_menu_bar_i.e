indexing
	description: "Eiffel Vision menu bar. Implementation interface."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_BAR_I
	
inherit
	EV_MENU_ITEM_LIST_I
		redefine
			interface
		end
		
feature -- Status report

	parent: EV_WINDOW is
			-- Parent of `Current'.
		deferred
		end
		

feature {EV_ANY} -- Implementation

	interface: EV_MENU_BAR	

end -- class EV_MENU_BAR_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

