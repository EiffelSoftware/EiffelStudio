indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	FILE_SELEC 

inherit

	TERMINAL_OUI
		redefine
			make, make_unmanaged, create_ev_widget,
			implementation
		end

creation

	make, make_unmanaged
	
feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a selection list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, True)
		end;

	make_unmanaged (a_name: STRING; a_parent: COMPOSITE) is
			-- Create an unmanaged selection list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			create_ev_widget (a_name, a_parent, False)
		end;

	create_ev_widget (a_name: STRING; a_parent: COMPOSITE; man: BOOLEAN) is
			-- Create a selection list with `a_name' as identifier,
			-- `a_parent' as parent and call `set_default'.
		do
			depth := a_parent.depth+1;
			widget_manager.new (Current, a_parent);
			identifier:= clone (a_name);
			!FILE_SELEC_IMP! implementation.make (Current, man, a_parent);
			set_default
		end;

feature -- Element change

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_cancel_action (a_command, argument)
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_filter_action (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_help_action (a_command, argument)
		end; 

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.add_ok_action (a_command, argument)
		end; 

	dir_count: INTEGER is
			-- Number of items in directory list
		require
			exists: not destroyed
		do
			Result := implementation.dir_count
		end;

	dir_list: LINKED_LIST [STRING] is
			-- Items of current directory list
		require
			exists: not destroyed
		do
			Result := implementation.dir_list
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		require
			exists: not destroyed
		do
			Result := implementation.directory
		end;

	file_count: INTEGER is
			-- Number of items in file list
		require
			exists: not destroyed
		do
			Result := implementation.file_count
		end;

	file_list: LINKED_LIST [STRING] is
			-- Items of current file list
		require
			exists: not destroyed
		do
			Result := implementation.file_list
		end;

	filter: STRING is
			-- Current filter value
		require
			exists: not destroyed
		do
			Result := implementation.filter
		end;

	hide_cancel_button is
			-- Make cancel button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_cancel_button
		end;

	hide_filter_button is
			-- Make filter button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_filter_button
		end;

	hide_help_button is
			-- Make help button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_help_button
		end;

	hide_ok_button is
			-- Make ok button invisible.
		require
			exists: not destroyed
		do
			implementation.hide_ok_button
		end;

	set_directory_selection is
			-- Sets selection to directories only.
		require
			exists: not destroyed
		do
			implementation.set_directory_selection
		end;

   	set_file_selection is
	   		-- Sets selection to files (default value). 
		require
			exists: not destroyed
	   	do
   			implementation.set_file_selection
	   	end;

   	set_all_selection is
	   		-- Sets selection to files and directories.
		require
			exists: not destroyed
	   	do
	 		implementation.set_all_selection
	   	end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT}

	implementation: FILE_SELEC_I;
			-- Implementation of current file selection
	
feature 

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		require
			exists: not destroyed
		do
			Result := implementation.is_dir_valid
		end;

	is_list_updated: BOOLEAN is
			-- Is file od directory list updated during last search?
		require
			exists: not destroyed
		do
			Result := implementation.is_list_updated
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		require
			exists: not destroyed
		do
			Result := implementation.pattern
		end;

	pattern_name: STRING is
			-- Name of the search pattern
		require
			exists: not destroyed
		do
			Result := implementation.pattern_name
		end;

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_cancel_action (a_command, argument)
		end;

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_filter_action (a_command, argument)
		end;

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_help_action (a_command, argument)
		end;

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require
			exists: not destroyed;
			valid_command: a_command /= Void
		do
			implementation.remove_ok_action (a_command, argument)
		end;

	selected_file: STRING is
			-- Current selected file
		require
			exists: not destroyed;
		do
			Result := implementation.selected_file
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		require
			exists: not destroyed;
		do
			implementation.set_dir_list_label (a_label)
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
			-- to be displayed to `a_directory_name'.
		require
			exists: not destroyed;
			not_a_directory_name_void: a_directory_name /= Void
		do
			implementation.set_directory (a_directory_name)
		end;

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		require
			exists: not destroyed;
			valid_a_label: a_label /= Void
		do
			implementation.set_file_list_label (a_label)
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		require
			exists: not destroyed;
			not_a_filter_void: a_filter /= Void
		do
			implementation.set_filter (a_filter)
		end;

	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		require
			exists: not destroyed;
			valid_a_label: a_label /= Void
		do
			implementation.set_filter_label (a_label)
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		require
			exists: not destroyed;
			not_a_pattern_void: a_pattern /= Void
		do
			implementation.set_pattern (a_pattern)
		end;

	set_pattern_name (a_name: STRING) is
			-- Give `a_name' to a pattern.
		require
			exists: not destroyed
			not_a_name_void: a_name /= Void
		do
			implementation.set_pattern_name (a_name)
		end

	show_cancel_button is
			-- Make cancel button visible.
		require
			exists: not destroyed
		do
			implementation.show_cancel_button
		end;

	show_filter_button is
			-- Make filter button visible.
		require
			exists: not destroyed
		do
			implementation.show_filter_button
		end;

	show_help_button is
			-- Make help button visible.
		require
			exists: not destroyed
		do
			implementation.show_help_button
		end;

	show_ok_button is
			-- Make ok button visible.
		require
			exists: not destroyed
		do
			implementation.show_ok_button
		end;

	hide_file_selection_list is
		require
			exists: not destroyed
		do
			implementation.hide_file_selection_list;
		end;

	show_file_selection_list is
		require
			exists: not destroyed
		do
			implementation.show_file_selection_list;
		end;

	hide_file_selection_label is
		require
			exists: not destroyed
		do
			implementation.hide_file_selection_label;
		end;

	show_file_selection_label is
		require
			exists: not destroyed
		do
			implementation.show_file_selection_label;
		end;

	set_file_list_width (new_width: INTEGER) is
		require
			exists: not destroyed;
			width_large_enough: new_width >= 1;
		do
			implementation.set_file_list_width (new_width);
		end;

end




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

