indexing

	description: "EiffelVision information dialog. Gtk implemenation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_INFORMATION_DIALOG_IMP

inherit
	EV_INFORMATION_DIALOG_I

	EV_MESSAGE_DIALOG_IMP	

creation
	make,
	make_default,
	make_with_text

feature {NONE} -- Implementation		

	icon_build (par: EV_CONTAINER) is
			-- Load the icon
		local
			icon: EV_PIXMAP
		do
			--!!icon.make (par)
		end

end -- class EV_MESSAGE_DIALOG_I

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
