indexing
	description: "Dialog box which can select directories."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	DIRECTORY_SELECTION_DIALOG_WINDOWS

inherit
	G_ANY_IMP

	EXECUTION_ENVIRONMENT

	WEL_CBN_CONSTANTS

	WEL_LBN_CONSTANTS
	
	WEL_DDL_CONSTANTS

	WEL_MODAL_DIALOG
		redefine
			notify,
			setup_dialog,
			on_cancel,
			on_ok,
			class_name
		end

creation
	make

feature -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW; a_widget: FILE_SEL_D_IMP) is
			-- Create the directory selection dialog
		do
			make_by_id (a_parent, directory_dialog_id)
			!! selection_text.make_by_id (Current, selection_text_id)
			!! combo_box.make_by_id (Current, combo_box_id)
			!! directory_list.make_by_id (Current, directory_list_id)
			!! drive_list.make_by_id (Current, drive_list_id)
			!! ok_button.make_by_id (Current, idok)
			!! cancel_button.make_by_id (Current, idcancel)
			action_widget := a_widget
		end

feature {NONE} -- Initialization

	setup_dialog is
			-- Initialize the dialog.
		local
			pos: INTEGER
		do
			set_title (private_title)
			if search_directory /= Void and then not search_directory.empty then
				add_to_recently_used (search_directory)
				if directories_list = Void then
					directories_list := get ("DirectoryList")
				end
				fill_recently_used
				directory := search_directory
			else
				directories_list := get ("DirectoryList")
				if directories_list /= Void then
					pos := directories_list.index_of (';', 1) - 1
				end
				if pos > 1 then
					fill_recently_used
					directory := clone (directories_list)
					directory.head (directory.index_of (';', 1) - 1)
				else
					directory := current_working_directory
				end
			end
			update_directories
			selection_made := True
			ok_button.set_focus
		end

feature -- Access

	action_widget: FILE_SEL_D_IMP
			-- Widget to perform actions on.

	combo_box: WEL_DROP_DOWN_COMBO_BOX
			-- Combo box to select last project

	directory: STRING
			-- Current selected directory

	directories_list: STRING
			-- Current list of remembered directories

	directory_list: WEL_SINGLE_SELECTION_LIST_BOX
			-- List of directories in underneath `combo_box'

	drive_list: WEL_DROP_DOWN_LIST_COMBO_BOX
			-- List of drives

	ok_button: WEL_PUSH_BUTTON
			-- Button for ok

	cancel_button: WEL_PUSH_BUTTON
			-- Button for cancel

	search_directory: STRING
			-- Directory to begin search in

	selection_made: BOOLEAN
			-- Has a selection been made

	selection_text: WEL_STATIC
			-- Text for selected directory

feature -- Status setting

	set_no_selection_made is
			-- Set `selection_made' to false
		do
			selection_made := false
		end

	set_search_directory (s: STRING) is
			-- Set `search_directory' to `s'
		do
			search_directory := s
		ensure
			search_directory_set: search_directory = s
		end

	set_title (s: STRING) is
			-- Set `title' to `s'
		require
			title_exists: s /= Void
		do
			private_title := s
		ensure
			private_title_set: private_title = s
		end

feature -- Basic operations

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- A `notify_code' is received for `control'.
		do
			if control = combo_box then
				combo_box_action (notify_code)
			elseif control = directory_list then
				directory_list_action (notify_code)
			elseif control = drive_list then
				drive_list_action (notify_code)
			end
		end

	on_cancel is
			-- `cancel_button' is pressed.
		do
			selection_made := false
			cancel_actions.execute (action_widget, Void)
		end

	on_ok is
			-- `ok_button' is pressed.
		do
			ok_button_action
			ok_actions.execute (action_widget, Void)
		end

