indexing 
	status: "See notice at end of class"; 
	date: "$Date$"; 
	revision: "$Revision$" 
 
class
	FILE_SELEC_IMP
  
inherit 
	TERMINAL_IMP
		redefine
			build,
			make,
			notify,
			realize_children,
			set_height,
			set_size,
			set_width,
			set_form_width,
			set_form_height,
			class_name
		end

	EXECUTION_ENVIRONMENT

	FILE_SELEC_I 

	WEL_DDL_CONSTANTS

	WEL_ID_CONSTANTS

	WEL_LBN_CONSTANTS

creation
	make

feature -- Initialization

	make (a_file_selection: FILE_SELEC; man: BOOLEAN; oui_parent: COMPOSITE) is
		do
			managed := man
			parent ?= oui_parent.implementation
			!! private_attributes
			set_form_width (150)
			set_form_height (100)
		end

	build is
		do
			set_pattern ("*.*")
		end

	realize_children is
		do
			!! ok_button.make (Current, "Ok", 160, 20, 20, 5, idok)
			!! cancel_button.make (Current, "Cancel", 160, 40, 20, 5, idcancel)
			!! help_button.make (Current, "Help", 160, 60, 20, 5, 1000)
			!! directories_list.make (Current, 0, 0, 10, 10, 1001)
			!! directory_label.make (Current, "", 0, 0, 10, 10, 101)
			adjust_controls_width
			adjust_controls_height
			if help_button_hidden then
				hide_help_button
			end
			if cancel_button_hidden then
				hide_cancel_button
			end
			if ok_button_hidden then
				hide_ok_button
			end
			fill
		end

feature -- Measurement

	file_count: INTEGER 
			-- Number of items in file list

