indexing

	description:
		"EiffelVision Implementation of a Motif file selection box.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	FILE_SELEC_M 

inherit

	FILE_SELEC_I;

	TERMINAL_M
		undefine
			create_callback_struct, create_widget,
			default_button, cancel_button
		redefine
			make
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
			screen as mel_screen,
			dir_list as mel_dir_list,
			set_pattern as mel_set_pattern,
			pattern as mel_pattern,
			set_directory as mel_set_directory,
			directory as mel_directory
		select
			file_selection_make, make_no_auto_unmanage
		end

creation

	make

feature {NONE} -- Initialization

	make (a_file_selection: FILE_SELEC; man: BOOLEAN) is
			-- Create a motif file selection.
		do
			widget_index := widget_manager.last_inserted_position;
			file_selection_make (a_file_selection.identifier,
				mel_parent (a_file_selection, widget_index),
				man);
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
			ms.free
		end;
			
	filter: STRING is
			-- Current filter value
		local
			ms: MEL_STRING
		do
			ms := dir_mask;
			Result := dir_mask.to_eiffel_string;
			ms.free
		end;

	directory: STRING is
			-- Base directory used in determining files and directories
			-- to be displayed
		local
			ms: MEL_STRING
		do
			ms := mel_directory;
			Result := ms.to_eiffel_string;
			ms.free
		end;

	pattern: STRING is
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed
		local
			ms: MEL_STRING
		do
			ms := mel_pattern;
			Result := ms.to_eiffel_string;
			ms.free
		end;

feature -- Status setting

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_file_list_label_string (ms);
			ms.free
		end;

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_label);
			set_dir_list_label_string (ms);
			ms.free
		end;

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_filter);
			set_dir_mask (ms);
			ms.free
		end;

	set_directory (a_directory_name: STRING) is
			-- Set base directory used in determining files and directories
		   -- to be displayed to `a_directory_name'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_directory_name);
			mel_set_directory (ms);
			ms.free
		end;

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		local
			ms: MEL_STRING
		do
			!! ms.make_localized (a_pattern);
			mel_set_pattern (ms);
			ms.free
		end;

	set_filter_label (a_label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		local
			ms: MEL_STRING
        do
            !! ms.make_localized (a_label);
            set_filter_label_string (ms);
            ms.free
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
			list.scrolled_window.unmanage
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
			list.scrolled_window.manage
		end;
		
feature -- Element change

	add_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			add_cancel_callback (mel_vision_callback (a_command), argument)
		end;

	add_filter_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		do
			add_apply_callback (mel_vision_callback (a_command), argument)
		end;

	add_help_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		do
			add_help_callback (mel_vision_callback (a_command), argument)
		end;

	add_ok_action (a_command: COMMAND; argument: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			add_ok_callback (mel_vision_callback (a_command), argument)
		end;

feature -- Removal

	remove_cancel_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			remove_cancel_callback (mel_vision_callback (a_command), argument)
		end; 

	remove_filter_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		do
			remove_apply_callback (mel_vision_callback (a_command), argument)
		end; 

	remove_help_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
			remove_help_callback (mel_vision_callback (a_command), argument)
		end; 

	remove_ok_action (a_command: COMMAND; argument: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			remove_ok_callback (mel_vision_callback (a_command), argument)
		end;

feature {NONE} -- Implementation

	update_other_bg_color (pixel: POINTER) is
		do
			--xm_set_children_bg_color (pixel, screen_object);
		end;

	update_other_fg_color (pixel: POINTER) is
		do
			--xm_set_children_fg_color (pixel, screen_object);
		end;

	update_text_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_TEXT),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_LIST),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_FILTER_TEXT),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_DIR_LIST),
						--f_ptr);
		end;

	update_label_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_DIR_LIST_LABEL),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_LIST_LABEL),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_FILTER_LABEL),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_SELECTION_LABEL),
						--f_ptr);
		end;

	update_button_font (f_ptr: POINTER) is
		do
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_APPLY_BUTTON),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_CANCEL_BUTTON),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_DEFAULT_BUTTON),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_HELP_BUTTON),
						--f_ptr);
			--set_primitive_font (xm_file_selection_box_get_child 
						--(screen_object, MDIALOG_OK_BUTTON),
						--f_ptr);
		end;


end -- class FILE_SELEC_M

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
