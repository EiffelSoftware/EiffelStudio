note
	description: "Eiffel Vision file dialog. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			make,
			on_ok,
			show_modal_to_window
		end

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
			a_cs := "Select file"
			set_c_object
				({EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_dialog_new (a_cs.item, NULL, file_chooser_action))
			create filters.make (0)
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			filter := "*.*"

			a_cancel_button := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_add_button (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_stock_cancel_enum, {EV_GTK_EXTERNALS}.gtk_response_cancel_enum)
			a_ok_button := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_add_button (c_object, {EV_GTK_DEPENDENT_EXTERNALS}.gtk_stock_ok_enum, {EV_GTK_EXTERNALS}.gtk_response_accept_enum)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_set_local_only (c_object, True)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_dialog_set_default_response (c_object, {EV_GTK_EXTERNALS}.gtk_response_accept_enum)

			real_signal_connect (
				a_ok_button,
				"clicked",
				agent (App_implementation.gtk_marshal).file_dialog_on_ok_intermediary (c_object),
				Void
			)
			real_signal_connect (
				a_cancel_button,
				"clicked",
				agent (App_implementation.gtk_marshal).file_dialog_on_cancel_intermediary (c_object),
				Void
			)
			enable_closeable
			set_start_directory (App_implementation.current_working_directory)
			set_is_initialized (True)
		end

feature -- Access

	file_name: STRING_32
			-- Full name of currently selected file including path.
		local
			a_cs: EV_GTK_C_STRING
		do
			if
				attached selected_button as l_selected_button and then l_selected_button.is_equal (internal_accept)
			then
				create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_file_chooser_get_filename (c_object))
				Result := a_cs.string
			else
				Result := ""
			end
		end

	filter: STRING_32
			-- Filter currently applied to file list.

	selected_filter_index: INTEGER
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		local
			a_current_filter, a_filter_list: POINTER
			i: INTEGER
		do
			a_current_filter := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_get_filter (c_object)
			a_filter_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_list_filters (c_object)
			if a_current_filter /= NULL and then a_filter_list /= NULL then
				from
					i := 0
				until
					{EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i) = a_current_filter
				loop
					i := i + 1
				end
				{EV_GTK_EXTERNALS}.g_slist_free (a_filter_list)
				Result := i + 1
			end

		end

	start_directory: STRING_32
			-- Base directory where browsing will start.

feature -- Status report

	file_title: STRING_32
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

	file_path: STRING_32
			-- Path of `file_name'.
		do
			if not file_name.is_empty then
				Result := file_name.twin
				Result.keep_head (Result.count - Result.mirrored.index_of ('/', 1) + 1)
			else
				Result := ""
			end
		end

feature -- Element change

	set_filter (a_filter: STRING_GENERAL)
			-- Set `a_filter' as new filter.
		local
			a_cs: EV_GTK_C_STRING
			filter_name: STRING_32
			a_filter_ptr: POINTER
		do
			filter := a_filter.twin

			filter_name := a_filter.twin
			if
				filter_name.count >= 3 and
				filter_name.item (1) = '*' and
				filter_name.item (2) = '.'
			then
				filter_name.remove_head (2)
				filter_name.put (filter_name.item (1).upper, 1)
				filter_name.append (" Files (")
				filter_name.append (a_filter)
				filter_name.append (")")
			end

			remove_file_filters

			if not a_filter.is_equal ("*.*") then
				a_filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
				a_cs :=  (a_filter)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
				a_cs :=  (filter_name)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
			end

			a_cs :=  ("*")
					-- File filter uses a globbing pattern so this is the only filter that can show all files
			a_filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
			a_cs :=  ("All files *.*")
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
		end

	set_file_name (a_name: STRING_GENERAL)
			-- Make `a_name' the selected file.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_name
			{EV_GTK_EXTERNALS}.gtk_file_chooser_set_filename (c_object, a_cs.item)
		end

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		local
			a_cs: EV_GTK_C_STRING
		do
			start_directory := a_path.twin
			a_cs := start_directory + "/"
			{EV_GTK_EXTERNALS}.gtk_file_chooser_set_current_folder (
				c_object,
				a_cs.item
			)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_ok
			-- The user has requested that the dialog be activated.
		local
			temp_filename: STRING_32
			temp_file: RAW_FILE
			a_filename: POINTER
			a_cs: EV_GTK_C_STRING
		do
			create temp_filename.make (0)
			a_filename := {EV_GTK_EXTERNALS}.gtk_file_chooser_get_filename (c_object)
			if a_filename /= NULL then
				create a_cs.share_from_pointer (a_filename)
				temp_filename := a_cs.string
				create temp_file.make (temp_filename.as_string_8)
				if (not temp_file.exists or else not temp_file.is_directory) and not
						temp_filename.item (temp_filename.count).is_equal ('/') then
					Precursor {EV_STANDARD_DIALOG_IMP}
				end
			end
		end

feature {NONE} -- Implementation

	remove_file_filters
			-- Remove current file filters of `Current'
		local
			a_filter_list: POINTER
			a_filter: POINTER
			i: INTEGER
		do
			a_filter_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_list_filters (c_object)
			if a_filter_list /= NULL then
				from
					a_filter := {EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i)
				until
					a_filter = NULL
				loop
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_remove_filter (c_object, a_filter)
					i := i + 1
					a_filter := {EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i)
				end
				{EV_GTK_EXTERNALS}.g_slist_free (a_filter_list)
			end
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal to `a_window' until the user closes it
		local
			filter_string_list: LIST [STRING_32]
			current_filter_string, current_filter_description: detachable STRING_GENERAL
			filter_ptr: POINTER
			a_cs: EV_GTK_C_STRING
		do
			if not filters.is_empty then
				remove_file_filters
			end
			from
				filters.start
			until
				filters.off
			loop
				current_filter_string ?= filters.item.item (1)
				current_filter_description ?= filters.item.item (2)
				if current_filter_string /= Void then
					filter_string_list := current_filter_string.to_string_32.split (';')
					if current_filter_description /= Void then
						filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
						create a_cs.set_with_eiffel_string (current_filter_description)
						{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (filter_ptr, a_cs.item)
						from
							filter_string_list.start
						until
							filter_string_list.off
						loop
							if filter_string_list.item.is_equal ("*.*") then
								a_cs := "*"
							else
								a_cs := filter_string_list.item
							end
							{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (filter_ptr, a_cs.item)
							filter_string_list.forth
						end
						{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, filter_ptr)
					end
				end
				filters.forth
			end
			Precursor {EV_STANDARD_DIALOG_IMP} (a_window)
		end

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		deferred
		end

	valid_file_name, valid_file_title (a_name: STRING_32): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		do
			if a_name /= Void then
				Result := not a_name.has ('*')
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EV_FILE_DIALOG_IMP