feature {NONE} -- Implementation

	combo_box_action (notify_code: INTEGER) is
			-- Combo box action
		local
			tmp: STRING
			d: DIRECTORY
		do
			if notify_code = cbn_editchange then
				selection_made := true
			elseif notify_code = cbn_selchange then
				selection_made := true
				tmp := combo_box.selected_string
				if tmp.count > 0 then
					!! d.make (tmp)
					if d.exists then
						directory := tmp
						update_directories
					end
				end
			elseif notify_code = cbn_killfocus then
				tmp := combo_box.text
				if tmp.count > 0 then
					!! d.make (tmp)
					if d.exists then
						directory := tmp
						update_directories
					end
				end
			end
		end

	directory_dialog_id: INTEGER is 100
			-- Select directory dialog identifier

	directory_list_action (notify_code: INTEGER) is
			-- Action on directory list
		do
			if notify_code = lbn_selchange then
				selection_made := false	
			elseif notify_code = lbn_dblclk then
				selection_made := true
				directory := process_list_selection (directory_list.selected_string)
				update_directories
			end
		end

	drive_list_action (notify_code: INTEGER) is
			-- Action on drive list
		do
			if notify_code = cbn_selchange then
				directory := drive_list.selected_string
				directory.head (directory.count - 2)
				directory.tail (directory.count - 2)
				directory.append (":\")
				selection_made := true
				update_directories
			end
		end

	ok_button_action is
			-- Action on ok button
		local
			tmp: STRING
		do
			if selection_made then
				tmp := combo_box.text
			else
				tmp := process_list_selection (directory_list.selected_string)
			end
			if
				tmp.item (tmp.count) = '\' or 
				tmp.item (tmp.count) = '/'and
				tmp.count /= 3
			then
				tmp.remove (tmp.count)
			end
			directory := tmp
			add_to_recently_used (tmp)
			save_recently_used
			action_widget.set_directory (directory)
			action_widget.set_filter (directory)
		end

	selection_text_id: INTEGER is 101
			-- Selection text static identifier

	combo_box_id: INTEGER is 102
			-- Selected directory identifier

	drive_list_id: INTEGER is 103
			-- List of drives identifier

	directory_list_id: INTEGER is 104
			-- List of directories identifier

	add_to_recently_used (s: STRING) is
			-- Add to the recently used directories
		require
			string_exists: s /= Void
		local
			a_item : STRING
		do
			if remembered_list = Void then
				!! remembered_list.make
				remembered_list.compare_objects
				remembered_list.extend (s)
			else
				if remembered_list.has (s) then
					remembered_list.start
					remembered_list.prune (s)
					remembered_list.compare_references
					remembered_list.extend (Void)
					remembered_list.compare_objects
				end
				if not remembered_list.empty then
					from
						remembered_list.finish
					until
						remembered_list.before
					loop
						remembered_list.back
						if remembered_list.before then
							a_item := Void
						else
							a_item := remembered_list.item
						end
						remembered_list.forth
						remembered_list.replace (a_item)
						remembered_list.back
					end
					remembered_list.forth
					remembered_list.replace (s)
				else
					remembered_list.extend (s)
				end
			end
		end

	fill_recently_used is
			-- Fill list of most recently used values
		local
			i, nb, pos, old_pos: INTEGER
			dir: STRING
			list: STRING
		do
			from
				list := directories_list
				nb := list.occurrences (';')
				!! remembered_list.make
				remembered_list.compare_objects
				old_pos := 1
				i := 0
			until
				i >= nb
			loop
				pos := list.index_of (';', old_pos + 1)
				dir := list.substring (old_pos, pos - 1)
				old_pos := pos + 1
				remembered_list.extend (dir)
				combo_box.add_string (dir)
				i := i + 1
			end
		end

	private_title: STRING
			-- Title of dialog

	process_list_selection (selected_string: STRING): STRING is
			-- Process the selection in the list.
		local
			ls : STRING
		do
			ls := clone (selected_string)
			if ls.item (1) = '[' then
				ls.remove (1)
				ls.remove (ls.count)
			end
			Result := clone (directory)
			if ls.is_equal ("..") then
				Result.remove (Result.count)
				from
				until
					Result.item (Result.count) = '\'	
				loop
					Result.remove (Result.count)
				end
			else
				if Result.item (Result.count) /= '\' then
					Result.append_character ('\')
				end
				Result.append (ls)
				Result.append_character ('\')
			end
		end

	remembered_list: LINKED_LIST [STRING]
			-- List of most recently used directories

	save_recently_used is
			-- Save list of most recently used directories
		local
			list: STRING
		do
			from
				!! list.make (512)
				remembered_list.start
			until
				remembered_list.after
			loop
				list.append (remembered_list.item)
				list.append (";")
				remembered_list.forth
			end
			put (list, "DirectoryList")
		end

	update_directories is
			-- Update the directories and drive list
			-- and the text based on the value in `directory'
		local
			wildcard_dir, drive_to_find: STRING
			select_item: INTEGER
		do
			wildcard_dir := clone (directory)
			if wildcard_dir.item (wildcard_dir.count) = '\' then
				wildcard_dir.remove (wildcard_dir.count)
			end
			if wildcard_dir.item (wildcard_dir.count) = ':' then
				wildcard_dir.extend ('\')
			end
			insert_in_directory_list (wildcard_dir)
			selection_text.set_text (wildcard_dir)
			combo_box.set_text (wildcard_dir)
			drive_list.reset_content
			drive_list.add_files (ddl_drives + ddl_exclusive, "*.*")
			drive_to_find := "[-" 
			drive_to_find.extend (wildcard_dir.item (1))
			select_item := drive_list.find_string (0, drive_to_find)
			if select_item > 0 then
				drive_list.select_item (select_item)
			end
			action_widget.set_directory (directory)
		end

	insert_in_directory_list (dir: STRING) is
			-- Fill `directory_list' with current found item in `dir' directory.
		require
			dir_not_void: dir /= Void
			dir_not_empty: not dir.empty
		local
			d: DIRECTORY
			found_item: STRING
			file_name: FILE_NAME
			file: RAW_FILE
			current_dir: STRING
		do
			directory_list.reset_content
			create d.make (dir)
			if d.exists then
				from
					d.open_read
					d.start
					d.readentry
					found_item := d.lastentry
					current_dir := "."
				until
					found_item = Void
				loop
					if found_item /= Void and then not found_item.is_equal (current_dir) then
						create file_name.make_from_string (dir)
						file_name.set_file_name (found_item)
						create file.make (file_name)
						if
							file.exists and then
							not file.is_symlink and then
							file.is_directory
						then
							found_item.prepend_character ('[')
							found_item.append_character (']')
							directory_list.add_string (found_item)
						end
					end
					d.readentry
					found_item := d.lastentry
				end
				d.close	
			end
		end
		
	class_name: STRING is
			-- Class name
		once
			Result := "EvisionDirSelectDialog"
		end

end -- class DIRECTORY_SELECTION_DIALOG_WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

