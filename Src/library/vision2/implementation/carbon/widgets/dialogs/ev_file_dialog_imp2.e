note
	description: "Eiffel Vision file dialog. Carbon implementation."

deferred class
	EV_FILE_DIALOG_IMP2

inherit
	EV_FILE_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize,
			show_modal_to_window,
			show,
			destroy
		end

	NAVIGATION_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	AEDATAMODEL_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CFURL_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		local
			a_cs: EV_CARBON_CF_STRING
			ret: INTEGER
			options: NAV_DIALOG_CREATION_OPTIONS_STRUCT
			in_type_list, in_event_proc, in_preview_proc, in_filter_proc: POINTER
		do
			base_make (an_interface)
			a_cs := "Select file"
			create options.make_new_unshared
			ret := nav_get_default_dialog_creation_options_external (options.item)

			in_type_list := null
			in_event_proc := null
			in_preview_proc := null
			in_filter_proc := null
			ret := nav_create_choose_file_dialog_external (options.item, in_type_list, in_event_proc, in_preview_proc, in_filter_proc, null, $c_object)
			create filters.make (0)
		end

	initialize
			-- Setup action sequences.
		local
			a_ok_button, a_cancel_button: POINTER
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			filter := "*.*"

			enable_closeable
--			set_start_directory (App_implementation.current_working_directory)
			set_is_initialized (True)
		end

	show
			--
		local
			ret: INTEGER
			reply: NAV_REPLY_RECORD_STRUCT
		do
			ret := nav_dialog_run_external (c_object)
			create reply.make_new_unshared
			ret := nav_dialog_get_reply_external (c_object, reply.item)
			if reply.validrecord.to_boolean then
				on_ok
			else
				on_cancel
			end
		end


feature -- Access

	file_name: STRING_32
			-- Full name of currently selected file including path.
		local
			ret: INTEGER
			reply: NAV_REPLY_RECORD_STRUCT
			i: INTEGER
			res_type, keyword: INTEGER
			data_ptr: FSREF_STRUCT
			cfurl: CFURL_STRUCT
			actual_size: INTEGER
			path: EV_CARBON_CF_STRING
		do
			if
				selected_button /= Void and then selected_button.is_equal (internal_accept)
			then
				create reply.make_new_unshared
				ret := nav_dialog_get_reply_external (c_object, reply.item)
				ret := aecount_items_external (reply.selection, $i)
				check
					one_file_selected: i = 1
				end
				create data_ptr.make_new_unshared
				ret := aeget_nth_ptr_external (reply.selection, 1, {AEDATA_MODEL_ANON_ENUMS}.typeFSRef, $keyword, $res_type, data_ptr.item, 40, $actual_size)
				create cfurl.make_unshared (cfurlcreate_from_fsref_external (null, data_ptr.item))
				create path.make_unshared (cfurlcopy_path_external (cfurl.item))
				Result := path.string
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
--			a_current_filter := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_get_filter (c_object)
--			a_filter_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_list_filters (c_object)
			if a_current_filter /= NULL and then a_filter_list /= NULL then
--				from
--					i := 0
--				until
--					{EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i) = a_current_filter
--				loop
--					i := i + 1
--				end
--				{EV_GTK_EXTERNALS}.g_slist_free (a_filter_list)
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
			a_cs: EV_CARBON_CF_STRING
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
--				a_filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
--				a_cs :=  (a_filter)
--				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
--				a_cs :=  (filter_name)
--				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
--				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
			end

--			a_cs :=  ("*")
--					-- File filter uses a globbing pattern so this is the only filter that can show all files
--			a_filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (a_filter_ptr, a_cs.item)
--			a_cs :=  ("All files *.*")
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (a_filter_ptr, a_cs.item)
--			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, a_filter_ptr)
		end

	set_file_name (a_name: STRING_GENERAL)
			-- Make `a_name' the selected file.
		local
			a_cs: EV_CARBON_CF_STRING
		do
			a_cs := a_name
--			{EV_GTK_EXTERNALS}.gtk_file_chooser_set_filename (c_object, a_cs.item)
		end

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		local
			a_cs: EV_CARBON_CF_STRING
		do
			start_directory := a_path.twin
			a_cs := start_directory + "/"
--			{EV_GTK_EXTERNALS}.gtk_file_chooser_set_current_folder (
--				c_object,
--				a_cs.item
--			)
		end

feature {NONE} -- Implementation

	remove_file_filters
			-- Remove current file filters of `Current'
		local
			a_filter_list: POINTER
			a_filter: POINTER
			i: INTEGER
		do
--			a_filter_list := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_list_filters (c_object)
			if a_filter_list /= NULL then
				from
--					a_filter := {EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i)
				until
					a_filter = NULL
				loop
--					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_remove_filter (c_object, a_filter)
					i := i + 1
--					a_filter := {EV_GTK_EXTERNALS}.g_slist_nth_data (a_filter_list, i)
				end
--				{EV_GTK_EXTERNALS}.g_slist_free (a_filter_list)
			end
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal to `a_window' until the user closes it
		local
			filter_string_list: LIST [STRING_32]
			current_filter_string, current_filter_description: STRING_GENERAL
			filter_ptr: POINTER
			a_cs: EV_CARBON_CF_STRING
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
--						filter_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_new
--						a_cs := current_filter_description
--						{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_set_name (filter_ptr, a_cs.item)
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
--							{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_filter_add_pattern (filter_ptr, a_cs.item)
							filter_string_list.forth
						end
--						{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_add_filter (c_object, filter_ptr)
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


	destroy
			-- Clean up
		do
			nav_dialog_dispose_external (c_object)
		end



	interface: EV_FILE_DIALOG;

note
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac Team"
end -- class EV_FILE_DIALOG_IMP

