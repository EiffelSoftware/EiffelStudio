indexing 
	description: "Eiffel Vision file dialog. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_IMP

inherit
	EV_FILE_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window with a parent.
		do
			base_make (an_interface)
			set_c_object (C.gtk_file_selection_new (eiffel_to_c ("Select file")))
			C.gtk_window_set_modal (c_object, True)
			filter := "*.*"
			start_directory := "."
		end

	initialize is
			-- Setup action sequences.
		do
			real_signal_connect (
				C.gtk_file_selection_struct_ok_button (c_object),
				"pressed",
				~on_ok)
			real_signal_connect (
				C.gtk_file_selection_struct_cancel_button (c_object),
				"pressed",
				~on_cancel)
			is_initialized := True
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if selected_button /= Void and then selected_button.is_equal ("OK") then
				create Result.make (0)
				Result.from_c (C.gtk_file_selection_get_filename (c_object))
			end
		end

	filter: STRING
			-- Filter currently applied to file list.

	start_directory: STRING
			-- Base directory where browsing will start.

feature -- Status report

	file_title: STRING is
			-- `file_name' without its path.
		do
			if file_name /= Void then
				Result := file_name.mirrored
				Result.head (Result.index_of ('/', 1) - 1)
				Result.mirror
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			if file_name /= Void then
				Result := clone (file_name)
				Result.head (Result.count - Result.mirrored.index_of ('/', 1) + 1)
			end
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		do
			filter := clone (a_filter)
			C.gtk_file_selection_complete (c_object, eiffel_to_c (a_filter))
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		do
			C.gtk_file_selection_set_filename (c_object, eiffel_to_c (a_name))
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			check
				to_be_implemented: False
			end
		end

feature {NONE} -- Implementation

	interface: EV_FILE_DIALOG

end -- class EV_FILE_DIALOG_IMP

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
--| Revision 1.6  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.5.6.6  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.5.6.5  2000/01/27 23:56:52  brendel
--| Implemented file_title and file_path.
--| Fixed bug in file_name.
--|
--| Revision 1.5.6.4  2000/01/27 22:03:12  brendel
--| Improved contracts.
--| Removed feature default_extension.
--| Added features file_path and file_title.
--|
--| Revision 1.5.6.3  2000/01/27 19:29:41  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.5.6.2  2000/01/27 02:40:10  brendel
--| Revised. Now has attributes: file_name, start_directory, default_extension,
--| filter.
--|
--| Revision 1.5.6.1  1999/11/24 17:29:52  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.5.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
