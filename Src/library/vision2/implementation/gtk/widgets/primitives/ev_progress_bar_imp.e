indexing 
	description: "Eiffel Vision Progress bar. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PROGRESS_BAR_IMP

inherit
	EV_PROGRESS_BAR_I
		redefine
			interface
		end

	EV_GAUGE_IMP
		redefine
			interface,
			make
		end

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the progress bar.
		do
			Precursor (an_interface)
			set_c_object (C.gtk_progress_bar_new_with_adjustment (adjustment))
			gtk_progress_bar := c_object
		end

feature -- Status report

	is_segmented: BOOLEAN is
			-- Is display segmented?
		do
			Result := C.gtk_progress_bar_struct_bar_style (gtk_progress_bar) =
				C.Gtk_progress_discrete_enum
		end

feature -- Status setting

	enable_segmentation is
			-- Display bar divided into segments.
		do
			C.gtk_progress_bar_set_bar_style (
				gtk_progress_bar,
				C.Gtk_progress_discrete_enum
			)
		end

	disable_segmentation is
			-- Display bar without segments.
		do
			C.gtk_progress_bar_set_bar_style (
				gtk_progress_bar,
			 	C.Gtk_progress_continuous_enum
			)
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_bar: POINTER

	interface: EV_PROGRESS_BAR

end -- class EV_PROGRESS_BAR_IMP

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

