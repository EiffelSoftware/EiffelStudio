indexing 
	description: "Eiffel Vision directory dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window with a parent.
		do
			base_make (an_interface)
			set_c_object (
				C.gtk_file_selection_new (
					eiffel_to_c ("Select directory")
				)
			)
			C.gtk_widget_hide (
				C.gtk_widget_struct_parent (
					C.gtk_file_selection_struct_file_list (c_object)
				)
			)
			C.gtk_widget_hide (
				C.gtk_file_selection_struct_fileop_del_file (c_object)
			)
			C.gtk_widget_hide (
				C.gtk_file_selection_struct_fileop_ren_file (c_object)
			)
			C.gtk_widget_realize (c_object)
			create start_directory.make (0)
			start_directory.from_c (
				C.gtk_file_selection_get_filename (c_object)
			)
		end

	initialize is
			-- Setup action sequences.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			is_initialized := False
			real_signal_connect (
				C.gtk_file_selection_struct_ok_button (c_object),
				"pressed",
				~on_ok,
				Void
			)
			real_signal_connect (
				C.gtk_file_selection_struct_cancel_button (c_object),
				"pressed",
				~on_cancel,
				Void
			)
			enable_closeable
			is_initialized := True
		end

feature -- Access

	directory: STRING is
			-- Path of the current selected file
		do
			if
				selected_button /= Void and then selected_button.is_equal ("OK")
			then
				create Result.make (0)
				Result.from_c (C.gtk_file_selection_get_filename (c_object))
			end
		end

	start_directory: STRING
			-- Base directory where browsing will start.

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			start_directory := a_path
			if start_directory.item (start_directory.count) /= '/' then
				-- The path has no trailing / so we add one to internal string.
				start_directory.append ("/")
			end
			C.gtk_file_selection_set_filename (
				c_object,
				eiffel_to_c (start_directory)
			)
		end

feature {NONE} -- Implementation

	interface: EV_DIRECTORY_DIALOG

end -- class EV_DIRECTORY_DIALOG_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2001/06/22 00:50:03  king
--| Now using initialize precursor
--|
--| Revision 1.10  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.5.4.3  2000/08/22 17:19:41  king
--| Removed uneccessary start_directory_internal
--|
--| Revision 1.5.4.2  2000/08/16 19:41:58  king
--| Fully implemented
--|
--| Revision 1.5.4.1  2000/05/03 19:08:46  oconnor
--| mergred from HEAD
--|
--| Revision 1.9  2000/04/20 18:07:39  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.8  2000/04/04 20:51:57  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.7  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.6  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.5  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.5.6.4  2000/01/28 01:35:52  brendel
--| Implemented `directory'.
--| Fixed bug in creation.
--|
--| Revision 1.5.6.3  2000/01/28 01:22:20  brendel
--| Changed to comply with _I.
--| Implemented creation procedure.
--|
--| Revision 1.5.6.2  2000/01/27 19:29:40  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
