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
		local
			a_gs: GEL_STRING
		do
			base_make (an_interface)
			create a_gs.make ("Select file")
			set_c_object
				(C.gtk_file_selection_new (a_gs.item))
			C.gtk_window_set_modal (c_object, True)
			filter := "*.*"
			set_start_directory (".")
			C.gtk_widget_realize (c_object)
		end

	initialize is
			-- Setup action sequences.
		local
			a_child_list, a_label: POINTER
			a_gs: GEL_STRING
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			is_initialized := False
			a_child_list := C.gtk_container_children (C.gtk_file_selection_struct_ok_button (c_object))
			a_label := C.g_list_nth_data (
				a_child_list,
				0)
			C.g_list_free (a_child_list)
			create a_gs.make (internal_accept)
			C.gtk_label_set_text (a_label, a_gs.item)
			
			real_signal_connect (
				C.gtk_file_selection_struct_ok_button (c_object),
				"clicked",
				agent Gtk_marshal.file_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				C.gtk_file_selection_struct_cancel_button (c_object),
				"clicked",
				agent Gtk_marshal.file_dialog_on_cancel_intermediary (c_object),
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
				create Result.make_from_c (C.gtk_file_selection_get_filename (c_object))
			else
				Result := ""
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
			if not file_name.is_empty then
				Result := file_name.mirrored
				Result.keep_head (Result.index_of ('/', 1) - 1)
				Result.mirror
			else
				Result := ""
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			if not file_name.is_empty then
				Result := clone (file_name)
				Result.keep_head	(Result.count - Result.mirrored.index_of ('/', 1) + 1)
			else
				Result := ""
			end
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		local
			a_gs: GEL_STRING
		do
			filter := clone (a_filter)
			create a_gs.make (a_filter)
			C.gtk_file_selection_complete (c_object, a_gs.item)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		local
			a_gs: GEL_STRING
		do
			create a_gs.make (a_name)
			C.gtk_file_selection_set_filename (c_object, a_gs.item)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		local
			a_gs: GEL_STRING
		do
			start_directory := a_path
			if start_directory.item (start_directory.count) /= '/' then
				-- The path has no trailing / so we add one to internal string.
				start_directory.append ("/")
			end
			create a_gs.make (start_directory)
			C.gtk_file_selection_set_filename (
				c_object,
				a_gs.item
			)
		end

feature {INTERMEDIARY_ROUTINES} -- Implementation

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

feature {NONE} -- Implementation

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

