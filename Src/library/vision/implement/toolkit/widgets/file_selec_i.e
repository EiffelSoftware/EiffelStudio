indexing

	description: "implementation fo a file selector"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FILE_SELEC_I 

inherit

	TERMINAL_I
	
feature -- Access

	dir_list: LINKED_LIST [STRING] is
			-- Items of current directory list
		deferred
		end;

	dir_count: INTEGER is
			-- Number of items in directory list
		deferred
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		deferred
		end;

	file_count: INTEGER is
			-- Number of items in file list
		deferred
		end;

	file_list: LINKED_LIST [STRING] is
			-- Items of current file list
		deferred
		end;

	filter: STRING is
			-- Current filter value
		deferred
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		deferred
		end;

	pattern_name: STRING is
			-- Name of the search pattern used in combination
			-- with `directory' files and directories to be displayed
		deferred
		end;

	selected_file: STRING is
			-- Current selected file
		deferred
		end;

feature -- Status report

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		deferred
		end;

	is_list_updated: BOOLEAN is
			-- Is file od directory list updated during last search?
		deferred
		end;

feature -- Status setting


	show_cancel_button is
			-- Make cancel button visible.
		deferred
		end;

	show_filter_button is
			-- Make filter button visible.
		deferred
		end;

	show_help_button is
			-- Make help button visible.
		deferred
		end;

	show_ok_button is
			-- Make ok button visible.
		deferred
		end;

	hide_file_selection_list is
		deferred
		end;

	hide_file_selection_label is
		deferred
		end;
	
	show_file_selection_label is
		deferred
		end;

	show_file_selection_list is
		deferred
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		deferred
		end;

	hide_filter_button is
			-- Make filter button invisible.
		deferred
		end;

	hide_help_button is
			-- Make help button invisible.
		deferred
		end;

	hide_ok_button is
			-- Make ok button invisible.
		deferred
		end;

feature -- Element change

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		deferred
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
			-- to be displayed to `a_directory_name'.
		require
			not_a_directory_name_void: a_directory_name /= Void
		deferred
		end;

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		deferred
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		require
			not_a_filter_void: a_filter /= Void
		deferred
		end;

	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		deferred
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		require
			not_a_pattern_void: a_pattern /= Void
		deferred
		end;

	set_pattern_name (a_name: STRING) is
			-- Set pattern_name to `a_name'.
		require
			not_a_name_void: a_name /= Void
		deferred
		end;

	set_file_list_width (new_width: INTEGER) is
		deferred
		end;
  
	set_directory_selection is
			-- Sets selection to directories only.
		deferred
		end;
 
	set_file_selection is
			-- Sets selection to files (default value).
		deferred
		end;

	set_all_selection is
			 -- Sets selection to files and directories.
		deferred
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: a_command /= Void
		deferred
		end;

end -- class FILE_SELEC


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

