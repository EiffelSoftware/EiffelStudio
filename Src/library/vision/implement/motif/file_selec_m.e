
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FILE_SELEC_M 

inherit

	FILE_SELEC_I
		export
			{NONE} all
		end;

	PROMPT_R_M
		export
			{NONE} all
		end;

	FILE_SELEC_R_M
		export
			{NONE} all
		end;

	TERMINAL_M
		undefine
			make
		end

creation

	make

feature -- Creation

	make (a_file_selection: FILE_SELEC) is
			-- Create a motif file selection.
		local
			ext_name: ANY
		do
			ext_name := a_file_selection.identifier.to_c;
			screen_object := create_file_selection ($ext_name,
			   a_file_selection.parent.implementation.screen_object)
		end;

feature {NONE}

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (cancel_actions = Void) then
				!! cancel_actions.make (screen_object, Mcancel,
						widget_oui)
			end;
			cancel_actions.add (a_command, argument)
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (filter_actions = Void) then
				!! filter_actions.make (screen_object, Mapply,
						widget_oui)
			end;
			filter_actions.add (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (help_actions = Void) then
				!! help_actions.make (screen_object, Mhelp,
						widget_oui)
			end;
			help_actions.add (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			if (ok_actions = Void) then
				!! ok_actions.make (screen_object, Mok, widget_oui)
			end;
			ok_actions.add (a_command, argument)
		end;

	cancel_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when cancel button
			-- is activated

feature

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		require else
			a_label_not_void: not (a_label = Void)
		local
			ext_name_label, ext_name: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MfileListlabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label, $ext_name)
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		require else
			a_label_not_void: not (a_label = Void)
		local
			ext_name_label, ext_name: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MdirListlabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label, $ext_name)
		end;

	selected_file: STRING is
			-- Current selected file
		local
			ext_name: ANY
		do
			ext_name := MdirSpec.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

			
	filter: STRING is
			-- Current filter value
		local
			ext_name: ANY
		do
			ext_name := MdirMask.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		require else
			not_a_filter_void: not (a_filter = Void)
		local
			ext_name, ext_name_filter: ANY
		do
			ext_name := MdirMask.to_c;
			ext_name_filter := a_filter.to_c;
			to_left_xm_string (screen_object, $ext_name_filter, $ext_name)
		end;

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		local
			ext_name: ANY
		do
			ext_name := MdirectoryValid.to_c;
			Result := get_boolean (screen_object, $ext_name)
		end;

	is_list_updated: BOOLEAN is
			-- Is file od directory list updated during last search?
		local
			ext_name: ANY
		do
			ext_name := MlistUpdated.to_c;
			Result := get_boolean (screen_object, $ext_name)
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		local
			ext_name: ANY
		do
			ext_name := Mdirectory.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
		   -- to be displayed to `a_directory_name'.
		require else
			not_a_directory_name_void: not (a_directory_name = Void)
		local
			ext_name, ext_name_dir: ANY
		do
			ext_name_dir := a_directory_name.to_c;
			ext_name := Mdirectory.to_c;
			to_left_xm_string (screen_object, $ext_name_dir, $ext_name)
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		local
			ext_name: ANY
		do
			ext_name := Mpattern.to_c;
			Result := from_xm_string (screen_object, $ext_name)
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		require else
			not_a_pattern_void: not (a_pattern = Void)
		local
			ext_name, ext_name_pattern: ANY
		do
			ext_name := Mpattern.to_c;
			ext_name_pattern := a_pattern.to_c;
			to_left_xm_string (screen_object, $ext_name_pattern, $ext_name)
		end;

	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		require else
			not_a_label_void: not (a_label = Void)
		local
			ext_name_label, ext_name: ANY
		do
			ext_name_label := a_label.to_c;
			ext_name := MfilterLabelString.to_c;
			to_left_xm_string (screen_object, $ext_name_label, $ext_name)
		end;

	file_list: LINKED_LIST [STRING] is
			-- Items of current file list
		local
			xt_table: POINTER;
			current_position: INTEGER;
			last_position: INTEGER;
			ext_name: ANY
		do
			from
				!! Result.make;
				ext_name := MfileListItems.to_c;
				xt_table := get_xmstring_tab (screen_object, $ext_name);
				current_position := 1;
				last_position := file_count + 1
			until
				current_position = last_position
			loop
				Result.put_left (get_i_th_table (xt_table,
												current_position));
				current_position := current_position + 1
			end
		end;

	dir_list: LINKED_LIST [STRING] is
			-- Items of current directory list
		local
			xt_table: POINTER;
			current_position: INTEGER;
			last_position: INTEGER;
			ext_name: ANY
		do
			from
				!! Result.make;
				ext_name := MdirListItems.to_c;
				xt_table := get_xmstring_tab (screen_object, $ext_name);
				current_position := 1;
				last_position := dir_count + 1
			until
				current_position = last_position
			loop
				Result.put_left (get_i_th_table (xt_table,
												current_position));
				current_position := current_position + 1
			end
		end;

	dir_count: INTEGER is
			-- Number of items in directory list
		local
			ext_name: ANY	
		do
			ext_name := MdirListItemCount.to_c;
			Result := get_int (screen_object, $ext_name)
		end;

	file_count: INTEGER is
			-- Number of items in file list
		local
			ext_name: ANY
		do
			ext_name := MfileListItemCount.to_c;
			Result := get_int (screen_object, $ext_name)
		end;

feature {NONE}

	filter_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when filter button
			-- is activated

	help_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when help button
			-- is activated

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			xt_unmanage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end; -- hide_cancel_button

	hide_filter_button is
			-- Make filter button invisible.
		do
			xt_unmanage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_APPLY_BUTTON))
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			xt_unmanage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_HELP_BUTTON))
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			xt_unmanage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end;

	ok_actions: EVENT_HAND_M;
			-- An event handler to manage call-backs when ok button
			-- is activated

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			cancel_actions.remove (a_command, argument)
		end; -- remove_cancel_action

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			filter_actions.remove (a_command, argument)
		end; -- remove_filter_action

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			help_actions.remove (a_command, argument)
		end; -- remove_help_action

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		require else
			not_a_command_void: not (a_command = Void)
		do
			ok_actions.remove (a_command, argument)
		end; -- remove_ok_action

	show_cancel_button is
			-- Make cancel button visible.
		do
			xt_manage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_CANCEL_BUTTON))
		end; -- show_cancel_button

	show_filter_button is
			-- Make filter button visible.
		do
			xt_manage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_APPLY_BUTTON))
		end; -- show_filter_button

	show_help_button is
			-- Make help button visible.
		do
			xt_manage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_HELP_BUTTON))
		end; -- show_help_button

	show_ok_button is
			-- Make ok button visible.
		do
			xt_manage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_OK_BUTTON))
		end

feature
	set_file_list_width (new_width: INTEGER) is
		require else
			width_large_enough: new_width >= 1;
		local
			ext_name_Mw: ANY
		do
			ext_name_Mw := Mwidth.to_c;
			set_dimension (xm_file_selection_box_get_child (screen_object, MDIALOG_LIST), new_width, $ext_name_Mw)
		end;


	hide_file_selection_list is
		do
			xt_unmanage_child (xt_parent (xm_file_selection_box_get_child (screen_object, MDIALOG_LIST)));
		end;

	hide_file_selection_label is
		do
			xt_unmanage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_LIST_LABEL));
		end;
			

	show_file_selection_label is
		do
			xt_manage_child (xm_file_selection_box_get_child (screen_object, MDIALOG_LIST_LABEL));
		end;

	show_file_selection_list is
		do
			xt_manage_child (xt_parent (xm_file_selection_box_get_child (screen_object, MDIALOG_LIST)));
		end;
		

	set_directory_selection is
            -- Sets selection to directories only.
		do
			set_xt_unsigned_char (screen_object, 1, MfileTypeMask)
		end;

	set_file_selection is
			-- Sets selection to files (default value). 
		do
			set_xt_unsigned_char (screen_object, 2, MfileTypeMask)
		end;

	set_all_selection is
		 -- Sets selection to files and directories.
		do
			 set_xt_unsigned_char (screen_object, 3, MfileTypeMask)
		end;

	
feature {NONE}

	filter_button: POINTER is
		do
			Result := xm_file_selection_box_get_child (screen_object, MDIALOG_APPLY_BUTTON);
		end;

feature {NONE} -- External features

	create_file_selection (s_name: ANY; scr_obj: POINTER): POINTER is
		external
			"C"
		end;

	xm_file_selection_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER is
		external
			"C"
		end;

	to_left_xm_string (scr_obj: POINTER; name1, name2: ANY) is
		external
			"C"
		end;

	get_i_th_table (table: POINTER; value2: INTEGER): STRING is
		external
			"C"
		end;

	get_xmstring_tab (scr_obj: POINTER; name: ANY): POINTER is
		external
			"C"
		end;

	from_xm_string (scr_obj: POINTER; name: ANY): STRING is
		external
			"C"
		end;
end



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
