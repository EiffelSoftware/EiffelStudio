indexing
	description: "Dialog for file selection"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	FILE_SEL_D_IMP

inherit
	COLORED_FOREGROUND_WINDOWS

	WM_CONTROL_WINDOWS

	DIALOG_I

	FILE_SEL_D_I
		rename
			allow_recompute_size as allow_resize,
			forbid_recompute_size as forbid_Resize
		end

	DIALOG_IMP
		redefine
			class_name,
			default_style,
			is_popped_up,
			popup,
			popdown,
			realize,
			realized,
			set_title,
			title,
			unrealize
		end

	GRABABLE_WINDOWS

	WEL_OFN_CONSTANTS

creation
	make

feature -- Initialization

	make (a_file_sel_dialog: FILE_SEL_D; oui_parent: COMPOSITE) is
			-- Create a file selection dialog box
		do
			parent ?= oui_parent.implementation
			!! private_attributes
			a_file_sel_dialog.set_dialog_imp (Current)
			title := clone (a_file_sel_dialog.identifier)
		end

	realize is
			-- Realize current widget 
		do
			realized := true
				-- set initial focus
			if initial_focus /= Void then
				initial_focus.wel_set_focus
			end
		end

feature -- Access

	dir_count: INTEGER is
			-- Count of directories below `filter'
		do
		end

	dir_list: LINKED_LIST [STRING] is
			-- List of directories below `filter'
		do
		end

	directory: STRING 
			-- Base directory used in determining files and directories
			-- to be displayed

	file_list: LINKED_LIST [STRING] is
			-- List of files below `filter' that match `pattern'
		do
		end

	filter: STRING 
		-- Filter used for directory selection

	pattern: STRING 
		-- Pattern used for file selection

	pattern_name: STRING 
		-- Name of the pattern used for file selection

	title: STRING 
		-- Title of dialog

feature -- Measurement

	file_count: INTEGER is
			-- Count of files below `filter' that 
			-- match `pattern' when not `directory_selection'
		do
		end

feature -- Status report

	is_popped_up: BOOLEAN
			-- Is the popup widget popped up on screen ?

	realized: BOOLEAN
			-- Is this widget realized?

	selected_file: STRING is
			-- Current selected file
		do
			if directory_selection then
				if directory_dialog /= Void and directory_dialog.selection_made then
					Result := clone (directory_dialog.directory)
				end
			else
				if wel_file_dialog /= Void and then wel_file_dialog.selected then
					Result := wel_file_dialog.file_name
				end
			end
			if Result = Void then
				!! Result.make (0)
			end
		end

