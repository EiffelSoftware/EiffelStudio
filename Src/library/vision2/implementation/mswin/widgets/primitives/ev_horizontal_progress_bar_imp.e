indexing 
	description:
		"Eiffel Vision horizontal progress bar. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HORIZONTAL_PROGRESS_BAR_IMP

inherit
	EV_HORIZONTAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			set_default_minimum_size,
			interface
		end

create
	make

feature -- Status settings

	set_default_minimum_size is
			-- Initialize the size of `Current'.
		do
			ev_set_minimum_size (10, 20)
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create `Current'.
		do
			Result := Ws_visible + Ws_child + Ws_clipchildren + Ws_clipsiblings
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_PROGRESS_BAR

end -- class EV_HORIZONTAL_PROGRESS_BAR_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

