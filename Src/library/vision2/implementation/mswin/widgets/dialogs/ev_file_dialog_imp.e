indexing 
	description:
		"Eiffel Vision file dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_DIALOG_IMP

inherit
	EV_FILE_DIALOG_I

	EV_STANDARD_DIALOG_IMP
		redefine
			show_modal_to_window
		end

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
			set_filter ("*.*")
			start_directory := "."
			create filters.make (1)
		end

	initialize is
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Access

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if selected then
				Result := wel_file_name
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
			Result := file_name
			if not Result.is_empty then
				Result := Result.substring (
					Result.last_index_of ('\', Result.count) + 1,
					Result.count)
			end
		end

	file_path: STRING is
			-- Path of `file_name'.
		do
			Result := file_name
			if not Result.is_empty then
				Result := Result.substring (
					1,
					Result.last_index_of ('\', Result.count) - 1)
			end
		end
		
	selected_filter_index: INTEGER is
			-- One based index of selected filter within `filters', or
			-- zero if no filters set.
		do
			if selected then
				Result := filter_index
			elseif not filters.is_empty then
					-- We return 1 when filters is not empty and the dialog is cancelled,
					-- as the postcondition in the interface requires that the index is
					-- between 1 and filters.count, however we cannot query the real index when cancelled.
				Result := 1
			end
		end

feature -- Element change

	set_filter (a_filter: STRING) is
			-- Set `a_filter' as new filter.
		local
			filter_name: STRING
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
			if a_filter.is_equal ("*.*") then
				wel_set_filter (<<"All files">>, <<"*.*">>)
			else
				wel_set_filter (<<filter_name, "All files">>, <<a_filter, "*.*">>)
			end
			wel_set_filter_index (0)
		end

	set_file_name (a_name: STRING) is
			-- Make `a_name' the selected file.
		do
			wel_set_file_name (a_name)
		end

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			start_directory := a_path.twin
			wel_set_initial_directory (a_path)
		end
		
feature {NONE} -- Implementation

	valid_file_name (a_name: STRING): BOOLEAN is
			-- Is `a_name' a valid file_name on the current platform?
			-- Certain characters are not permissible and this is dependent
			-- on the current platform. The following characters are not permitted,
			-- and this list may not be exhaustive:
			-- Windows - " * : < > ? |
			-- Linux - & *
		do
			if not (a_name.has ('%%') or a_name.has ('*') or a_name.has ('<') or
				a_name.has ('>') or a_name.has ('?') or a_name.has ('|')) then
				Result := True
			end
		end
		
	valid_file_title (a_title: STRING): BOOLEAN is
			-- Is `a_title' a valid file title on the current platform?
			-- The following characters are not permitted,
			-- and this list may not be exhaustive:
			-- Windows - " * / : < > ? \ |
			-- Linux - & *
		do
			Result := valid_file_name (a_title) and not (a_title.has ('/') or a_title.has ('\') or  a_title.has (':'))
		end
		
	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show the window and wait until the user closed it.
		local
			filter_name: STRING
			filter_pattern: STRING
			filter_names: ARRAY [STRING]
			filter_patterns: ARRAY [STRING]
			filter_info: TUPLE [STRING, STRING]
		do
				--| FIXME when `set_filter' is removed, this check for
				--| being non empty may be removed. Julian.
			if not filters.is_empty then
					-- Filters are now connected before showing the window based
					-- on the current contents of `filters', as they do not need
					-- to be updated dynamically.
				create filter_names.make (1, filters.count)
				create filter_patterns.make (1, filters.count)
				from
					filters.start
				until
					filters.off
				loop
					filter_info := filters.item
					filter_pattern ?= filter_info.item (1)
					filter_name ?= filter_info.item (2)
					
					filter_patterns.put (filter_pattern, filters.index)
					filter_names.put (filter_name, filters.index)
					filters.forth
				end
				wel_set_filter (filter_names, filter_patterns)
				wel_set_filter_index (0)
			end
			
				-- Now show the dialog in the standard fashion.
			Precursor {EV_STANDARD_DIALOG_IMP} (a_window)	
		end
		

feature -- Deferred

	wel_make is
		deferred
		end

	wel_file_name: STRING is
		deferred
		end

	wel_set_file_name (a_file_name: STRING) is
		deferred
		end

	wel_set_filter (filter_names, filter_patterns: ARRAY [STRING]) is
		deferred
		end

	wel_set_filter_index (a_filter_index: INTEGER) is
		deferred
		end

	wel_set_initial_directory (a_directory: STRING) is
		deferred
		end
		
	filter_index: INTEGER is
		deferred
		end

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




end -- class EV_FILE_DIALOG_IMP

