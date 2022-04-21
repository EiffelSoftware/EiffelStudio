note
	description: "Configuration for the SCM service."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_CONFIG

feature -- Access

	default_git_command: STRING_32 = "git"

	default_svn_command: STRING_32 = "svn"

	git_command: detachable READABLE_STRING_32
		deferred
		end

	svn_command: detachable READABLE_STRING_32
		deferred
		end

	use_external_git_diff_command: BOOLEAN
		deferred
		end

	use_external_svn_diff_command: BOOLEAN
		deferred
		end

	external_git_diff_command (a_location: detachable PATH): detachable READABLE_STRING_32
		deferred
		end

	external_svn_diff_command (a_location: detachable PATH): detachable READABLE_STRING_32
		deferred
		end

	status_auto_check_enabled: BOOLEAN
			-- Is automatically checking status ?
		deferred
		end

	show_unversioned_files_enabled: BOOLEAN
			-- Unversioned files shown?
		deferred
		end

	hide_location_with_no_change_enabled: BOOLEAN
			-- Hide location with no change?
		deferred
		end

feature -- Element change

	set_svn_command (v: READABLE_STRING_GENERAL)
		deferred
		end

	set_git_command (v: READABLE_STRING_GENERAL)
		deferred
		end

	set_use_external_svn_diff_command (v: BOOLEAN)
		deferred
		end

	set_use_external_git_diff_command (v: BOOLEAN)
		deferred
		end

	set_external_svn_diff_command (v: READABLE_STRING_GENERAL)
		deferred
		end

	set_external_git_diff_command (v: READABLE_STRING_GENERAL)
		deferred
		end

	set_status_auto_check_enabled (b: BOOLEAN)
		deferred
		end

	set_show_unversioned_files (b: BOOLEAN)
		deferred
		end

	set_hide_location_with_no_change (b: BOOLEAN)
		deferred
		end

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
