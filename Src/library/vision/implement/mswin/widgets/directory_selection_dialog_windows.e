indexing
	description: "Dialog box which can select directories."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class 
	DIRECTORY_SELECTION_DIALOG_WINDOWS

inherit
	G_ANY_WINDOWS

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

	make (a_parent: WEL_COMPOSITE_WINDOW; a_widget: FILE_SELECTION_DIALOG_WINDOWS) is
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
		do
			set_title (private_title)
			fill_recently_used
			directory := get ("Directory0")
			if directory = Void then
				if search_directory /= void then
					directory := search_directory
				else
					directory := current_working_directory
				end
			end
			update_directories
			selection_made := True
		end

feature -- Access

	action_widget: FILE_SELECTION_DIALOG_WINDOWS
			-- Widget to perform actions on.

	combo_box: WEL_DROP_DOWN_COMBO_BOX
			-- Combo box to select last project

	directory: STRING
			-- Current selected directory

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
			-- Void indicates current directory

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
			search_directory_set: private_title = s
		end

feature -- Basic operations

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- A `notify_code' is received for `control'.
		local
			tmp: STRING
			d: DIRECTORY
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
			i: INTEGER
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
					remembered_list.extend (Void)
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
			mru_max_string, s, mru_dir: STRING
			mru_count, mru_max: INTEGER
			i : INTEGER
		do
			mru_max_string := get ("DirectoryCount")
			if mru_max_string /= Void and then mru_max_string.is_integer then
				mru_max := mru_max_string.to_integer 
				if mru_max < 0 then 
					mru_max := 0
				end
			end
			if mru_max > 0 then
				!! remembered_list.make
				remembered_list.compare_objects
				from
					i := 0
				until
					i >= mru_max
				loop
					s := "Directory"
					s.append_integer (i)
					mru_dir := get (s)
					if mru_dir /= Void then
						mru_count := mru_count + 1
						remembered_list.extend (mru_dir)
					end
					i := i + 1
				end
			end
			from
				remembered_list.start
			until
				remembered_list.after
			loop
				combo_box.add_string (remembered_list.item)
				remembered_list.forth
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
			mru_max_string, s, mru_dir: STRING
			mru_max: INTEGER
			i : INTEGER
		do
			mru_max_string := get ("DirectoryCount")
			if mru_max_string /= Void and then mru_max_string.is_integer then
				mru_max := mru_max_string.to_integer 
				if mru_max < 0 then 
					mru_max := 0
				end
			end
			from
				i := 0
				remembered_list.start
			until
				i >= mru_max or remembered_list.after
			loop
				s := "Directory"
				s.append_integer (i)
				if remembered_list.item /= Void then
					put (remembered_list.item, s)
				else
					put ("C:\", s)
				end
				i := i + 1
				remembered_list.forth
			end
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
				wildcard_dir.append ("*.*")
			else
				wildcard_dir.append ("\*.*")
			end
			directory_list.reset_content
			directory_list.add_files (ddl_directory + ddl_exclusive, wildcard_dir)
			wildcard_dir := clone (directory)
			if wildcard_dir.item (wildcard_dir.count) = '\' then
				wildcard_dir.remove (wildcard_dir.count)
			end
			if wildcard_dir.item (wildcard_dir.count) = ':' then
				wildcard_dir.extend ('\')
			end
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

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionDirSelectDialog"
		end

end -- class DIRECTORY_SELECTION_DIALOG_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, 1995, 1996 
--| Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

