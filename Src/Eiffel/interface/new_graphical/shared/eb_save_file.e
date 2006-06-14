indexing
	description: "Class to save a file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Patrick Ruckstuhl"
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

feature -- Access

	last_saving_date: INTEGER
			-- The date of the last save operation.

	last_saving_success: BOOLEAN
			-- Was the last saving successful?

feature -- Basic operations

	load (a_file_name: STRING): STRING is
			-- Load the text from `a_file_name'
		require
			a_file_name_not_void: a_file_name /= Void
		do

		end


	save (a_file_name: STRING; a_text: STRING) is
			-- Save `a_text' into `a_file_name'. Creates file if it doesn't already exist.
		require
			a_file_name_not_void: a_file_name /= Void
		local
			new_file, tmp_file: RAW_FILE -- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			aok, create_backup, new_created: BOOLEAN
			tmp_name: STRING
			wd: EV_WARNING_DIALOG
		do
				-- Always assume a saving is successful.
			last_saving_success := True
			create new_file.make (a_file_name)

			aok := True
			if not new_file.exists then
				if not new_file.is_creatable then
					aok := False
					create wd.make_with_text (warning_messages.w_not_creatable (new_file.name))
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					new_created := True
				end
			else
				if not new_file.is_plain then
					aok := False
					create wd.make_with_text (warning_messages.w_not_a_plain_file (new_file.name))
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				elseif not new_file.is_writable then
					aok := False
					create wd.make_with_text (warning_messages.w_not_writable (new_file.name))
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				end
			end

			-- Create a backup of the file in case there will be a problem during the savings.
			tmp_name := a_file_name.twin
			tmp_name.append (".swp")
			create tmp_file.make (tmp_name)
			create_backup := not new_created and not tmp_file.exists and then tmp_file.is_creatable
			if not create_backup then
				tmp_file := new_file
			end
			if aok then
				tmp_file.open_write
				if not a_text.is_empty then
					a_text.prune_all ('%R')
					if a_text.item (a_text.count) /= '%N' then
						-- Add a carriage return like `vi' if there's none at the end
						a_text.extend ('%N')
					end
					if preferences.misc_data.text_mode_is_windows then
						a_text.replace_substring_all ("%N", "%R%N")
					end
					tmp_file.put_string (a_text)
				end
				tmp_file.close
				if create_backup then
					robust_rename (tmp_file, a_file_name)
				elseif last_saving_success then
					create new_file.make (tmp_name)
					if new_file.exists then
						robust_delete (new_file)
					end
				end
				if last_saving_success then
					last_saving_date := tmp_file.date
				end
				workbench.set_changed
			end
		end

feature {NONE} -- Implementation

	robust_delete (a_file: FILE) is
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

	robust_rename (a_file: FILE; a_new_name: STRING) is
			-- More robust version of change_name, which tries multiple times before giving up.
		require
			a_file_ok: a_file /= Void
			a_new_name_ok: a_new_name /= Void and then not a_new_name.is_empty
		local
			l_retried, l_user_ask_for_retry: BOOLEAN
			l_ed: EV_ERROR_DIALOG
			l_win: EV_WINDOW
		do
			if l_retried then
				create l_ed.make_with_text (warning_messages.w_Not_rename_swp (a_file.name, a_new_name))
				l_ed.set_buttons (<<ev_retry, ev_ignore>>)
				l_win := window_manager.last_focused_development_window.window
				l_win.focus_in_actions.block
				window_manager.last_focused_development_window.editor_tool.text_area.editor_drawing_area.focus_in_actions.block
				l_ed.show_modal_to_window (l_win)
				l_win.focus_in_actions.resume
				window_manager.last_focused_development_window.editor_tool.text_area.editor_drawing_area.focus_in_actions.resume
				l_user_ask_for_retry := l_ed.selected_button.is_equal (ev_retry)
				l_retried := False
			else
				l_user_ask_for_retry := True
			end
			if l_user_ask_for_retry then
				a_file.change_name (a_new_name)
			else
				last_saving_success := False
			end
		rescue
			l_retried := True
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
