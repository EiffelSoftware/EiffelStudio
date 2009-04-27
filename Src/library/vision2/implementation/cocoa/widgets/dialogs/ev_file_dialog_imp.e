indexing
	description: "Eiffel Vision file dialog. Cocoa implementation."

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
			show_modal_to_window,
			show,
			destroy
		end

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		do
			base_make (an_interface)
		end

	initialize
			-- Setup action sequences.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			filter := "*.*"
			create filters.make (5)
			internal_filename := ""

			set_is_initialized (True)
		end

	show
			-- Run the created Dialog
		do
		end


feature -- Access

	file_name: STRING_32
			-- Full name of currently selected file including path.
		do
			Result := internal_filename
		end

	filter: STRING_32
			-- Filter currently applied to file list.

	selected_filter_index: INTEGER
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		do
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
			filter_name: STRING_32
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
			end

		end

	set_file_name (a_name: STRING_GENERAL)
			-- Make `a_name' the selected file.
		do
		end

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		do
		end

feature {NONE} -- Implementation

	remove_file_filters
			-- Remove current file filters of `Current'
		local
			a_filter_list: POINTER
			a_filter: POINTER
			i: INTEGER
		do
			if a_filter_list /= NULL then
				from
				until
					a_filter = NULL
				loop
					i := i + 1
				end
			end
		end

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show `Current' modal to `a_window' until the user closes it
		local
			filter_string_list: LIST [STRING_32]
			current_filter_string, current_filter_description: STRING_GENERAL
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
						from
							filter_string_list.start
						until
							filter_string_list.off
						loop
							if filter_string_list.item.is_equal ("*.*") then
							else
							end
							filter_string_list.forth
						end
					end
				end
				filters.forth
			end
			Precursor {EV_STANDARD_DIALOG_IMP} (a_window)
		end

	valid_file_name, valid_file_title (a_name: STRING_32): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		do
			if a_name /= Void then
				Result := not a_name.has ('*')
			end
		end

	internal_filename: STRING

	destroy
			-- Clean up
		do
		end

	interface: EV_FILE_DIALOG;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FILE_DIALOG_IMP

