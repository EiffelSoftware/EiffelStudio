note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_ES_CONFIG

inherit
	SCM_CONFIG

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		do
			git_command_pref := preferences.misc_data.git_command_preference
			svn_command_pref := preferences.misc_data.svn_command_preference
			git_diff_command_pref := preferences.misc_data.git_diff_command_preference
			svn_diff_command_pref := preferences.misc_data.svn_diff_command_preference

		end

feature {NONE} -- Preferences

	git_command_pref: STRING_PREFERENCE

	svn_command_pref: STRING_PREFERENCE

	git_diff_command_pref: STRING_PREFERENCE

	svn_diff_command_pref: STRING_PREFERENCE

feature -- Access

	git_command: detachable STRING_32
		do
			Result := git_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
		end

	svn_command: detachable STRING_32
		do
			Result := svn_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
		end

	git_diff_command: detachable STRING_32
		do
			Result := git_diff_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
		end

	svn_diff_command: detachable STRING_32
		do
			Result := svn_diff_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
		end

feature -- Element change

	set_git_command (v: READABLE_STRING_GENERAL)
		do
			git_command_pref.set_value_from_string (v)
		end

	set_svn_command (v: READABLE_STRING_GENERAL)
		do
			svn_command_pref.set_value_from_string (v)
		end

	set_git_diff_command (v: READABLE_STRING_GENERAL)
		do
			git_diff_command_pref.set_value_from_string (v)
		end

	set_svn_diff_command (v: READABLE_STRING_GENERAL)
		do
			svn_diff_command_pref.set_value_from_string (v)
		end

invariant

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
