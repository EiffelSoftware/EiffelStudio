indexing
	description: 
		"Eiffel Vision deselectable. Implementation interface."
	status: "See notice at end of class"
	keywords: "deselect, deselectable, selectable, select"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_DESELECTABLE_I

inherit
	EV_SELECTABLE_I
		redefine
			interface
		end
	
feature -- Status setting

	disable_select is
			-- Deselect the object.
		require
			is_selectable: is_selectable
		deferred
		ensure
			deselected: not is_selected
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DESELECTABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_DESELECTABLE_I

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

