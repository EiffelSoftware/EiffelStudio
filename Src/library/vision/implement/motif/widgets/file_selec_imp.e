indexing

	description:
		"EiffelVision Implementation of a Motif file selection box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FILE_SELEC_IMP

inherit

	FILE_SELEC_I;

	TERMINAL_IMP
		rename
			set_background_color_from_imp as 
			old_set_background_color_from_imp,
			text_widget_list as old_text_widget_list
		undefine
			create_callback_struct, create_widget,
			default_button, cancel_button,
			set_foreground_color_from_imp
		redefine
			make
		end;

	TERMINAL_IMP
		undefine
			create_callback_struct, create_widget,
			default_button, cancel_button
		redefine
			make, set_foreground_color_from_imp,
			set_background_color_from_imp, text_widget_list
		select
			set_background_color_from_imp, text_widget_list
		end;

	MEL_FILE_SELECTION_BOX
		rename
			make as file_selection_make,
			foreground_color as mel_foreground_color,
			set_foreground_color as mel_set_foreground_color,
			background_color as mel_background_color,
			background_pixmap as mel_background_pixmap,
			set_background_color as mel_set_background_color,
			set_background_pixmap as mel_set_background_pixmap,
			destroy as mel_destroy,
			set_insensitive as mel_set_insensitive,
			screen as mel_screen,
			dir_list as mel_dir_list,
			set_pattern as mel_set_pattern,
			pattern as mel_pattern,
			set_directory as mel_set_directory,
			directory as mel_directory,
			is_shown as shown
		select
			file_selection_make, make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_file_selection: FILE_SELEC; man: BOOLEAN; oui_parent: COMPOSITE) is
			-- Create a motif file selection.
		local
			mc: MEL_COMPOSITE
		do
			mc ?= oui_parent.implementation;
			widget_index := widget_manager.last_inserted_position;
			file_selection_make (a_file_selection.identifier, mc, man);
		end;

feature -- Access

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		do
			Result := directory_valid
		end;

	file_list: LINKED_LIST [STRING] is
			-- Items of current file list
		local
			c, i: INTEGER;
			mel_table: MEL_STRING_TABLE;
			ms: MEL_STRING
		do
			!! Result.make;
			c := file_count;
			if c > 0 then
				mel_table := file_list_items
				from
					i := 1;
				until
					i > c
				loop
					ms := mel_table.item (i);
					Result.extend (ms.to_eiffel_string);
					i := i + 1
				end;
			end
		end;

	dir_list: LINKED_LIST [STRING] is
			-- Items of current directory list
		local
			c, i: INTEGER;
			mel_table: MEL_STRING_TABLE;
			ms: MEL_STRING
		do
			!! Result.make;
			c := dir_count;
			if c > 0 then
				from
					mel_table := dir_list_items;
					Result.start;
					i := 1;
				until
					i > c
				loop
					ms := mel_table.item (i);
					Result.put_left (ms.to_eiffel_string);
					i := i + 1
				end;
			end
		end;

	dir_count: INTEGER is
			-- Number of items in directory list
		do
			Result := dir_list_item_count
		end;

	file_count: INTEGER is
			-- Number of items in file list
		do
			Result := file_list_item_count
		end;

feature -- Status report

	selected_file: STRING is
			-- Current selected file
		local
			ms: MEL_STRING
		do
			ms := dir_spec;
			Result := dir_spec.to_eiffel_string;
			ms.destroy
		end;
			
	filter: STRING is
			-- Current filter value
		local
			ms: MEL_STRING
		do
			ms := dir_mask;
			Result := dir_mask.to_eiffel_string;
			ms.destroy
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		local
			ms: MEL_STRING
		do
			ms := mel_directory;
			Result := ms.to_eiffel_string;
			ms.destroy
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		local
			ms: MEL_STRING
		do
			ms := mel_pattern;
			Result := ms.to_eiffel_string;
			ms.destroy
		end;
        
	pattern_name: STRING
			-- Name of the search pattern.


