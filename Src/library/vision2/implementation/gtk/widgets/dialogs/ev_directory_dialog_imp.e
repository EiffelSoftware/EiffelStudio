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

