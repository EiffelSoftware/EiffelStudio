indexing
	description: "Objects that saves a string to a .txt file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SAVE_STRING_TOOL

inherit
	EB_CONSTANTS

	FILE_DIALOG_CONSTANTS

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make,
	make_and_save

feature{NONE} -- Initialization

	make (win: EV_WINDOW) is
			-- Display warning dialog in `win' if necessary.
		require
			win_not_void: win /= Void
		do
			owner_window := win
			title := "Save output to file"
		ensure
			owner_window_set: owner_window = win
		end

	make_and_save (str: STRING; win: EV_WINDOW) is
			-- Save `str' to a file.
			-- Display warning dialog in `win' if necessary.
		require
			str_not_void: str /= Void
			win_not_void: win /= Void
		do
			make (win)
			text := str
			save
		ensure
			text_set: text = str
		end

feature -- Change

	set_text (t: like text) is
			-- Set `text' to `t'
		do
			text := t
		end

	set_title (t: like title) is
			-- Set `title' to `t'
		do
			title := t
		end

feature {NONE} -- Implementation

	owner_window: EV_WINDOW
		-- Onwer window.

	text: STRING
		-- Text to be saved.

	title: STRING_GENERAL
		-- Dialog's title.

	save_file_dlg: EV_FILE_SAVE_DIALOG
			-- File dialog to let user choose a file.

feature -- Save

	save  is
			-- Save `text' to file.
		do
			if text.is_empty then
				prompts.show_warning_prompt ("No text to save.", owner_window, Void)
			else
				select_file_and_save
			end
		end

	select_file_and_save is
			-- Called when user press Save output button.
		do
			create save_file_dlg.make_with_title (title)
			save_file_dlg.filters.extend ([Text_files_filter, Text_files_description])
			save_file_dlg.filters.extend ([All_files_filter, All_files_description])
			save_file_dlg.save_actions.extend (agent on_save_file_selected)
			save_file_dlg.show_modal_to_window (owner_window)
			save_file_dlg.destroy
		end

	on_save_file_selected is
			-- Called when user chosed a file to store process output.
		local
			f: PLAIN_TEXT_FILE
			retried: BOOLEAN
			str: STRING
			filter_str: STRING
			l_count, l_count2: INTEGER
			l_selected_filter_index: INTEGER
		do
			if not retried then
				if save_file_dlg /= Void then
					create str.make_from_string (save_file_dlg.file_name)
					l_selected_filter_index := save_file_dlg.selected_filter_index
					if l_selected_filter_index /= 0 and then not save_file_dlg.filters.i_th (l_selected_filter_index).filter.as_string_8.is_equal (All_files_filter) then
						filter_str := save_file_dlg.filters.i_th (save_file_dlg.selected_filter_index).filter.as_string_8
						if filter_str.item (1) = '*' then
							filter_str.remove (1)
						end
						l_count := filter_str.count
						l_count2 := str.count
						if l_count2 > l_count then
							if not str.substring (l_count2 - l_count + 1, str.count).is_case_insensitive_equal (filter_str) then
								str.append (filter_str)
							end
						else
							str.append (filter_str)
						end
					end
					save_file_dlg.destroy
					create f.make (str)
					if f.exists then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
							Warning_messages.w_File_exists (str), owner_window, agent on_overwrite_file (str), Void)
					else
						on_overwrite_file (str)
					end
				end

			end
		rescue
			retried := True
			prompts.show_error_prompt (Warning_messages.w_cannot_save_file (str), owner_window, Void)
			retry
		end

	on_overwrite_file (file_name: STRING) is
			-- Agent called when save text from `console' to an existing file
		local
			f: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_create_read_write (file_name)
				f.put_string (text)
				f.close
			end
		rescue
			retried := True
			prompts.show_error_prompt (Warning_messages.w_cannot_save_file (file_name), owner_window, Void)
			retry
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
