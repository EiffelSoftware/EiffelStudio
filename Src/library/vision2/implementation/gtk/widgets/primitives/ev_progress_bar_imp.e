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
			interface
		end

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the progress bar.
		do
			base_make (an_interface)
			adjustment := C.gtk_adjustment_new (1, 1, 100, 1, 10, 10)
			set_c_object (C.gtk_event_box_new)		
			gtk_progress_bar := C.gtk_progress_bar_new_with_adjustment (adjustment)
			C.gtk_widget_show (gtk_progress_bar)
			C.gtk_container_add (c_object, gtk_progress_bar)
		end

feature -- Access

	proportion: REAL is
			-- Proportion of bar filled. Range: [0,1].
		do
			--Result := (value - minimum) / (maximum - minimum)
			if not is_destroyed then
				Result := C.gtk_progress_get_current_percentage (gtk_progress_bar)
			end
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
			C.gtk_progress_bar_set_bar_style (gtk_progress_bar, C.Gtk_progress_discrete_enum)
		end

	disable_segmentation is
			-- Display bar without segments.
		do
			C.gtk_progress_bar_set_bar_style (gtk_progress_bar, C.Gtk_progress_continuous_enum)
		end

	set_proportion (a_proportion: REAL) is
			-- Display bar with `a_proportion' filled.
		do
			C.gtk_progress_set_percentage (gtk_progress_bar, a_proportion)
		end

feature {EV_ANY_I} -- Implementation

	gtk_progress_bar: POINTER

	interface: EV_PROGRESS_BAR

end -- class EV_PROGRESS_BAR_IMP

--!----------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.7  2000/02/14 11:04:08  oconnor
--| wrapped in event box
--|
--| Revision 1.10.6.6  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.10.6.5  2000/01/31 21:34:52  brendel
--| Revised.
--|
--| Revision 1.10.6.4  2000/01/27 19:29:47  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.3  2000/01/17 19:08:01  oconnor
--| changed percentage to proportion
--|
--| Revision 1.10.6.2  2000/01/14 21:47:31  king
--| Reduced the number of calls to external user c-functions, converted to new structure
--|
--| Revision 1.10.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.10.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
