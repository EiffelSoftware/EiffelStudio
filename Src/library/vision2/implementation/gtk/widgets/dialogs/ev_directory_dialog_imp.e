indexing
	description: "Eiffel Vision directory dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			set_c_object
				({EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_dialog_new (a_cs.item, NULL, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_action_select_folder_enum))
		end

	initialize is
			-- Setup action sequences.
		local
			a_ok_button, a_cancel_button: POINTER
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			a_cancel_button := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_add_button (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_stock_cancel_enum, {EV_GTK_EXTERNALS}.gtk_response_cancel_enum)
			a_ok_button := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_add_button (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_stock_ok_enum, {EV_GTK_EXTERNALS}.gtk_response_accept_enum)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_set_default_response (c_object, {EV_GTK_EXTERNALS}.gtk_response_accept_enum)

			real_signal_connect (
				a_ok_button,
				"clicked",
				agent (App_implementation.gtk_marshal).directory_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				a_cancel_button,
				"clicked",
				agent (App_implementation.gtk_marshal).directory_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			set_start_directory (App_implementation.current_working_directory)
			set_is_initialized (True)
		end

feature -- Access

	directory: STRING_32 is
			-- Path of the current selected file
		local
			a_filename: POINTER
			a_cs: EV_GTK_C_STRING
		do
			if
				selected_button /= Void and then selected_button.is_equal (internal_accept)
			then
				Result := ""
				a_filename := {EV_GTK_EXTERNALS}.gtk_file_chooser_get_filename (c_object)
				if a_filename /= NULL then
					create a_cs.share_from_pointer (a_filename)
					Result := a_cs.string
					if Result.item (Result.count) /= '/' then
						Result.append ("/")
					end
					{EV_GTK_EXTERNALS}.g_free (a_filename)
				end
			else
				Result := ""
			end
		end

	start_directory: STRING_32
			-- Base directory where browsing will start.

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL) is
			-- Make `a_path' the base directory.
		local
			a_cs: EV_GTK_C_STRING
		do
			start_directory := a_path.twin
			a_cs := start_directory + "/."
			{EV_GTK_EXTERNALS}.gtk_file_chooser_set_filename (
				c_object,
				a_cs.item
			)
		end

feature {NONE} -- Implementation

	interface: EV_DIRECTORY_DIALOG;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DIRECTORY_DIALOG_IMP

