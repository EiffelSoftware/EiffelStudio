indexing

	description:
			"Widget for selecting files.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FILE_SELECTION_BOX

inherit

	MEL_FILE_SELECTION_BOX_RESOURCES
		export
			{NONE} all
		end;

	MEL_SELECTION_BOX
		redefine
			create_callback_struct, create_widget
		end

creation
	make,
	make_from_existing

feature {NONE} -- Initialization

	create_widget (p_so: POINTER; w_name: ANY; auto_manage_flag: BOOLEAN) is
			-- Create file selection box with `auto_manage_flag'.
		do
			if auto_manage_flag then
				screen_object :=
					xm_create_file_selection_box (p_so,
						$w_name, default_pointer, 0)
			else
				screen_object :=
					xm_create_file_selection_box (p_so,
						$w_name, auto_unmanage_arg, 1)
			end;
		end;

feature -- Access

	dir_list: MEL_SCROLLED_LIST is
			-- Directory list
		local
			w: POINTER
		do
			w := xm_file_selection_box_get_child (screen_object, XmDIALOG_DIR_LIST);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	dir_list_label: MEL_LABEL_GADGET is
			-- Label of `dir_list'
		local
			w: POINTER
		do
			w := xm_file_selection_box_get_child (screen_object, XmDIALOG_DIR_LIST_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	filter_label: MEL_LABEL_GADGET is
			-- Label of `filter_text'
		local
			w: POINTER
		do
			w := xm_file_selection_box_get_child (screen_object, XmDIALOG_FILTER_LABEL);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

	filter_text: MEL_TEXT_FIELD is
			-- Filter text field
		local
			w: POINTER
		do
			w := xm_file_selection_box_get_child (screen_object, XmDIALOG_FILTER_TEXT);
			if w /= default_pointer then
				Result ?= Mel_widgets.item (w);
				if Result = Void then
					!! Result.make_from_existing (w, Current)
				end
			end
		end;

feature -- Status report

	directory: MEL_STRING is
			-- The base directory that, in combination with `pattern', forms the directory mask.
			-- The directory mask determines which files and directories to display.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNdirectory)
		ensure
			directory_exists: Result /= Void and then not Result.is_destroyed
		end;

	directory_valid: BOOLEAN is
			-- Is the directory passed to `dir_search_proc' valid?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNdirectoryValid)
		end;

	dir_list_items: MEL_STRING_TABLE is
			-- Items from `dir_list'
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing (get_xm_string_table 
						(screen_object, XmNdirListItems), dir_list_item_count)
		ensure
			dir_list_items_not_void: Result /= Void
		end;

	dir_list_item_count: INTEGER is
			-- Number of items in `dir_list_items'
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNdirListItemCount)
		ensure
			dir_list_item_count_large_enough: Result >= 0
		end;

	dir_list_label_string: MEL_STRING is
			-- Label of the `dir_list'
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNdirListLabelString)
		ensure
			dir_list_label_string_not_void: Result /= Void
		end;

	dir_mask: MEL_STRING is
			-- Directory mask that determines which files and
			-- directories to display
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNdirMask)
		ensure
			dir_mask_created: Result /= void
		end;

	dir_search_proc is
			-- Procedure that performs directory searches.
			-- (Does nothing by default.)
		require
			exists: not is_destroyed
		do
		end;

	dir_spec: MEL_STRING is
			-- Complete specification of the file path
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNdirSpec)
		ensure
			dir_spec_not_void: Result /= Void and then not Result.is_destroyed
		end;

	file_list_items: MEL_STRING_TABLE is
			-- Items in the file list
		require
			exists: not is_destroyed
		do
			!! Result.make_from_existing (get_xm_string_table 
						(screen_object, XmNfileListItems), file_list_item_count)
		ensure
			file_list_items_not_void: Result /= Void
		end;

	file_list_item_count: INTEGER is
			-- Number of items in `file_list_items'
		require
			exists: not is_destroyed
		do
			Result := get_xt_int (screen_object, XmNfileListItemCount)
		ensure
			file_list_item_count_large_enough: Result >= 0
		end;

	file_list_label_string: MEL_STRING is
			-- Label of the file list
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNfileListLabelString)
		ensure
			file_list_label_string_not_void: Result /= Void
		end;

	is_file_directory_mask_used: BOOLEAN is
			-- Does the file list display only directories?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNfileTypeMask) = XmFILE_DIRECTORY
		end;

	is_file_regular_mask_used: BOOLEAN is
			-- Does the file list display only regular files?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNfileTypeMask) = XmFILE_REGULAR
		end;

	is_file_any_type_mask_used: BOOLEAN is
			-- Does the file list display all files?
		require
			exists: not is_destroyed
		do
			Result := get_xt_unsigned_char (screen_object, XmNfileTypeMask) = XmFILE_ANY_TYPE
		end;

	filter_label_string: MEL_STRING is
			-- Label of the field in which the directory mask is typed by the user.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNfilterLabelString)
		ensure
			filter_label_string_not_void: Result /= Void
		end;

	is_list_updated: BOOLEAN is
			-- Was the directory or file list updated after the last search?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNlistUpdated)
		end;

	no_match_string: MEL_STRING is
			-- String that is to be displayed in the file list when there
			-- are no filenames to display.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNnoMatchString)
		ensure
			no_match_string_exists: Result /= Void and then not Result.is_destroyed
		end;

	pattern: MEL_STRING is
			-- File search pattern that, in combination with `directory', forms `dir_mask'.
		require
			exists: not is_destroyed
		do
			Result := get_xm_string (screen_object, XmNpattern)
		ensure
			pattern_not_void: Result /= Void
		end;

	qualify_search_data_proc is
			-- Procedure that generates a valid `dir_mask', `directory', and `pattern'
			-- to be used by the search feature.
			-- (Does nothing by default.)
		require
			exists: not is_destroyed
		do
		ensure
		end;

