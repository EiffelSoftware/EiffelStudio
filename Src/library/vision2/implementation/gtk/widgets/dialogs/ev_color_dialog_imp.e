indexing 
	description: "EiffelVision color selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_SELECTION_DIALOG_IMP

inherit
	EV_COLOR_SELECTION_DIALOG_I
	EV_STANDARD_DIALOG_IMP

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
		end

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		do
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		do
		end

end -- class EV_COLOR_SELECTION_DIALOG_IMP

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
