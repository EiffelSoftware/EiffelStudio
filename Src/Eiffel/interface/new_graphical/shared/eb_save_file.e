note
	description: "Class to save a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Patrick Ruckstuhl"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_FILE

inherit
	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	SHARED_WORKBENCH

	SYSTEM_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

	EC_ENCODING_UTILITIES
		export
			{NONE} all
		end

feature -- Access

	last_saving_date: INTEGER
			-- The date of the last save operation.

	last_saving_success: BOOLEAN
			-- Was the last saving successful?

	last_process_lost_data: BOOLEAN
			-- Did last call of `presave_process' report data lose?

feature -- Basic operations

	load (a_file_name: STRING): STRING
			-- Load the text from `a_file_name'
		require
			a_file_name_not_void: a_file_name /= Void
		do

		end

	presave_process (a_text: STRING_GENERAL; a_encoding: ENCODING; a_bom: detachable STRING_8)
			-- This is not necessary, unless extra info is needed before the real saving.
			-- i.e. Whether the `a_text' conversion causes data lose.
		require
			a_text_not_void: a_text /= Void
		local
			l_stream: STRING_8
		do
			last_process_lost_data := False
			if not a_text.is_empty then
				l_stream := convert_to_stream (a_text.as_string_32, a_encoding)
				if last_conversion_lost_data then
					last_process_lost_data := True
				end
			end
		end

	save (a_file_name: READABLE_STRING_GENERAL; a_text: STRING_GENERAL; a_encoding: ENCODING; a_bom: detachable STRING_8)
			-- Save `a_text' into `a_file_name'. Creates file if it doesn't already exist.
			-- `a_text' should be in UTF-32 encoding.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			new_file, tmp_file: RAW_FILE -- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			aok, create_backup, new_created: BOOLEAN
			tmp_name: READABLE_STRING_32
			retried: BOOLEAN
			l_notifier: SERVICE_CONSUMER [FILE_NOTIFIER_S]
			l_text: STRING_32
			l_new_file_name: READABLE_STRING_GENERAL
		do
			if not retried then
					-- Always assume a saving is successful.
				last_saving_success := True
				l_new_file_name := a_file_name
				create new_file.make_with_name (l_new_file_name)

				aok := True
				if not new_file.exists then
					if not new_file.is_creatable then
						aok := False
						last_saving_success := False
						prompts.show_error_prompt (warning_messages.w_not_creatable (l_new_file_name), Void, Void)
					else
						new_created := True
					end
				else
					if not new_file.is_plain then
						aok := False
						last_saving_success := False
						prompts.show_error_prompt (warning_messages.w_not_a_plain_file (l_new_file_name), Void, Void)
					elseif not new_file.is_writable then
						aok := False
						last_saving_success := False
						prompts.show_error_prompt (warning_messages.w_not_writable (l_new_file_name), Void, Void)
					end
				end

				-- Create a backup of the file in case there will be a problem during the savings.
				tmp_name := a_file_name.as_string_32 + ".swp"
				create tmp_file.make_with_name (tmp_name)
				create_backup := not new_created and not tmp_file.exists and then tmp_file.is_creatable
				if not create_backup then
					tmp_file := new_file
				end
				l_text := a_text.as_string_32
				if aok then
					tmp_file.open_write
					if not l_text.is_empty then
						l_text.prune_all ('%R')
						if l_text.item (l_text.count) /= '%N' then
							-- Add a carriage return like `vi' if there's none at the end
							l_text.extend ('%N')
						end
						if preferences.misc_data.text_mode_is_windows then
							l_text.replace_substring_all ("%N", "%R%N")
						end
							-- Save with BOM if any.
						if a_bom /= Void then
							tmp_file.put_string (a_bom)
						end
						tmp_file.put_string (convert_to_stream (l_text, a_encoding))
					end
					tmp_file.close
					if create_backup then
						robust_rename (tmp_name, a_file_name)
					elseif last_saving_success then
						l_new_file_name := tmp_name
						create new_file.make_with_name (l_new_file_name)
						if new_file.exists then
							last_saving_date := new_file.date
							robust_delete (new_file)
						end
					end
					if last_saving_success and tmp_file.exists then
						last_saving_date := tmp_file.date
					end
					workbench.set_changed

						-- Notify service of file change
					create l_notifier
					if attached l_notifier.service as s then
							-- Poll modifications, allowing subscribers to receive change modifications.
						s.poll_modifications (create {PATH}.make_from_string (a_file_name)).do_nothing
					end
				end
			else
				if tmp_file /= Void and then not tmp_file.is_closed then
					tmp_file.close
				end
				if new_file /= Void and then not new_file.is_closed then
					new_file.close
				end
				prompts.show_error_prompt (warning_messages.w_Not_creatable_choose_to_save (l_new_file_name), Void, Void)
				file_save_as (a_text, a_encoding, a_bom)
				last_saving_success := False
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	robust_delete (a_file: FILE)
			-- More robust version of `delete'. If deletion is not successful, we abandon.
		require
			a_file_ok: a_file /= Void
			a_file_exists: a_file.exists

		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				a_file.delete
			end
		rescue
			l_retried := True
			retry
		end

	robust_rename (a_old_name: READABLE_STRING_GENERAL; a_new_name: READABLE_STRING_GENERAL)
			-- More robust version of change_name, which tries multiple times before giving up.
		require
			a_old_name_ok: a_old_name /= Void and then not a_old_name.is_empty
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		local
			l_retried, l_user_ask_for_retry: BOOLEAN
			l_ed: ES_ERROR_PROMPT
			l_buttons: ES_DIALOG_BUTTONS
			l_win: EV_WINDOW
			l_editor: EB_SMART_EDITOR
			u: FILE_UTILITIES
		do
			if l_retried then
				l_editor := window_manager.last_focused_development_window.editors_manager.current_editor
				create l_buttons
				create l_ed.make (warning_messages.w_Not_rename_swp (a_old_name, a_new_name), l_buttons.ok_cancel_buttons, l_buttons.ok_button, l_buttons.ok_button, l_buttons.cancel_button)
				l_ed.set_button_text (l_buttons.ok_button, interface_names.b_retry)
				l_ed.set_button_text (l_buttons.cancel_button, interface_names.b_ignore)

				l_win := window_manager.last_focused_development_window.window
				l_win.focus_in_actions.block
				if l_editor /= Void then
					l_editor.editor_drawing_area.focus_in_actions.block
				end
				l_ed.show (l_win)
				l_win.focus_in_actions.resume
				if l_editor /= Void then
					l_editor.editor_drawing_area.focus_in_actions.resume
				end
				l_user_ask_for_retry := l_ed.dialog_result = l_buttons.ok_button
				l_retried := False
			else
				l_user_ask_for_retry := True
			end
			if l_user_ask_for_retry then
				u.rename_file (a_old_name, a_new_name)
			else
				last_saving_success := False
			end
		rescue
			l_retried := True
			retry
		end

	file_save_as (a_text: STRING_GENERAL; a_encoding: ENCODING; a_bom: detachable STRING_8)
			-- Save `a_text' in a file.
		local
			fsd: EB_FILE_SAVE_DIALOG
			l_pref: PATH_PREFERENCE
		do
			l_pref := preferences.dialog_data.last_saved_save_file_as_directory_preference
			if l_pref.value = Void or else l_pref.value.is_empty then
				l_pref.set_value (eiffel_layout.user_projects_path)
			end
			create fsd.make_with_preference (l_pref)
			fsd.save_actions.extend (agent save_file_with_file_name (fsd, a_text, a_encoding, a_bom))
			fsd.show_modal_to_window (window_manager.last_focused_development_window.window)
		end

	save_file_with_file_name (a_fsd: EB_FILE_SAVE_DIALOG; a_text: STRING_GENERAL; a_encoding: ENCODING; a_bom: detachable STRING_8)
		do
			(create {EB_SAVE_FILE}).save (a_fsd.full_file_path.name, a_text, a_encoding, a_bom)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
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