feature -- Status setting

	set_directory (a_compound_string: MEL_STRING) is
			-- Set `directory' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNdirectory, a_compound_string)
		ensure
			-- directory_set: directory.is_equal (a_compound_string)
		end;

	validate_directory is
			-- Set `directory_valid' according to the result of `dir_search_proc'.
		require
			exists: not is_destroyed
		do
				-- FIX ME: ******************************
				-- Should somehow call `dir_search_proc'.

			set_xt_boolean (screen_object, XmNdirectoryValid, True)
		ensure
			directory_validated: directory_valid
		end;

	set_dir_list_items (a_list: MEL_STRING_TABLE) is
			-- Set `dir_list_items' to `a_list'.
		require
			exists: not is_destroyed;
			a_list_exists: a_list /= Void and then not a_list.is_destroyed
		do
			set_xm_string_table (screen_object, XmNdirListItems, a_list.handle)
		ensure
			dir_list_items_set: dir_list_items.is_equal (a_list)
		end;

	set_dir_list_item_count (a_count: INTEGER) is
			-- Set `dir_list_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNdirListItemCount, a_count)
		ensure
			dir_list_item_count_set: dir_list_item_count = a_count
		end;

	set_dir_list_label_string (a_compound_string: MEL_STRING) is
			-- Set `dir_list_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then
										not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNdirListLabelString, a_compound_string)
		ensure
			dir_list_label_string_set: dir_list_label_string.is_equal (a_compound_string)
		end;

	set_dir_mask (a_compound_string: MEL_STRING) is
			-- Set `dir_mask' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then
										not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNdirMask, a_compound_string)
		ensure
			-- dir_mask_set: dir_mask.is_equal (a_compound_string)
		end;

	set_dir_search_proc is
			-- Set `dir_search_proc'.
		require
			exists: not is_destroyed
		do
		end;

	set_dir_spec (a_compound_string: MEL_STRING) is
			-- Set `dir_spec' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then
										not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNdirSpec, a_compound_string)
		ensure
			dir_spec_set: dir_spec.is_equal (a_compound_string)
		end;

	set_file_list_items (a_list: MEL_STRING_TABLE) is
			-- Set `file_list_items' to `a_list'.
		require
			exists: not is_destroyed;
			a_list_exists: a_list /= Void and then not a_list.is_destroyed
		do
			set_xm_string_table (screen_object, XmNfileListItems, a_list.handle)
		ensure
			file_list_items_set: file_list_items.is_equal (a_list)
		end;

	set_file_list_item_count (a_count: INTEGER) is
			-- Set `file_list_item_count' to `a_count'.
		require
			exists: not is_destroyed;
			a_count_large_enough: a_count >= 0
		do
			set_xt_int (screen_object, XmNfileListItemCount, a_count)
		ensure
			file_list_item_count_set: file_list_item_count = a_count
		end;

	set_file_list_label_string (a_compound_string: MEL_STRING) is
			-- Set `file_list_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then
										not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNfileListLabelString, a_compound_string)
		ensure
			file_list_label_string_set: file_list_label_string.is_equal (a_compound_string)
		end;

	use_file_directory_mask is
			-- The list file will display only directories.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNfileTypeMask, XmFILE_DIRECTORY)
		ensure
			file_directory_mask_used: is_file_directory_mask_used
		end;

	use_file_regular_mask is
			-- The list file will display only regular files.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNfileTypeMask, XmFILE_REGULAR)
		ensure
			file_regular_mask_used: is_file_regular_mask_used
		end;

	use_file_any_type_mask is
			-- The list file will display all files.
		require
			exists: not is_destroyed
		do
			set_xt_unsigned_char (screen_object, XmNfileTypeMask, XmFILE_ANY_TYPE)
		ensure
			file_any_type_mask_used: is_file_any_type_mask_used
		end;

	set_filter_label_string (a_compound_string: MEL_STRING) is
			-- Set `filter_label_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			valid_a_compound_string: a_compound_string /= Void and then
										not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNfilterLabelString, a_compound_string)
		ensure
			filter_label_string_set: filter_label_string.is_equal (a_compound_string)
		end;

	set_list_updated is
			-- Set `list_updated' to True.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNlistUpdated, True)
		ensure
			list_is_updated: is_list_updated 
		end;

	unset_list_updated is
			-- Set `list_updated' to False.
		require
			exists: not is_destroyed
		do
			set_xt_boolean (screen_object, XmNlistUpdated, False)
		ensure
			list_is_not_updated: not is_list_updated 
		end;

	set_no_match_string (a_compound_string: MEL_STRING) is
			-- Set `no_match_string' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNnoMatchString, a_compound_string)
		ensure
			no_match_string_set: no_match_string.is_equal (a_compound_string)
		end;

	set_pattern (a_compound_string: MEL_STRING) is
			-- Set `pattern' to `a_compound_string'.
		require
			exists: not is_destroyed;
			a_compound_string_exists: a_compound_string /= Void and then not a_compound_string.is_destroyed
		do
			set_xm_string (screen_object, XmNpattern, a_compound_string)
		ensure
			pattern_set: pattern.is_equal (a_compound_string)
		end;

	set_qualify_search_data_proc is
			-- Set `qualify_search_data_proc'.
			-- (Does nothing by default.)
		require
			exists: not is_destroyed
		do
		end;

feature {MEL_DISPATCHER} -- Basic operations

	create_callback_struct (a_callback_struct_ptr, 
				resource_name: POINTER): MEL_ANY_CALLBACK_STRUCT is
			-- Create the callback structure specific to this widget
			-- according to `a_callback_struct_ptr'.
		do
			if resource_name = XmNokCallback or else
				resource_name = XmNcancelCallback or else
				resource_name = XmNnoMatchCallback or else
				resource_name = XmNapplyCallback
			then
				!MEL_FILE_SELECTION_BOX_CALLBACK_STRUCT! Result.make (Current, a_callback_struct_ptr);
			else
				!! Result.make (Current, a_callback_struct_ptr);
			end
		end;

feature -- Implementation

	xm_create_file_selection_box (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C (Widget, String, ArgList, Cardinal): EIF_POINTER | <Xm/FileSB.h>"
		alias
			"XmCreateFileSelectionBox"
		end;

	xm_file_selection_box_get_child (scr_obj: POINTER; value: INTEGER): POINTER is
		external
			"C (Widget, unsigned char): EIF_POINTER | <Xm/FileSB.h>"
		alias
			"XmFileSelectionBoxGetChild"
		end;

end -- class MEL_FILE_SELECTION_BOX


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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