feature -- Status report

	directory: STRING 
			-- Base directory used in determining files and directories
			-- to be displayed

	dir_count: INTEGER
			-- Number of items in directory list

	dir_list: LINKED_LIST [STRING]
			-- Items of current directory list

	file_list: LINKED_LIST [STRING]
			-- Items of current file list

	filter: STRING
			-- Current filter value

	is_list_updated: BOOLEAN is
			-- Is file or directory list updated during last search?
		do
		end

	is_dir_valid: BOOLEAN is
			-- Is current search directory valid?
		do
		end

	pattern: STRING
			-- Search pattern used in combination with `directory'
			-- files and directories to be displayed

	pattern_name: STRING
			-- Name of the search pattern.

	selected_file: STRING
			-- Current selected file

feature -- Status setting

	hide_cancel_button is
			-- Make cancel button invisible.
			-- Always visible
		do
			cancel_button_hidden := true
			if cancel_button /= Void then
				cancel_button.hide
			end
		end

	hide_file_selection_label is
			-- Always visible
		do
		end
	
	hide_file_selection_list is
			-- Always visible
		do
		end

	hide_filter_button is
			-- Make filter button invisible.
			-- Always invisible
		do
		end

	hide_help_button is
			-- Make help button invisible.
			-- Always invisible
		do
			help_button_hidden := true
			if help_button /= Void then
				help_button.hide
			end
		end

	hide_ok_button is
			-- Make ok button invisible.
			-- Always visible
		do
			ok_button_hidden := true
			if ok_button /= Void then
				ok_button.hide
			end
		end

	set_all_selection is
			-- Sets selection to files and directories.
		do
			directory_only := False
		end

	set_directory (a_directory: STRING) is
			-- Set base directory used in determining files and directories
			-- to be displayed to `a_directory_name'.
		do
			base_directory := clone (a_directory)
		end

	set_directory_selection is
			-- Sets selection to directories only.
		do
			directory_only := True
		end

	set_dir_list_label (a_label: STRING) is
			-- Set `a_label' as dir list label,
			-- by default this label is `Directories'.
		do
		end

	set_file_list_label (a_label: STRING) is
			-- Set `a_label' as file list label,
			-- by default this label is `Files'.
		do
		end

	set_file_list_width (new_width: INTEGER) is
			-- Always the same
		do
		end

	set_file_selection is
			-- Select the files only
		do
			directory_only := False
		end

	set_filter (a_filter: STRING) is
			-- Set current filter to `a_filter'.
		do
			base_filter := clone (a_filter)
		end

	set_filter_label (label: STRING) is
			-- Set `a_label' as filter label,
			-- by default this label is `Filter'.
		do
		end

	set_pattern (a_pattern: STRING) is
			-- Set pattern to `a_pattern'.
		do
			pattern := a_pattern
		end

	set_pattern_name (a_pattern_name: STRING) is
			-- Set pattern_name to `a_pattern'.
		do
			pattern_name := a_pattern_name
		end

	set_form_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			if form_height /= a_height then
				private_attributes.set_height (a_height)
				if exists then
					wel_set_height (a_height)
					adjust_controls_height
				end;
			end
		end

	set_form_width (a_width: INTEGER) is
			-- Set the width for form.
		do
			if form_width /= a_width then
				private_attributes.set_width (a_width)
				if exists then
					wel_set_width (a_width)
					adjust_controls_width
				end
			end
		end

	set_height (a_height: INTEGER) is
			-- Set height to `new_height'.
		do
			private_attributes.set_height (a_height)
			if exists then
				wel_set_height (a_height)
				adjust_controls_height
			end;
			if parent /= Void then
				parent.child_has_resized
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Set the height to new_height,
			-- width to `new_width'.
		do
			private_attributes.set_width (new_width)
			private_attributes.set_height (new_height)
			if exists then
				resize (new_width, new_height)
				adjust_controls_width
				adjust_controls_height
			end
			if parent /= Void then
				parent.child_has_resized
			end
		end

	set_width (new_width: INTEGER) is
			-- Set width to `new_width'.
		do
			private_attributes.set_width (new_width)
			if exists then
				wel_set_width (new_width)
				adjust_controls_width
			end;
			if parent /= Void then
				parent.child_has_resized
			end
		end

	show_cancel_button is
			-- Make cancel button visible.
			-- Always visible
		do
			cancel_button_hidden := false
			if cancel_button /= Void then
				cancel_button.show
			end
		end

	show_help_button is
			-- Make help button visible.
			-- Always invisible
		do
			help_button_hidden := false
			if help_button /= Void then
				help_button.show
			end
		end

	show_ok_button is
			-- Make ok button visible.
			-- Always visible
		do
			ok_button_hidden := false
			if ok_button /= Void then
				ok_button.show
			end
		end

	show_file_selection_label is
			-- Always visible
		do
		end

	show_file_selection_list is
			-- Always visible
		do
		end

	show_filter_button is
			-- Make filter button visible.
			-- Always invisible
		do
		end

feature -- Element change

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

