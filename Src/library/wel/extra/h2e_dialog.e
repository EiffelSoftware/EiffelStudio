class
	H2E_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			on_menu_command,
			on_control_id_command,
			notify
		end

	H2E_IDS
		export
			{NONE} all
		end

	WEL_EN_CONSTANTS
		export
			{NONE} all
		end

	WEL_IDC_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Make the main window
		do
			make_by_id (Id_main_dialog)
			!! eiffel_file_edit.make_by_id (Current, Id_edit_eiffel)
			!! h_file_edit.make_by_id (Current, id_edit_h)
			!! class_name_edit.make_by_id (Current, Id_edit_class_name)
			!! translate_button.make_by_id (Current, Cmd_file_translate)
		end

feature -- Access

	eiffel_file_edit: WEL_SINGLE_LINE_EDIT

	h_file_edit: WEL_SINGLE_LINE_EDIT

	class_name_edit: WEL_SINGLE_LINE_EDIT

	translate_button: WEL_PUSH_BUTTON

feature {NONE} -- Behaviors

	on_menu_command (id_menu: INTEGER) is
		local
			about: WEL_MODAL_DIALOG
		do
			inspect
				id_menu
			when Cmd_file_browse_eiffel then
				on_file_select_eiffel_file
			when Cmd_file_browse_h then
				on_file_select_h_file
			when Cmd_help_about then
				!! about.make_by_id (Current, Id_about_dialog)
				about.activate
			when Cmd_file_translate then
				on_translate
			when Cmd_file_exit then
				terminate (Idok)
			else
			end
		end

	on_control_id_command (an_id: INTEGER) is
		do
			on_menu_command (an_id)
		end

	on_file_select_h_file is
		do
			open_header_file_dialog.activate (Current)
			if open_header_file_dialog.selected then
				h_file_edit.set_text (open_header_file_dialog.file_name)
			end
		end

	on_file_select_eiffel_file is
		local
			c: WEL_CURSOR
		do
			open_eiffel_file_dialog.activate (Current)
			if open_eiffel_file_dialog.selected then
				eiffel_file_edit.set_text (open_eiffel_file_dialog.file_name)
				if file_exists (open_eiffel_file_dialog.file_name) then
					!! c.make_by_predefined_id (Idc_wait)
					c.set
					scan_file_for_classname (open_eiffel_file_dialog.file_name)
					c.restore_previous
				end
			end
		end

	on_translate is
		local
			conv: CONVERTER
			c: WEL_CURSOR
			previous_text: STRING
		do
			if file_exists (h_file_edit.text) then
				!! c.make_by_predefined_id (Idc_wait)
				c.set
				previous_text := translate_button.text
				translate_button.set_text ("Translating...")
				!! conv.make (class_name_edit.text,
					eiffel_file_edit.text,
					h_file_edit.text)
				conv.convert (h_file_edit.text)
				conv.close_file
				translate_button.set_text (previous_text)
				c.restore_previous
			else
				error_message_box ("Header file not found.")
			end
		end

	notify (a_control: WEL_CONTROL; notify_code: INTEGER) is
		do
			if notify_code = En_change then
				if not class_name_edit.text.is_empty and then not
					eiffel_file_edit.text.is_empty and then not
					h_file_edit.text.is_empty then
					translate_button.enable
					file_menu.enable_item (Cmd_file_translate)
				else
					translate_button.disable
					file_menu.disable_item (Cmd_file_translate)
				end
			end
		end

feature {NONE} -- Implementation

	scan_file_for_classname (a_file_name: STRING) is
		require
			file_exists: file_exists (a_file_name)
		local
			a_file: PLAIN_TEXT_FILE
			break: BOOLEAN
		do
			!! a_file.make_open_read (a_file_name)
			from
				a_file.start
			until
				a_file.after or else break
			loop
				a_file.read_character
				if a_file.last_character = '%"' then
					break := scan_for_next_string_terminator (a_file)
				elseif a_file.last_character = 'c' or
					a_file.last_character = 'C' then
					break := scan_for_class_name (a_file)
				end
			end
			a_file.close
		end

	scan_for_class_name (a_file: PLAIN_TEXT_FILE): BOOLEAN is
			-- Scan for the classname and set it if it's found.
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_open: a_file.is_open_read
		do
			if not a_file.end_of_file then
				a_file.read_word
				if a_file.last_string.is_equal ("lass") then
					if not a_file.end_of_file then
						a_file.read_word
						class_name_edit.set_text (a_file.last_string)
						Result := True
					end
				end
			end
		end

	scan_for_next_string_terminator (a_file: PLAIN_TEXT_FILE): BOOLEAN is
			-- Scan `a_file' until string terminator detected
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_open: a_file.is_open_read
		local
			break: BOOLEAN
		do
			from
			until
				a_file.after or break
			loop
				a_file.read_character
				if a_file.last_character.is_equal ('%"') then
					break := True
				elseif a_file.last_character.is_equal ('%%') then
					a_file.read_character
				end
			end
			Result := a_file.after
		end

	open_eiffel_file_dialog: WEL_OPEN_FILE_DIALOG is
		once
			!! Result.make
			Result.set_title ("Select the Eiffel file")
			Result.set_filter (<<"Eiffel file (*.e)",
				"All file (*.*)">>, <<"*.e", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	open_header_file_dialog: WEL_OPEN_FILE_DIALOG is
		once
			!! Result.make
			Result.set_title ("Select the header/resource file")
			Result.set_filter (<<"Resource file (*.rc)",
				"Header file (*.h)", "All file (*.*)">>,
				<<"*.rc", "*.h", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	file_menu: WEL_MENU is
		once
			Result := menu.popup_menu (0)
		ensure
			result_not_void: Result /= Void
		end

	file_exists (filename: STRING): BOOLEAN is
			-- Does `filename' exist?
		require
			filename_not_void: filename /= Void
		local
			a_file: PLAIN_TEXT_FILE
		do
			!! a_file.make (filename)
			Result := a_file.exists
		end

end -- class H2E_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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

