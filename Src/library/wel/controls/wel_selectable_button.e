indexing
	description: "Control that looks and acts like a button. But %
		% the button looks raised when it isn’t pushed or checked,%
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

creation
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
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

