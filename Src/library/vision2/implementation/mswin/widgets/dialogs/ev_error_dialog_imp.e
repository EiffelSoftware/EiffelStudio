indexing
	description: "EiffelVision error dialog. Mswindows implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_ERROR_DIALOG_IMP

inherit
	EV_ERROR_DIALOG_I

	EV_MESSAGE_DIALOG_IMP
		undefine
			set_default
		end

creation
	make

feature {NONE} -- Implementation

--	icon_build (par: EV_CONTAINER) is
--			-- Load the icon
--		local
--			icon: WEL_ICON
--			wel_window: WEL_WINDOW
--			dc: WEL_CLIENT_DC
--		do
--			!! icon.make_by_predefined_id (Idi_hand)
--		end


end -- class EV_ERROR_DIALOG_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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