feature -- Status setting

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_file_list_label_string (ms);
			ms.destroy
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_dir_list_label_string (ms);
			ms.destroy
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_filter);
			set_dir_mask (ms);
			ms.destroy
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
		   -- to be displayed to `a_directory_name'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_directory_name);
			mel_set_directory (ms);
			ms.destroy
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_pattern);
			mel_set_pattern (ms);
			ms.destroy
		end;

	set_pattern_name (a_pattern_name: STRING) is
			-- Set pattern_name to `a_pattern'.
		do 
			pattern_name := a_pattern_name
		end


	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		local
			ms: MEL_STRING
		do
			!! ms.make_default_l_to_r (a_label);
			set_filter_label_string (ms);
			ms.destroy
		end;

	set_directory_selection is
			-- Sets selection to directories only.
		do
			use_file_directory_mask
		end;

	set_file_selection is
			-- Sets selection to files (default value). 
		do
			use_file_regular_mask
		end;

	set_all_selection is
		 	-- Sets selection to files and directories.
		do
			use_file_any_type_mask
		end;

	set_file_list_width (new_width: INTEGER) is
			-- Set `file_list' widget to `new_width'.
		do
			list.set_width (new_width)	
		end;

feature -- Display

	hide_cancel_button is
			-- Make cancel button invisible.
		do
			cancel_button.unmanage
		end; 

	hide_filter_button is
			-- Make filter button invisible.
		do
			apply_button.unmanage
		end;

	hide_help_button is
			-- Make help button invisible.
		do
			help_button.unmanage
		end;

	hide_ok_button is
			-- Make ok button invisible.
		do
			ok_button.unmanage
		end;

	hide_file_selection_list is
		do
			list.parent.unmanage
		end;

	hide_file_selection_label is
		do
			list_label.unmanage
		end;
			
	show_cancel_button is
			-- Make cancel button visible.
		do
			cancel_button.manage
		end;

	show_filter_button is
			-- Make filter button visible.
		do
			apply_button.manage
		end; 

	show_help_button is
			-- Make help button visible.
		do
			help_button.manage
		end; 

	show_ok_button is
			-- Make ok button visible.
		do
			ok_button.manage
		end;

	show_file_selection_label is
		do
			list_label.manage
		end;

	show_file_selection_list is
		do
			list.parent.manage
		end;
		
feature -- Element change

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		local
			a_list: VISION_COMMAND_LIST
		do
			a_list := vision_command_list (cancel_command);
			if a_list = Void then
				!! a_list.make;
				set_cancel_callback (a_list, Void)
			end;
			a_list.add_command (a_command, argument)
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		local
			a_list: VISION_COMMAND_LIST
		do
			a_list := vision_command_list (apply_command);
			if a_list = Void then
				!! a_list.make;
				set_apply_callback (a_list, Void)
			end;
			a_list.add_command (a_command, argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		local
			a_list: VISION_COMMAND_LIST
		do
			a_list := vision_command_list (help_command);
			if a_list = Void then
				!! a_list.make;
				set_help_callback (a_list, Void)
			end;
			a_list.add_command (a_command, argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		local
			a_list: VISION_COMMAND_LIST
		do
			a_list := vision_command_list (ok_command);
			if a_list = Void then
				!! a_list.make;
				set_ok_callback (a_list, Void)
			end;
			a_list.add_command (a_command, argument)
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			remove_command (cancel_command, a_command, argument)
		end; 

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		do
			remove_command (apply_command, a_command, argument)
		end; 

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
			remove_command (help_command, a_command, argument)
		end; 

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			remove_command (ok_command, a_command, argument)
		end;

feature {NONE} -- Implementation

	set_foreground_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		do
			mel_set_foreground_color (color_imp);
			text.set_foreground_color (color_imp);
			list.set_foreground_color (color_imp);
			filter_text.set_foreground_color (color_imp);
			mel_dir_list.set_foreground_color (color_imp);
		end;

	set_background_color_from_imp (color_imp: COLOR_IMP) is
			-- Set the background color from implementation `color_imp'.
		local
			l: ARRAYED_LIST [POINTER];
			color_id: POINTER
		do
			old_set_background_color_from_imp (color_imp);
			!! l.make (6);
			l.append (list.parent.children);
			l.append (mel_dir_list.parent.children);
			color_id := color_imp.identifier;
			from
				l.start
			until
				l.after
			loop
				xm_change_color (l.item, color_id);
				l.forth
			end
		end;

	text_widget_list: LINKED_LIST [POINTER] is
			-- Text list includes the two directory list
		do
			Result := old_text_widget_list;
			Result.extend (list.screen_object);
			Result.extend (mel_dir_list.screen_object);
		end;

end -- class FILE_SELEC_IMP


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

