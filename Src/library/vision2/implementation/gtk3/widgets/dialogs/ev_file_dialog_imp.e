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

	NATIVE_STRING_HANDLER

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a window with a parent.
		do
			assign_interface (an_interface)
		end

	make
			-- Setup action sequences.
		local
			a_cs: EV_GTK_C_STRING
			l_but: POINTER
		do
			a_cs := "Select file"
			set_c_object
				({GTK2}.gtk_file_chooser_dialog_new (a_cs.item, default_pointer, file_chooser_action))
			l_but := {GTK2}.gtk_dialog_add_button (c_object, {GTK2}.gtk_ok_enum_label, {GTK2}.gtk_response_ok_enum)
			l_but := {GTK2}.gtk_dialog_add_button (c_object, {GTK2}.gtk_cancel_enum_label, {GTK2}.gtk_response_cancel_enum)
			create filters.make (0)
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			filter := {STRING_32} "*.*"

			{GTK2}.gtk_file_chooser_set_local_only (c_object, True)
			{GTK2}.gtk_dialog_set_default_response (c_object, {GTK2}.gtk_response_accept_enum)

			enable_closeable
			set_start_path (App_implementation.current_working_path)
			set_is_initialized (True)
		end

feature -- Access

	full_file_path: PATH
			-- Full name of currently selected file including path.
		local
			l_filename: POINTER
		do
			if
				user_clicked_ok
			then
				l_filename := {GTK2}.gtk_file_chooser_get_filename (c_object)
				if l_filename /= default_pointer then
					create Result.make_from_pointer (l_filename)
					{GDK}.g_free (l_filename)
				else
					create Result.make_empty
				end
			else
				create Result.make_empty
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
			a_current_filter := {GTK2}.gtk_file_chooser_get_filter (c_object)
			a_filter_list := {GTK2}.gtk_file_chooser_list_filters (c_object)
			if
				not a_current_filter.is_default_pointer and then
				not a_filter_list.is_default_pointer then
				from
					i := 0
				until
					{GDK}.g_slist_nth_data (a_filter_list, i) = a_current_filter
				loop
					i := i + 1
				end
				{GDK}.g_slist_free (a_filter_list)
				Result := i + 1
			end

		end

	start_path: PATH
			-- Base directory where browsing will start.

feature -- Element change

	set_filter (a_filter: READABLE_STRING_GENERAL)
			-- Set `a_filter' as new filter.
		local
			a_cs: EV_GTK_C_STRING
			filter_name: STRING_32
			a_filter_ptr: POINTER
		do
			filter := a_filter.as_string_32.twin

			filter_name := a_filter.as_string_32.twin
			if
				filter_name.count >= 3 and
				filter_name.item (1) = '*' and
				filter_name.item (2) = '.'
			then
				filter_name.remove_head (2)
				filter_name.put (filter_name.item (1).upper, 1)
				filter_name.append_string_general (" Files (")
				filter_name.append_string_general (a_filter)
				filter_name.append_character (')')
			end

			remove_file_filters

			if not a_filter.is_equal ("*.*") then
				a_filter_ptr := {GTK2}.gtk_file_filter_new
				a_cs :=  (a_filter)
				{GTK2}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
				a_cs :=  (filter_name)
				{GTK2}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
				{GTK2}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
			end

			a_cs :=  ("*")
					-- File filter uses a globbing pattern so this is the only filter that can show all files
			a_filter_ptr := {GTK2}.gtk_file_filter_new
			{GTK2}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
			a_cs :=  ("All files *.*")
			{GTK2}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
			{GTK2}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
		end

	set_full_file_path (a_path: PATH)
			-- Make `a_name' the selected file.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make_from_path (a_path)
			{GTK2}.gtk_file_chooser_set_filename (c_object, a_cs.item)
				-- Force the `current_name' to be what is specified in `a_path'.
				-- If we do not do that and `a_path' has no file associated on disk
				-- GTK won't put the file name user specified in the name entry of the dialog.
			if attached a_path.entry as l_entry then
				create a_cs.make_from_path (l_entry)
				{GTK2}.gtk_file_chooser_set_current_name (c_object, a_cs.item)
			end
		end

	set_start_path (a_path: PATH)
			-- Make `a_path' the base directory.
		local
			a_cs: EV_GTK_C_STRING
		do
			start_path := a_path
			create a_cs.make_from_path (a_path)
			{GTK2}.gtk_file_chooser_set_current_folder (c_object, a_cs.item)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	on_ok
			-- The user has requested that the dialog be activated.
		local
			temp_filename: PATH
			temp_file: RAW_FILE
			a_filename: POINTER
		do
			a_filename := {GTK2}.gtk_file_chooser_get_filename (c_object)
			if not a_filename.is_default_pointer then
				create temp_filename.make_from_pointer (a_filename)
				create temp_file.make_with_path (temp_filename)
				if (not temp_file.exists or else not temp_file.is_directory) then
					Precursor {EV_STANDARD_DIALOG_IMP}
				end
				{GDK}.g_free (a_filename)
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
			a_filter_list := {GTK2}.gtk_file_chooser_list_filters (c_object)
			if not a_filter_list.is_default_pointer then
				from
					a_filter := {GDK}.g_slist_nth_data (a_filter_list, i)
				until
					a_filter.is_default_pointer
				loop
					{GTK2}.gtk_file_chooser_remove_filter (c_object, a_filter)
					i := i + 1
					a_filter := {GDK}.g_slist_nth_data (a_filter_list, i)
				end
				{GDK}.g_slist_free (a_filter_list)
			end
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal to `a_window' until the user closes it
		local
			filter_string_list: LIST [STRING_32]
			current_filter_string, current_filter_description: detachable READABLE_STRING_GENERAL
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
						filter_ptr := {GTK2}.gtk_file_filter_new
						create a_cs.set_with_eiffel_string (current_filter_description)
						{GTK2}.gtk_file_filter_set_name (filter_ptr, a_cs.item)
						from
							filter_string_list.start
						until
							filter_string_list.off
						loop
							if filter_string_list.item.same_string_general ("*.*") then
								a_cs := "*"
							else
								a_cs := filter_string_list.item
							end
							{GTK2}.gtk_file_filter_add_pattern (filter_ptr, a_cs.item)
							filter_string_list.forth
						end
						{GTK2}.gtk_file_chooser_add_filter (c_object, filter_ptr)
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

	valid_file_name, valid_file_title (a_name: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		do
			Result := not a_name.has ('*')
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_FILE_DIALOG_IMP
