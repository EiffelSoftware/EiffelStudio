indexing 
	description: "EiffelVision color selection dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_SELECTION_DIALOG_IMP

inherit
	EV_COLOR_SELECTION_DIALOG_I

	EV_STANDARD_DIALOG_IMP

	WEL_CHOOSE_COLOR_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		redefine
			wel_make
		end

creation
	make

feature {NONE} -- Implementation

	wel_make is
			-- WEL creation of the dialog
		do
			{WEL_CHOOSE_COLOR_DIALOG} Precursor
			add_flag (Cc_fullopen)
			add_flag (Cc_anycolor)
		end

feature -- Access

	color: EV_COLOR is
			-- Current selected color
		local
			color_imp: EV_COLOR_IMP
		do
			!! color_imp.make_by_color (cwel_choose_color_get_rgbresult (item))
			!! Result.make
			Result.set_implementation (color_imp)
		end

feature -- Element change

	select_color (a_color: EV_COLOR) is
			-- Select `a_color'.
		local
			color_imp: EV_COLOR_IMP
		do
			color_imp ?= a_color.implementation	
			check
				valid_color: color_imp /= Void
			end
			set_rgb_result (color_imp)
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
