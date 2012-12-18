note
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make
			-- Make the main window
		do
			make_by_id (Id_main_dialog)
			create internal_eiffel_file_edit.make_by_id (Current, Id_edit_eiffel)
			create internal_h_file_edit.make_by_id (Current, id_edit_h)
			create internal_class_name_edit.make_by_id (Current, Id_edit_class_name)
			create internal_translate_button.make_by_id (Current, Cmd_file_translate)
		end

feature -- Access

	eiffel_file_edit: WEL_SINGLE_LINE_EDIT
		local
			l_edit: detachable WEL_SINGLE_LINE_EDIT
		do
			l_edit := internal_eiffel_file_edit
				-- Per invariant
			check l_edit_attached: l_edit /= Void end
			Result := l_edit
		end

	h_file_edit: WEL_SINGLE_LINE_EDIT
		local
			l_edit: detachable WEL_SINGLE_LINE_EDIT
		do
			l_edit := internal_h_file_edit
				-- Per invariant
			check l_edit_attached: l_edit /= Void end
			Result := l_edit
		end

	class_name_edit: WEL_SINGLE_LINE_EDIT
		local
			l_edit: detachable WEL_SINGLE_LINE_EDIT
		do
			l_edit := internal_class_name_edit
				-- Per invariant
			check l_edit_attached: l_edit /= Void end
			Result := l_edit
		end

	translate_button: WEL_PUSH_BUTTON
		local
			l_button: detachable WEL_PUSH_BUTTON
		do
			l_button := internal_translate_button
				-- Per invariant
			check l_button_attached: l_button /= Void end
			Result := l_button
		end

feature {NONE} -- Behaviors

	on_menu_command (id_menu: INTEGER)
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
				create about.make_by_id (Current, Id_about_dialog)
				about.activate
			when Cmd_file_translate then
				on_translate
			when Cmd_file_exit then
				terminate (Idok)
			else
			end
		end

	on_control_id_command (an_id: INTEGER)
		do
			on_menu_command (an_id)
		end

	on_file_select_h_file
		do
			open_header_file_dialog.activate (Current)
			if open_header_file_dialog.selected then
				h_file_edit.set_text (open_header_file_dialog.file_path.name)
			end
		end

	on_file_select_eiffel_file
		local
			c: WEL_CURSOR
		do
			open_eiffel_file_dialog.activate (Current)
			if open_eiffel_file_dialog.selected then
				eiffel_file_edit.set_text (open_eiffel_file_dialog.file_path.name)
				if file_exists (open_eiffel_file_dialog.file_path) then
					create c.make_by_predefined_id (Idc_wait)
					c.set
					scan_file_for_classname (open_eiffel_file_dialog.file_path)
					c.restore_previous
				end
			end
		end

	on_translate
		local
			conv: CONVERTER
			c: WEL_CURSOR
			previous_text: STRING_32
			msg_box: WEL_MSG_BOX
		do
			if file_exists (create {PATH}.make_from_string (h_file_edit.text)) then
				create c.make_by_predefined_id (Idc_wait)
				c.set
				previous_text := translate_button.text
				translate_button.set_text ("Translating...")
				create conv.make (class_name_edit.text,
					eiffel_file_edit.text,
					h_file_edit.text)
				conv.extract_definition (h_file_edit.text)
				conv.close_file
				translate_button.set_text (previous_text)
				c.restore_previous
			else
				create msg_box.make
				msg_box.error_message_box (Current, "Header file not found.", "Error")
			end
		end

	notify (a_control: WEL_CONTROL; notify_code: INTEGER)
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

	scan_file_for_classname (a_file_name: PATH)
		require
			a_file_name_not_void: a_file_name /= Void
			file_exists: file_exists (a_file_name)
		local
			a_file: PLAIN_TEXT_FILE
			break: BOOLEAN
		do
			create a_file.make_with_path (a_file_name)
			a_file.open_read
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

	scan_for_class_name (a_file: PLAIN_TEXT_FILE): BOOLEAN
			-- Scan for the classname and set it if it's found.
		require
			a_file_not_void: a_file /= Void
			a_file_exists: a_file.exists
			a_file_open: a_file.is_open_read
		local
			l_string: detachable STRING
		do
			if not a_file.end_of_file then
				a_file.read_word
				l_string := a_file.last_string
					-- Per postcondition of `a_file.read_word'.
				check l_string_attached: l_string /= Void end
				if l_string.same_string ("lass") then
					if not a_file.end_of_file then
						a_file.read_word
						l_string := a_file.last_string
							-- Per postcondition of `a_file.read_word'.
						check l_string_attached: l_string /= Void end
						class_name_edit.set_text (l_string)
						Result := True
					end
				end
			end
		end

	scan_for_next_string_terminator (a_file: PLAIN_TEXT_FILE): BOOLEAN
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

	open_eiffel_file_dialog: WEL_OPEN_FILE_DIALOG
		once
			create Result.make
			Result.set_title ("Select the Eiffel file")
			Result.set_filter (<<"Eiffel file (*.e)",
				"All file (*.*)">>, <<"*.e", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	open_header_file_dialog: WEL_OPEN_FILE_DIALOG
		once
			create Result.make
			Result.set_title ("Select the header/resource file")
			Result.set_filter (<<"Resource file (*.rc)",
				"Header file (*.h)", "All file (*.*)">>,
				<<"*.rc", "*.h", "*.*">>)
		ensure
			result_not_void: Result /= Void
		end

	file_menu: WEL_MENU
		once
			Result := menu.popup_menu (0)
		ensure
			result_not_void: Result /= Void
		end

	file_exists (filename: PATH): BOOLEAN
			-- Does `filename' exist?
		require
			filename_not_void: filename /= Void
		local
			a_file: PLAIN_TEXT_FILE
		do
			create a_file.make_with_path (filename)
			Result := a_file.exists
		end

feature {NONE} -- Internal data

	internal_eiffel_file_edit: detachable WEL_SINGLE_LINE_EDIT

	internal_h_file_edit: detachable WEL_SINGLE_LINE_EDIT

	internal_class_name_edit: detachable WEL_SINGLE_LINE_EDIT

	internal_translate_button: detachable WEL_PUSH_BUTTON

invariant
	internal_eiffel_file_edit_attached: internal_eiffel_file_edit /= Void
	internal_h_file_edit_attached: internal_h_file_edit /= Void
	internal_class_name_edit_attached: internal_class_name_edit /= Void
	internal_translate_button_attached: internal_translate_button /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class H2E_DIALOG

