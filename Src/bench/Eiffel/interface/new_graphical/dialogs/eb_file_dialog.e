indexing
	description: "[
		Objects that represent file dialogs which remember their previous directory
		if the "preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory" preference
		is True
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FILE_DIALOG
	
inherit
	EV_FILE_DIALOG
		redefine
			show_modal_to_window
		end
		
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end
			
feature {NONE} -- Initialization
	
	make_with_preference (a_preference: STRING_PREFERENCE) is
			-- Create `Current' and assign `a_preference' to `preference'.
		require
			a_preference_not_void: a_preference /= Void
		do
			default_create
			preference := a_preference
		end
		
feature -- Access

	preference: STRING_PREFERENCE
		-- Preference associated with `Current' which
		-- stores the last selected directory opened

feature -- Status setting

	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show `Current' modal to window `a_window'.
		local
			last_directory: STRING
			dir: DIRECTORY
		do
			last_directory := preference.string_value
			if not last_directory.is_empty then
					-- Nothing to do if the preference is empty.
				create dir.make (last_directory)
				if dir.exists and preferences.dialog_data.file_open_and_save_dialogs_remember_last_directory.value then
						-- Only set the start directory if the directory exists and the remember preference is enabled.
					set_start_directory (last_directory)
				end
			end
			Precursor {EV_FILE_DIALOG} (a_window)
			update_preference
		end		

	update_preference is
			-- Update value of `preference' from `file_path'.
		do
			if not file_path.is_empty then
				preference.set_value (file_path)
			end
		end

invariant
	preference_not_void: preference /= Void

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
