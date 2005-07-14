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
		local
			a_cs: EV_GTK_C_STRING
		do
			base_make (an_interface)
			a_cs := "Select directory"
			set_c_object (
				{EV_GTK_EXTERNALS}.gtk_file_selection_new (
					a_cs.item
				)
			)
			{EV_GTK_EXTERNALS}.gtk_widget_hide (
				{EV_GTK_EXTERNALS}.gtk_widget_struct_parent (
					{EV_GTK_EXTERNALS}.gtk_file_selection_struct_file_list (c_object)
				)
			)
			{EV_GTK_EXTERNALS}.gtk_widget_hide (
				{EV_GTK_EXTERNALS}.gtk_file_selection_struct_fileop_del_file (c_object)
			)
			{EV_GTK_EXTERNALS}.gtk_widget_hide (
				{EV_GTK_EXTERNALS}.gtk_file_selection_struct_fileop_ren_file (c_object)
			)
			create start_directory.make (0)
			start_directory.from_c (
				{EV_GTK_EXTERNALS}.gtk_file_selection_get_filename (c_object)
			)
		end

	initialize is
			-- Setup action sequences.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)
			real_signal_connect (
				{EV_GTK_EXTERNALS}.gtk_file_selection_struct_ok_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).directory_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				{EV_GTK_EXTERNALS}.gtk_file_selection_struct_cancel_button (c_object),
				"clicked",
				agent (App_implementation.gtk_marshal).directory_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			set_is_initialized (True)
		end

feature -- Access

	directory: STRING is
			-- Path of the current selected file
		do
			if
				selected_button /= Void and then selected_button.is_equal (internal_accept)
			then
				create Result.make (0)
				Result.from_c ({EV_GTK_EXTERNALS}.gtk_file_selection_get_filename (c_object))
				if Result.item (Result.count) /= '/' then
					Result.append ("/")
				end
			else
				Result := ""
			end
		end

	start_directory: STRING
			-- Base directory where browsing will start.

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		local
			a_cs: EV_GTK_C_STRING
		do
			start_directory := a_path
			if start_directory.item (start_directory.count) /= '/' then
				-- The path has no trailing / so we add one to internal string.
				start_directory.append ("/")
			end
			a_cs := start_directory
			{EV_GTK_EXTERNALS}.gtk_file_selection_set_filename (
				c_object,
				a_cs.item
			)
		end

feature {NONE} -- Implementation

	interface: EV_DIRECTORY_DIALOG

end -- class EV_DIRECTORY_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

