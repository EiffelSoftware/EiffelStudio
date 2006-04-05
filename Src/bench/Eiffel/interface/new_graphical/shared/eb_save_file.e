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

feature -- Access

	last_saving_date: INTEGER
			-- The date of the last save operation.

	last_saving_success: BOOLEAN
			-- Was the last saving successful?

feature -- Basic operations

	load (a_file_name: STRING): STRING is
			-- Load the text from `a_file_name'
		require
			a_file_name_not_void: a_file_name /= void
		do

		end


	save (a_file_name: STRING; a_text: STRING) is
			-- Save `a_text' into `a_file_name'. Creates file if it doesn't already exist.
		require
			a_file_name_not_void: a_file_name /= void
		local
			new_file, tmp_file: RAW_FILE -- It should be PLAIN_TEXT_FILE, however windows will expand %R and %N as %N
			aok, create_backup, new_created: BOOLEAN
			tmp_name: STRING
			wd: EV_WARNING_DIALOG
		do
			create new_file.make (a_file_name)

			aok := True
			if not new_file.exists then
				if not new_file.is_creatable then
					aok := False
					create wd.make_with_text (warning_messages.w_not_creatable (new_file.name))
					wd.show_modal_to_window (window_manager.last_focused_development_window.window)
				else
					new_created := true
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
					-- We need to copy the backup file to the original file and then
					-- delete the backup file
					new_file.delete
					tmp_file.change_name (a_file_name)
				end
				last_saving_date := tmp_file.date
				last_saving_success := true
			end
		end


feature {NONE} -- Implementation

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