feature {NONE} -- Implementation

	base_directory: STRING
			-- Base directory

	base_filter: STRING
			-- Base filter

	directory_only: BOOLEAN
			-- Selection of a directory

	directory_list_label : WEL_STATIC

	directory_label : WEL_STATIC

	ok_button, cancel_button, help_button : WEL_PUSH_BUTTON
			-- Buttons on the dialog

	directories_list : WEL_SINGLE_SELECTION_LIST_BOX
			-- List box for displaying the directories.

	ok_button_hidden: BOOLEAN
			-- Is the `ok_button' hidden?

	cancel_button_hidden: BOOLEAN
			-- Is the `cancel_button' hidden?

	help_button_hidden: BOOLEAN
			-- Is the `help_button' hidden?

	fill is
			-- Fill the `directories_list'.
		local
			dir: STRING
			attr: INTEGER
		do
			directories_list.reset_content
			if directory = Void then
				dir := "./"
				directory := current_working_directory
			else
				dir := clone (directory)
			end
			if dir.item (dir.count) /= '/' then
				dir.append_character ('/')
			end
			dir.append (pattern)
			attr := ddl_drives + ddl_directory
			if directory_only then
				attr := attr + ddl_exclusive
			end
			directory_label.set_text (directory)
			directories_list.add_files (attr, dir)
		end

	notify (control: WEL_CONTROL; notify_code: INTEGER) is
			-- Process notification messages
		do
			if control = ok_button then
				ok_actions.execute (Current, Void)
			elseif control = cancel_button then
				cancel_actions.execute (Current, Void)
			elseif control = help_button then
				help_actions.execute (Current, Void)
			elseif control = directories_list then
				if notify_code = lbn_selchange then
					select_file (directories_list.selected_string)
				end
			end
		end

	select_file (selected: STRING) is
			-- Select the file
		local
			ls : STRING
		do
			ls := clone (selected)
			if ls.item (1) = '[' then
				ls.remove (1)
				ls.remove (ls.count)
			end
			if ls.is_equal ("..") then
				directory.remove (directory.count)
				from
				until
					directory.item (directory.count) = '\'	
				loop
					directory.remove (directory.count)
				end
			elseif ls.item (1) = '-' then
				directory := ":\"
				directory.precede (ls.item (2))
			elseif selected.item (1) = '[' then
				if directory.item (directory.count) /= '\' then
					directory.append_character ('\')
				end
				directory.append (ls)
			end
			selected_file := clone (directory)
			if selected.item (1) /= '[' then
				selected_file.append (selected)
			end
			directory_label.set_text (directory)
			fill			
		end

	button_count: INTEGER is
		do
			if ok_button /= Void and then not ok_button_hidden then
				Result := Result + 1
			end
			if cancel_button /= Void and then not cancel_button_hidden then
				Result := Result + 1
			end
			if help_button /= Void and then not help_button_hidden then
				Result := Result + 1
			end
		end

	adjust_controls_width is
			-- Set the control width based on the width of the 
			-- file_selection
		local
			button_width, last_x: INTEGER
		do
			directory_label.set_width (width)
			if button_count /= 0 then 
				button_width := (width - 4 * button_count)// button_count
				if button_width <= 0 then
					button_width := 1
				end
			end
			if ok_button /= Void and not ok_button_hidden then
				ok_button.set_width (button_width)
				ok_button.set_x (2)
				last_x := last_x + button_width + 6
			end
			if cancel_button /= Void and not cancel_button_hidden then
				cancel_button.set_width (button_width)
				cancel_button.set_x (last_x)
				last_x := last_x + button_width + 4
			end
			if help_button /= Void and not help_button_hidden then
				help_button.set_width (button_width)
				help_button.set_x (last_x)
			end
			if directories_list /= Void then
				directories_list.set_width (width)
			end
		end

	button_height: INTEGER is 
		local
			wel_dc: WEL_SCREEN_DC
			wel_ft: WEL_SYSTEM_FONT
		once
			!! wel_ft.make
			!! wel_dc
			wel_dc.get
			wel_dc.select_font (wel_ft)
			Result := wel_dc.string_height ("I") * 7 // 4
			wel_dc.unselect_font
			wel_dc.release 
		end

	adjust_controls_height is
			-- Set the control height based on the width of the 
			-- file_selection
		local
			directory_height : INTEGER
		do
			if height < (button_height * 2) + 20 then
			else
				directory_height := (height - (2 * button_height) - 5) // directories_list.item_height
				directory_height := directory_height * directories_list.item_height + 2 * window_border_height
				directories_list.set_height (directory_height)
				directories_list.set_y (button_height)
				directory_label.set_height (button_height)
				directory_label.set_y (0)
				if ok_button /= Void then
					ok_button.set_height (button_height)
					ok_button.set_y (height - button_height - 2)
				end
				if help_button /= Void then
					help_button.set_height (button_height)
					help_button.set_y (height - button_height - 2)
				end
				if cancel_button /= Void then
					cancel_button.set_height (button_height)
					cancel_button.set_y (height - button_height - 2)
				end
			end
			
		end

	class_name: STRING is
			-- Class name
		once
			Result := "EvisionFileSelection"
		end

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

