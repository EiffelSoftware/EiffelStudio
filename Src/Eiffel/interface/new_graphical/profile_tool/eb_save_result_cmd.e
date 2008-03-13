indexing
	description	: "Command to save the query and options currently displayed in a PROFILE_QUERY_WINDOW"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class EB_SAVE_RESULT_CMD

inherit
	EB_FILE_OPENER_CALLBACK

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_query_window: EB_PROFILE_QUERY_WINDOW) is
			-- Create Current and set `query_window' to `a_query_window'.
		require
			a_query_window_not_void: a_query_window /= Void
		do
			query_window := a_query_window
		ensure
			query_window_set: query_window.is_equal (a_query_window)
		end

feature {EB_PROFILE_QUERY_WINDOW} -- Command Execution

	execute is
			-- Execute Current
		local
			fsd: EB_FILE_SAVE_DIALOG
			l_pref: STRING_PREFERENCE
		do
			l_pref := preferences.dialog_data.last_saved_profile_result_directory_preference
			if l_pref.value = Void or else l_pref.value.is_empty then
				l_pref.set_value (eiffel_layout.user_projects_path.string)
			end
			create fsd.make_with_preference (l_pref)
			fsd.save_actions.extend (agent save_in (fsd))
			fsd.show_modal_to_window (query_window)
		end

feature -- Access

	save_in (dialog: EB_FILE_SAVE_DIALOG) is
			-- Save options, result, and query
			-- to file chosen in `dialog'.
		require
			dialog_exists: dialog /= Void
		local
			file_name: STRING
			file_opener: EB_FILE_OPENER
		do
			file_name := dialog.file_name.twin
			create file_opener.make_with_parent (Current, file_name, query_window)
		end

feature {EB_FILE_OPENER} -- Callbacks

	save_file (ptf: RAW_FILE) is
		do
			query_window.save_it (ptf)
		end

feature {NONE} -- Attributes

	query_window: EB_PROFILE_QUERY_WINDOW;

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

end -- class EB_SAVE_RESULT_CMD
