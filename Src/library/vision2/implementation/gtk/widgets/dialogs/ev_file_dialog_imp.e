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
			interface,
			initialize,
			on_ok
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a window with a parent.
		do
			base_make (an_interface)
			set_c_object
				(C.gtk_file_selection_new (eiffel_to_c ("Select file")))
			C.gtk_window_set_modal (c_object, True)
			filter := "*.*"
			set_start_directory (".")
			C.gtk_widget_realize (c_object)
		end

	initialize is
			-- Setup action sequences.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			is_initialized := False
			real_signal_connect (
				C.gtk_file_selection_struct_ok_button (c_object),
				"clicked",
				~on_ok,
				Void
			)
			real_signal_connect (
				C.gtk_file_selection_struct_cancel_button (c_object),
				"clicked",
				~on_cancel,
				Void
			)
			enable_closeable
			is_initialized := True
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if
				selected_button /= Void and then selected_button.is_equal (internal_accept)
			then
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
				Result.head
					(Result.count - Result.mirrored.index_of ('/', 1) + 1)
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

	on_ok is
			-- The user has requested that the dialog be activated.
		local
			temp_filename: STRING
		do
			create temp_filename.make (0)
			temp_filename.from_c (C.gtk_file_selection_get_filename (c_object))
			if not temp_filename.item (temp_filename.count).is_equal ('/') then
				Precursor {EV_STANDARD_DIALOG_IMP}
			end	
		end

	interface: EV_FILE_DIALOG

end -- class EV_FILE_DIALOG_IMP

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

