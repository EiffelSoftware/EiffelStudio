note
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
			make
		end

	NATIVE_STRING_HANDLER

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Create a window with a parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Setup action sequences.
		local
			a_ok_button, a_cancel_button: POINTER
			a_cs: EV_GTK_C_STRING
		do
			a_cs := "Select directory"
			set_c_object
				({GTK2}.gtk_file_chooser_dialog_new (a_cs.item, NULL, {GTK2}.gtk_file_chooser_action_select_folder_enum))

			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			a_cancel_button := {GTK2}.gtk_dialog_add_button (c_object, {GTK2}.gtk_stock_cancel_enum, {GTK2}.gtk_response_cancel_enum)
			a_ok_button := {GTK2}.gtk_dialog_add_button (c_object, {GTK2}.gtk_stock_ok_enum, {GTK2}.gtk_response_accept_enum)

			{GTK2}.gtk_dialog_set_default_response (c_object, {GTK2}.gtk_response_accept_enum)

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
			set_start_path (App_implementation.current_working_path)
			set_is_initialized (True)
		end

feature -- Access

	path: PATH
			-- Path of the current selected file
		local
			a_filename: POINTER
		do
			if
				attached selected_button as l_selected_button and then l_selected_button.is_equal (internal_accept)
			then
				a_filename := {GTK2}.gtk_file_chooser_get_filename (c_object)
				if a_filename /= NULL then
					create Result.make_from_pointer (a_filename)
					{GTK}.g_free (a_filename)
				else
					create Result.make_empty
				end
			else
				create Result.make_empty
			end
		end

	start_path: PATH
			-- Base directory where browsing will start.

feature -- Element change

	set_start_path (a_path: PATH)
			-- Make `a_path' the base directory.
		local
			a_cs: EV_GTK_C_STRING
		do
			start_path := a_path
			create a_cs.make_from_path (a_path)
			{GTK2}.gtk_file_chooser_set_filename (c_object, a_cs.item)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIRECTORY_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_DIRECTORY_DIALOG_IMP
