note
	description: "Eiffel Vision file dialog. Cocoa implementation."
	author:	"Daniel Furrer"

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
			make
		end

feature {NONE} -- Initialization

	make
			-- Setup action sequences.
		do
			Precursor {EV_STANDARD_DIALOG_IMP}
			set_is_initialized (False)

			filter := "*.*"
			create filters.make (5)
			internal_filename := ""
			create start_directory.make_empty

			set_is_initialized (True)
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

			if not a_filter.is_equal ("*.*") then
			end

		end

	set_file_name (a_name: STRING_GENERAL)
			-- Make `a_name' the selected file.
		do
			internal_filename := a_name.twin.as_string_32
		end

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		do
			start_directory := a_path
			save_panel.set_directory (create {NS_STRING}.make_with_string (a_path))
		end

feature {NONE} -- Implementation

	valid_file_name, valid_file_title (a_name: STRING_32): BOOLEAN
			-- Is `a_name' a valid file_name on the current platform?
		do
			if a_name /= Void then
				Result := not a_name.has ('*')
			end
		end

	internal_filename: STRING

	save_panel: NS_SAVE_PANEL

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_DIALOG note option: stable attribute end;

end -- class EV_FILE_DIALOG_IMP
