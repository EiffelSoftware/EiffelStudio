indexing 
	description: "Eiffel Vision vertical progress bar. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_VERTICAL_PROGRESS_BAR_IMP

inherit
	EV_VERTICAL_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_PROGRESS_BAR_IMP
		redefine
			initialize,
			interface
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			C.gtk_progress_bar_set_orientation (gtk_progress_bar, C.Gtk_progress_bottom_to_top_enum)
		end
			
feature {EV_ANY_I} -- Implementation

	interface: EV_VERTICAL_PROGRESS_BAR

end -- class EV_VERTICAL_PROGRESS_BAR_IMP

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

