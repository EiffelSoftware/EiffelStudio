indexing 
	description: "EiffelVision horizontal Progress bar, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I

	EV_PROGRESS_BAR_IMP
		undefine
			set_default_options
		redefine
			set_default_minimum_size
		end

creation
	make,
	make_with_range

feature -- Status settings

	set_default_minimum_size is
			-- Initialize the size of the widget.
			-- Redefine by some widgets.
		do
			internal_set_minimum_width (20)
			internal_set_minimum_height (0)
		end

feature {NONE} -- WEL Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		do
			Result := Ws_visible + Ws_child + Ws_group
				+ Ws_tabstop + Pbs_vertical
	end

end -- class EV_VERTICAL_PROGRESS_BAR_IMP

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
