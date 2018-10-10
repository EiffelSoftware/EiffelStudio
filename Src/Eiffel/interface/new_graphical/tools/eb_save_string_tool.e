note
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

	SHARED_LOCALE
		export
			{NONE} all
		end

create
	make,
	make_and_save

feature{NONE} -- Initialization

	make (win: EV_WINDOW)
			-- Display warning dialog in `win' if necessary.
		require
			win_not_void: win /= Void
		do
			owner_window := win
			title := "Save output to file"
		ensure
			owner_window_set: owner_window = win
		end

	make_and_save (str: STRING_32; win: EV_WINDOW)
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

	set_text (t: like text)
			-- Set `text' to `t'
		do
			text := t
		end

	set_title (t: like title)
			-- Set `title' to `t'
		do
			title := t
		end

	set_filter_for_extensions (a_extensions: ITERABLE [READABLE_STRING_GENERAL]; a_description: READABLE_STRING_GENERAL)
			-- Set file dialog filters for `a_extensions` and `a_description`.
		local
			f: STRING_32
			l_filters: like filters
		do
			create f.make_empty
			across
				a_extensions as ic
			loop
				if f.count > 0 then
					f.append_character (';')
				end
				f.append_string_general ("*.")
				f.append_string_general (ic.item)
			end

			l_filters := filters
			if l_filters = Void then
				create l_filters.make (1)
				filters := l_filters
			end
			l_filters.extend ([f, a_description])
		end

	set_start_directory (dn: detachable READABLE_STRING_GENERAL)
			-- Set file dialog starting directory with directory name `dn`.
		do
			start_directory := dn
		end

	set_start_path (p: detachable PATH)
			-- Set file dialog starting directory with directory path `dn`.
		do
			if p = Void then
				set_start_directory (Void)
			else
				set_start_directory (p.name)
			end
		end

	set_filename (fn: detachable READABLE_STRING_GENERAL)
		do
			if fn = Void then
				filename := Void
			else
				filename := fn
			end
		end

feature {NONE} -- Implementation

	start_directory: detachable READABLE_STRING_GENERAL
			-- Starting directory.

	filename: detachable READABLE_STRING_GENERAL
			-- Suggested filename.

	owner_window: EV_WINDOW
			-- Owner window.

	text: STRING_32
			-- Text to be saved.

	title: STRING_GENERAL
			-- Dialog's title.

	save_file_dlg: EV_FILE_SAVE_DIALOG
			-- File dialog to let user choose a file.

	filters: detachable ARRAYED_LIST [TUPLE [filter, text: READABLE_STRING_GENERAL]]

feature -- Save

	save
			-- Save `text' to file.
		do
			if text.is_empty then
				prompts.show_warning_prompt ("No text to save.", owner_window, Void)
			else
				select_file_and_save
			end
		end

	select_file_and_save
			-- Called when user press Save output button.
		do
			create save_file_dlg.make_with_title (title)
			if attached start_directory as dn then
				save_file_dlg.set_start_directory (dn)
			end
			if attached filename as fn then
				save_file_dlg.set_file_name (fn)
			end
			if attached filters as l_filters and then not l_filters.is_empty then
				across
					l_filters as ic
				loop
					save_file_dlg.filters.extend (ic.item)
				end
			else
				save_file_dlg.filters.extend ([Text_files_filter, Text_files_description])
				save_file_dlg.filters.extend ([All_files_filter, All_files_description])
			end
			save_file_dlg.save_actions.extend (agent on_save_file_selected)
			save_file_dlg.show_modal_to_window (owner_window)
			save_file_dlg.destroy
		end

	on_save_file_selected
			-- Called when user chosed a file to store process output.
		local
			f: PLAIN_TEXT_FILE
			retried: BOOLEAN
			str: PATH
			filter_str: STRING_32
			l_selected_filter_index: INTEGER
		do
			if not retried then
				if save_file_dlg /= Void then
					str := save_file_dlg.full_file_path
					l_selected_filter_index := save_file_dlg.selected_filter_index
					if l_selected_filter_index /= 0 and then not save_file_dlg.filters.i_th (l_selected_filter_index).filter.same_string (All_files_filter) then
						filter_str := save_file_dlg.filters.i_th (save_file_dlg.selected_filter_index).filter.as_string_32
						if filter_str.count > 1 and then filter_str.item (1) = '*' then
							filter_str.remove_head (1)
						end
						if filter_str.count > 1 and then filter_str.item (1) = '.' then
							filter_str.remove_head (1)
						end
						if not str.has_extension (filter_str) then
								-- There was either no extension or an extension that did not match `filter_str'
							str := str.appended_with_extension (filter_str)
						end
					end
					save_file_dlg.destroy
					create f.make_with_path (str)
					if f.exists then
						(create {ES_SHARED_PROMPT_PROVIDER}).prompts.show_question_prompt (
							Warning_messages.w_file_exists (str.name), owner_window, agent on_overwrite_file (str), Void)
					else
						on_overwrite_file (str)
					end
				end

			end
		rescue
			retried := True
			prompts.show_error_prompt (Warning_messages.w_cannot_save_file (str.name), owner_window, Void)
			retry
		end

	on_overwrite_file (file_name: PATH)
			-- Agent called when save text from `console' to an existing file
		local
			f: PLAIN_TEXT_FILE
			retried: BOOLEAN
		do
			if not retried then
				create f.make_with_path (file_name)
				f.create_read_write
				save_string_in_file (f, text)
				f.close
			end
		rescue
			retried := True
			prompts.show_error_prompt (Warning_messages.w_cannot_save_file (file_name.name), owner_window, Void)
			retry
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
