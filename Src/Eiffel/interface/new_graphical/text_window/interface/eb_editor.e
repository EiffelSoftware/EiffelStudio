note
	description: "A basic editor for EiffelStudio"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Etienne Amodeo"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EDITOR

inherit
	EDITABLE_TEXT_PANEL
		rename
			cursors as editor_cursors,
			recycle as internal_recycle
		redefine
			display_not_editable_warning_message,
			load_file_path,
			load_text,
			initialize_editor_context,
			reference_window,
			internal_recycle,
			show_warning_message,
			check_document_modifications_and_reload,
			paste
		end

	EB_SHARED_MANAGERS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	EB_RECYCLABLE
		undefine
			default_create
		redefine
			internal_detach_entities
		end

	SHARED_EDITOR_FONT
		export
			{ANY} has_font
			{NONE} all
		undefine
			default_create,
			font,
			line_height
		end

	EB_SHARED_PREFERENCES
		undefine
			default_create
		end

	EB_STONABLE
		rename
			refresh as refresh_stone,
			set_position as set_stone_position,
			position as stone_position
		undefine
			default_create
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		undefine
			default_create
		end

	ES_SHARED_DIALOG_BUTTONS
		export
			{NONE} all
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	 make
			-- Initialize the editor.
		do
			default_create
			register_documents
		end

	initialize_editor_context
			-- Here initialize editor contextual settings.  For example, set location of cursor pixmaps.
		do
			set_cursors (create {EB_EDITOR_CURSORS})
		end

	register_documents
	 		-- Register known document types with this editor
	 	do
	 		register_document ("e", eiffel_class)
	 	end

	 eiffel_class: DOCUMENT_CLASS
	         -- Eiffel class
	   	once
			create Result.make ("eiffel", "e", Void)
	   	    Result.set_scanner (create {EDITOR_EIFFEL_SCANNER}.make)
	   	    Result.set_encoding_detector (create {EC_SIMPLE_ENCODING_DETECTOR})
	   	end

