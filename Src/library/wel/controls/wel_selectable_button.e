indexing
	description: "Control that looks and acts like a button. But %
		% the button looks raised when it isn't pushed or checked,%
		% and sunken when it is pushed or checked."
	note: "To create this kind of button  a ressource editor,   %
		% create a checkbox and then choose the pushlike option %
		% for this checkbox"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SELECTABLE_BUTTON

inherit
	WEL_CHECK_BOX
		redefine
			default_style
		end

create
	make,
	make_by_id

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + 
				Ws_group + Ws_tabstop + Bs_autocheckbox + Bs_pushlike
 		end

end -- class WEL_SELECTABLE_BUTTON

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

