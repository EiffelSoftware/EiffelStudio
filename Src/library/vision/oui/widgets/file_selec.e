
-- 

indexing

	date: "$Date$";
	revision: "$Revision$"

class FILE_SELEC 

inherit

	TERMINAL
		rename
			make as terminal_make
		redefine
			implementation
		end


creation

	make

	
feature 

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_filter_action (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_help_action (a_command, argument)
		end; 

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.add_ok_action (a_command, argument)
		end; -- add_ok_action

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a selection list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		require
			name_not_void: not (a_name = Void);
			parent_not_void: not (a_parent = Void)
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			implementation:= toolkit.file_selec (Current);
			set_default
		ensure
			parent = a_parent;
			identifier.is_equal (a_name)
		end;
		

	dir_count: INTEGER is
			-- Number of items in directory list
		do
			Result := implementation.dir_count
		end;

	dir_list: LINKED_LIST [STRING] is
			-- Items of current directory list
		do
			Result := implementation.dir_list
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		do
			Result := implementation.directory
		end;

	file_count: INTEGER is
			-- Number of items in file list
		do
			Result := implementation.file_count
		end;

	file_list: LINKED_LIST [STRING] is
			-- Items of current file list
		do
			Result := implementation.file_list
		end;

	filter: STRING is
			-- Current filter value
		do
			Result := implementation.filter
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			implementation.hide_cancel_button
		end;

	hide_filter_button is
			-- Make filter button invisible.
		do
			implementation.hide_filter_button
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			implementation.hide_help_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			implementation.hide_ok_button
		end;

	set_directory_selection is
			-- Sets selection to directories only.
		do
			implementation.set_directory_selection
	end;

    	set_file_selection is
        	    -- Sets selection to files (default value). 
        	do
            		implementation.set_file_selection
        	end;

    	set_all_selection is
        	    -- Sets selection to files and directories.
        	do
            		implementation.set_all_selection
        	end;


	
feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FILE_SELEC_I;
			-- Implementation of current file selection

	
feature 

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		do
			Result := implementation.is_dir_valid
		end;

	is_list_updated: BOOLEAN is
			-- Is file od directory list updated during last search?
		do
			Result := implementation.is_list_updated
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		do
			Result := implementation.pattern
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_cancel_action (a_command, argument)
		end;

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_filter_action (a_command, argument)
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_help_action (a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			not_a_command_void: not (a_command = Void)
		do
			implementation.remove_ok_action (a_command, argument)
		end;

	selected_file: STRING is
			-- Current selected file
		do
			Result := implementation.selected_file
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		do
			implementation.set_dir_list_label (a_label)
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
			-- to be displayed to `a_directory_name'.
		require
			not_a_directory_name_void: not (a_directory_name = Void)
		do
			implementation.set_directory (a_directory_name)
		end;

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		do
			implementation.set_file_list_label (a_label)
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		require
			not_a_filter_void: not (a_filter = Void)
		do
			implementation.set_filter (a_filter)
		end;

	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		do
			implementation.set_filter_label (a_label)
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		require
			not_a_pattern_void: not (a_pattern = Void)
		do
			implementation.set_pattern (a_pattern)
		end;

	show_cancel_button is
			-- Make cancel button visible.
		do
			implementation.show_cancel_button
		end;

	show_filter_button is
			-- Make filter button visible.
		do
			implementation.show_filter_button
		end;

	show_help_button is
			-- Make help button visible.
		do
			implementation.show_help_button
		end;

	show_ok_button is
			-- Make ok button visible.
		do
			implementation.show_ok_button
		end;

	hide_file_selection_list is
		do
			implementation.hide_file_selection_list;
		end;

	show_file_selection_list is
		do
			implementation.show_file_selection_list;
		end;


	hide_file_selection_label is
		do
			implementation.hide_file_selection_label;
		end;

	show_file_selection_label is
		do
			implementation.show_file_selection_label;
		end;

	set_file_list_width (new_width: INTEGER) is
		do
			implementation.set_file_list_width (new_width);
		end;

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