feature -- Warning messages display

	display_not_editable_warning_message
				-- display warning message : text is not editable...
		local
			wm: STRING_32
			l_prompt: ES_DISCARDABLE_WARNING_PROMPT
		do
			if text_displayed /= Void then
				if is_read_only and then not allow_edition then
					if not_editable_warning_wide_message = Void or else not_editable_warning_wide_message.is_empty then
						wm := Warning_messages.w_Text_not_editable
					else
						wm := not_editable_warning_wide_message
					end
					show_warning_message (wm)
				else
					create l_prompt.make_standard (Interface_names.l_Text_loading, "", create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.acknowledge_not_loaded_preference, True))
					l_prompt.show (reference_window)
				end
			end
		end

	show_warning_message (a_message: STRING_GENERAL)
			-- show `a_message' in a dialog window		
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_warning_prompt (a_message, reference_window, Void)
		end

	show_error_message (a_message: STRING_GENERAL)
			-- show `a_message' in a dialog window
		do
			(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_error_prompt (a_message, reference_window, Void)
		end


feature -- Access

	dev_window: EB_DEVELOPMENT_WINDOW
			-- Associated development window

	docking_content: SD_CONTENT
			-- Docking content.

	bom: detachable STRING
			-- Bom if detected.

feature -- Docking

	set_docking_content (a_content: SD_CONTENT)
			-- Set `docking_content' with `a_content' and associate `widget' to `a_content'.
		require
			a_content_attached: a_content /= Void
		do
			docking_content := a_content
		end

feature -- Status report

	is_main_editor: BOOLEAN
			-- Is current main editor?

feature -- Status setting

	set_is_main_editor (a_b: BOOLEAN)
			-- Set `is_main_editor' with `a_b'.
		do
			is_main_editor := a_b
		end

	set_bom (a_bom: like bom)
			-- Set `bom' with `a_bom'.
		do
			bom := a_bom
		ensure
			bom_set: bom = a_bom
		end

feature -- Text Loading

	load_file_path (a_filename: PATH)
	        -- Load contents of `a_filename'.
		local
			l_file: RAW_FILE
  	   	do
  	   		reset

				-- Reset encoding.
			set_encoding (Void)
			bom := Void
			create l_file.make_with_path (a_filename)
				-- Set `load_file_error' if the file does not exist.
			if l_file.exists then
				load_file_error := False

					-- Setup encoding
				if attached {CLASSI_STONE} stone as l_class_stone then
					l_file.open_read
						-- Make sure we do not fail when the file is empty.
					if l_file.count > 0 then
						l_file.read_stream (4)
						if attached encoding_converter.encoding_from_string_of_class (l_file.last_string, l_class_stone.class_i) as l_enc then
							set_encoding (l_enc)
							bom := encoding_converter.last_bom
						end
					end
					l_file.close
				end
			else
				load_file_error := True
			end

			Precursor (a_filename)
				-- The following code is broken. See bug#13171 and bug#13082. For the 6.0 release,
				-- we are simply disabling this code and never load the backup (see the above two lines)
--  	   	create l_filename.make_from_string (a_filename)
--			create test_file.make (l_filename.string.twin)
--			l_filename.add_extension ("swp")
--			create test_file_2.make (l_filename)
--			if test_file_2.exists and then test_file_2.is_readable and then ((not test_file.exists) or else test_file.date < test_file_2.date) then
--				if test_file.exists then
--					ask_if_opens_backup
--					if not open_backup then
--						test_file_2.delete
--							-- Use original file
--						create l_filename.make_from_string (a_filename)
--					end
--				end
--					-- If `test_file' does not exist we force a loading of the backup file.
--				Precursor (l_filename)
--			else
--				create l_filename.make_from_string (a_filename)
--				Precursor (l_filename)
--			end
  	  	end

	load_text (s: STRING_GENERAL)
			-- <Precursor>
		local
			l_d_class : DOCUMENT_CLASS
		do
			l_d_class := get_class_from_type (once "e")
			set_current_document_class (l_d_class)
			if
				attached {EDITOR_EIFFEL_SCANNER} l_d_class.scanner as l_scanner and then
				attached {CLASSI_STONE} stone as l_classi_stone
			then
				l_scanner.set_current_class (l_classi_stone.class_i.config_class)
 			end
				-- Remove the BOM before parsing in the editor.
				-- Otherwise, positions from the compiler parser does not match those from the editor scanner.
			Precursor {EDITABLE_TEXT_PANEL}
				(if
					attached bom and then
					s.count >= bom.count and then
					s.substring (1, bom.count) ~ bom
				then
					s.to_string_8.tail (s.count - bom.count)
				else
					s
				end)
		end

	check_document_modifications_and_reload
			-- Check if current stone is changed and reload.
		local
			l_question: ES_QUESTION_PROMPT
			l_class_name: STRING_8
		do
			is_checking_modifications := True

				-- After refactoring, the stone is possibly changed,
				-- and file name is possibly changed.
			if attached {CLASSI_STONE} stone as l_class_stone then
				if not file_path.is_equal (l_class_stone.class_i.file_name) then
					file_path := l_class_stone.class_i.file_name
				end
				l_class_name := l_class_stone.class_i.name
			end

			if not file_exists then
				reload
			elseif not file_is_up_to_date then
				if changed or not editor_preferences.automatic_update then
						-- File has not changed in panel and is not up to date.  However, user does want auto-update so prompt for reload.
					if l_class_name /= Void then
						create l_question.make_standard (interface_names.t_class_has_been_modified (l_class_name))
					else
						create l_question.make_standard (interface_names.t_file_has_been_modified (file_path.name))
					end
					l_question.set_button_text (l_question.dialog_buttons.yes_button, interface_names.b_Reload)
					l_question.set_button_action (l_question.dialog_buttons.yes_button, agent reload)
					l_question.set_button_text (l_question.dialog_buttons.no_button, interface_names.b_Continue_anyway)
					l_question.set_button_action (l_question.dialog_buttons.no_button, agent continue_editing)
					l_question.show (reference_window)
				elseif editor_preferences.automatic_update and not changed then
					reload
				end
			end
			is_checking_modifications := False
		end

feature -- Stonable

	stone : detachable STONE
			-- Stone representing Current

	set_stone (a_stone: detachable STONE)
			-- Make `s' the new value of stone.
			-- Changes display as a consequence, to preserve the fact
			-- that the tool displays the content of the stone
			-- (when there is a stone).
		do
			stone := a_stone
		ensure then
			stone_attached: stone = a_stone
		end

	refresh_stone
			-- Synchronize Current with `stone'.
		do

		end

feature {NONE} -- Memory Management

	internal_recycle
			-- Destroy `Current'.
		do
			Precursor {EDITABLE_TEXT_PANEL}
		end

	internal_detach_entities
			-- <Precursor>
		do
			dev_window := Void
			stone := Void
			docking_content := Void
			Precursor
		end

feature {EB_COMMAND, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_MENU_BUILDER, ES_PRETTIFY_SUGGESTION_DETECTOR} -- Prettify text

	prettify
			-- Prettify class text if possible.
		local
			l_show_pretty: E_SHOW_PRETTY
			s: STRING_32
			f: like first_line_displayed
			l, n: like {EDITOR_CURSOR}.y_in_lines
			c: like {EDITOR_CURSOR}.x_in_characters
		do
			if is_read_only and then not allow_edition then
					-- Don't prettify class text if we are in a read-only view.
				display_not_editable_warning_message
			elseif text_displayed.is_modified then
				save_class_before_prettifying
			else
					-- Create a string to write prettified text.
				create s.make_empty
					-- Prettify code.
				create l_show_pretty.make_string (file_path.name, s)
					-- Check if formatting is successful.
				if not l_show_pretty.error and then not same_text (s) then
						-- Record current caret position.
					f := first_line_displayed
					l := text_displayed.cursor.y_in_lines
					c := text_displayed.cursor.x_in_characters
						-- Replace current class text with the prettified text.
					text_displayed.select_all
					text_displayed.replace_selection (s)

						-- Refresh the editor and go to the beginning of the class text.
					refresh_now
					text_displayed.forget_selection
					text_displayed.flush
						-- Restore caret position.
					n := number_of_lines
					set_first_line_displayed (f.min (n), True)
					if f > 0 and then n > 0 then
						text_displayed.cursor.set_y_in_lines (l.min (n))
					end
					if c > 0 then
						text_displayed.cursor.set_x_in_characters (c)
					end
				end
				window_manager.prettify_suggestion_detector.reset
			end
		end

feature {NONE} -- Prettify implementation

	save_class_before_prettifying
			-- Modified classes must be saved before prettifying.
		require
			class_modified: text_displayed.is_modified
		local
			l_save_request: ES_DISCARDABLE_QUESTION_PROMPT
		do
			create l_save_request.make_standard (
					warning_messages.w_Must_save_before_prettifying (stone.stone_name),
					interface_names.l_Discard_save_before_prettifying_dialog,
					create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.confirm_save_before_prettifying_preference, True)
				)

			l_save_request.set_title (interface_names.t_eiffelstudio_question)
			l_save_request.set_button_action (dialog_buttons.yes_button, agent dev_window.save_text)
			l_save_request.show_on_active_window

				-- Call 'prettify' again if the class was successfully saved.
			if not text_displayed.is_modified then
				prettify
			end
		end