feature -- Status setting

	popdown is
			-- Popdown widget
		do
			is_popped_up := false
			if directory_selection and then directory_dialog.exists then
				directory_dialog.terminate (0)
			end
		end

	popup is
			-- Display a file selection dialog box
		local
			wc: WEL_COMPOSITE_WINDOW
		do
			is_popped_up := true
			wc ?= parent
			if directory_selection then
				if directory_dialog = Void then
					!! directory_dialog.make (wc, Current)
				end
				directory_dialog.set_title (title)
				directory_dialog.set_search_directory (directory)
				directory_dialog.set_no_selection_made
				directory_dialog.activate
			else
				if file_save_selection then
					!WEL_SAVE_FILE_DIALOG! wel_file_dialog.make
					wel_file_dialog.add_flag (ofn_hidereadonly)
				else
					!WEL_OPEN_FILE_DIALOG! wel_file_dialog.make
					wel_file_dialog.add_flag (Ofn_createprompt)
				end
				wel_file_dialog.add_flag (Ofn_nochangedir)
				wel_file_dialog.set_title (title)
				if pattern /= Void then
					wel_file_dialog.set_filter (<<pattern_name,"All files (*.*)">>, <<pattern,"*.*">>)
				end
				if directory = Void then
					wel_file_dialog.set_initial_directory_as_current
				else
					wel_file_dialog.set_initial_directory (directory)
				end
				realized := True
				wel_file_dialog.activate (wc)
				if wel_file_dialog.selected then
					!! directory.make (0)
					directory.set (wel_file_dialog.file_name,
							1, wel_file_dialog.file_name_offset - 2)
					ok_actions.execute (Current, Void)
				else
					cancel_actions.execute (Current, Void)
				end
				realized := False
			end
		end

	set_title (a_title: STRING) is
			-- Set `title' to `a_title'.
		do
			title := clone (a_title)
		end

	set_pattern (s: STRING) is
			-- Set the pattern to `s'
		do
			pattern := s
		end

	set_pattern_name (s: STRING) is
			-- Set `pattern_name' to `s'
		do
			pattern_name := s
		end

	set_filter (s: STRING) is
			-- Set the filter to `s'
		local
			string_count: INTEGER
			f: STRING
			c: CHARACTER
		do
			string_count := s.count
			c := s @ string_count
			if
				c = '\' or else
				c = '/' or else
				c = ':'
			then
				directory := clone (s)
				directory.replace_substring_all ("/", "\")
				if c = ':' then
					directory.append_character ('\')
				end
			else
				from
					f := ""
				until
					c = '\' or else
					c = '/' or else
					c = ':' or else
					string_count = 1
				loop
					f.prepend_character (c)
					string_count := string_count - 1
					c := s @ string_count
				end
				if string_count /= 1 then
					if has_wildcard (f) then
						filter := f
						directory.set (s, 1, string_count)
					else
						directory := s
						directory.append_character ('\')
					end
					directory.replace_substring_all ("/", "\")
				else
					directory := "c:\"
					filter := "*.*"
				end
			end
			if has_wildcard (directory) then
				directory := "c:\"
				filter := "*.*"
			end
		end

	set_directory (s: STRING) is
			-- Set base directory used in determining files and directories
			-- to be displayed to `a_directory_name'.
		do
			directory := clone (s)
			directory.replace_substring_all ("/", "\")
		end

	set_open_file is
			-- Set dialog to be "open file"
		do
			file_save_selection := false
		end

	set_save_file is
			-- Set dialog to be "save file"
		do
			file_save_selection := true
		end

	set_file_selection is
			-- Set dialog for file selection
		do
			directory_selection := false
		end

	set_directory_selection is
			-- Set dialog for directory selection
		do
			directory_selection := true
		end

	unrealize is
			-- Does nothing.
		do
			realized := False
		end

	add_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.add (Current, a_command, arg)
		end

	add_help_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- help button is activated.
		do
			help_actions.add (Current, a_command, arg)
		end

	add_ok_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.add (Current, a_command, arg)
		end

	add_filter_action (a_command: COMMAND; arg: ANY) is
			-- Add `a_command' to the list of action to execute when
			-- filter button is activated.
		do
			filter_actions.add (Current, a_command, arg)
		end

feature -- Removal

	remove_cancel_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- cancel button is activated.
		do
			cancel_actions.remove (Current, a_command, arg)
		end

	remove_filter_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- filter button is activated.
		do
			filter_actions.remove (Current, a_command, arg)
		end

	remove_help_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- help button is activated.
		do
			help_actions.remove (Current, a_command, arg)
		end

 	remove_ok_action (a_command: COMMAND; arg: ANY) is
			-- Remove `a_command' from the list of action to execute when
			-- ok button is activated.
		do
			ok_actions.remove (Current, a_command, arg)
		end

feature -- Inapplicable

	build is
		do
		end

	set_file_list_label (s: STRING) is
		do
		end

	set_dir_list_label  (s: STRING) is
		do
		end

	set_label_font (f: FONT) is
		do
		end

	set_text_font (f: FONT) is
		do
		end

	set_button_font (f: FONT) is
		do
		end

	text_font: FONT

	label_font: FONT

	button_font : FONT 

	set_file_list_width   (i: INTEGER) is
		do
		end

	set_filter_label (s: STRING) is
		do
		end

	is_list_updated: BOOLEAN

	is_dir_valid  : BOOLEAN 

feature {NONE} -- Inaplicable

	default_style: INTEGER

	show_filter_button,
	hide_file_selection_list,
	show_file_selection_list,
	show_ok_button,
	hide_ok_button,
	show_cancel_button,
	hide_cancel_button,
	show_help_button,
	hide_help_button,
	hide_filter_button,
	show_file_selection_label,
	hide_file_selection_label,
	set_all_selection is
		do
			debug ("WINDOWS")
				check
					inapplicable: False
				end
			end
		end

feature -- Implementation

	directory_dialog: DIRECTORY_SELECTION_DIALOG_WINDOWS
			-- Dialog for selecting a directory

	directory_selection: BOOLEAN
			-- Is this a directory selection?

	file_save_selection: BOOLEAN
			-- Is this a file save?

	wel_file_dialog: WEL_FILE_DIALOG
			-- WEL dialog for file selection

feature {NONE} -- Implementation

	has_wildcard (s: STRING): BOOLEAN is
			-- Has string `s' a wildcard?
		do
			Result := s.substring_index ("?", 1) /= 0 or else
				s.substring_index ("*", 1) /= 0
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionFileSelectionDialog"
		end

end -- class FILE_SEL_D_IMP

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