feature {NONE} -- Comparison

	same_text (s: STRING_32): BOOLEAN
			-- Is current text in the editor the same as `s`?
		require
			text_loaded: text_displayed.reading_text_finished
		local
			current_line: like {EDITABLE_TEXT}.current_line
			last_line: like {EDITABLE_TEXT}.last_line
			line_text: STRING_32
			position: like {STRING_32}.index_of
		do
			Result := True
			from
				current_line := text_displayed.first_line
				last_line := text_displayed.last_line
				position := 1
			until
				not attached current_line or else not Result
			loop
				line_text := current_line.wide_image
				Result := s.same_characters (line_text, 1, line_text.count, position)
				position := position + line_text.count
				if
					Result and then
					current_line /= last_line and then
					attached current_line.eol_token
				then
					Result := s.valid_index (position) and then s [position] = '%N'
					position := position + 1
				end
				current_line := current_line.next
			end
		end

feature {EB_COMMAND, EB_DEVELOPMENT_WINDOW, EB_DEVELOPMENT_WINDOW_MENU_BUILDER, EB_CONTEXT_MENU_FACTORY} -- Edition Operations on text

	toggle_comment_selection
			-- Comment selected lines if possible.
		do
			if is_editable and then not is_empty then
				text_displayed.toggle_comment_selection
				refresh_now
			end
		end

	comment_selection
			-- Comment selected lines if possible.
		do
			if is_editable and then not is_empty then
				text_displayed.comment_selection
				refresh_now
			end
		end

	uncomment_selection
			-- Uncomment selected lines if possible.
		do
			if is_editable and then not is_empty then
				text_displayed.uncomment_selection
				refresh_now
			end
		end

	paste
			-- Paste text from clipboard, taking shift key into account.
			-- If shift key is held, we paste as it is,
			-- otherwise we indented paste
		do
			if shifted_key then
				Precursor
			else
				paste_with_indentation
			end
		end

feature {NONE} -- Retrieving backup

	ask_if_opens_backup
			-- Display a dialog asking the user whether he wants to open
			-- the original file or the backup one, and set `open_backup' accordingly.
		local
			l_warning: ES_WARNING_PROMPT
		do
			create l_warning.make_standard_with_cancel (Warning_messages.w_Found_backup)
			l_warning.set_button_text (l_warning.dialog_buttons.ok_button, Interface_names.b_Open_backup)
			l_warning.set_button_action (l_warning.dialog_buttons.ok_button, agent open_backup_selected)
			l_warning.set_button_text (l_warning.dialog_buttons.cancel_button, Interface_names.b_Open_original)
			l_warning.set_button_action (l_warning.dialog_buttons.cancel_button, agent open_normal_selected)
			l_warning.show (reference_window)
		end

feature {NONE} -- Implementation

	reference_window: EV_WINDOW
			-- Window which error dialogs will be shown relative to.
		do
			if internal_reference_window /= Void then
				Result := internal_reference_window
			else
				if dev_window /= Void and then dev_window.window /= Void then
					Result := dev_window.window
				else
					Result := Window_manager.last_focused_window.window
				end
				internal_reference_window := Result
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
