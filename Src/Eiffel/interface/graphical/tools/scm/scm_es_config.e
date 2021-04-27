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
			git_command_pref := preferences.source_control_tool_data.git_command_preference
			use_external_git_diff_command_pref := preferences.source_control_tool_data.use_external_git_diff_command_preference
			external_git_diff_command_pref := preferences.source_control_tool_data.external_git_diff_command_preference

			svn_command_pref := preferences.source_control_tool_data.svn_command_preference
			external_svn_diff_command_pref := preferences.source_control_tool_data.external_svn_diff_command_preference
			use_external_svn_diff_command_pref := preferences.source_control_tool_data.use_external_svn_diff_command_preference
		end

feature {NONE} -- Preferences

	git_command_pref: STRING_PREFERENCE

	svn_command_pref: STRING_PREFERENCE

	external_git_diff_command_pref: STRING_PREFERENCE

	external_svn_diff_command_pref: STRING_PREFERENCE

	use_external_git_diff_command_pref: BOOLEAN_PREFERENCE

	use_external_svn_diff_command_pref: BOOLEAN_PREFERENCE

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

	use_external_git_diff_command: BOOLEAN
		do
			Result := use_external_git_diff_command_pref.value
		end

	use_external_svn_diff_command: BOOLEAN
		do
			Result := use_external_svn_diff_command_pref.value
		end

	external_git_diff_command (a_location: detachable PATH): detachable STRING_32
		local
			fn: READABLE_STRING_32
		do
			Result := external_git_diff_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
			if Result /= Void and a_location /= Void then
				fn := a_location.name
				if fn.has (' ') then
					fn := {STRING_32} "%"" + fn + {STRING_32} "%""
				end
				Result := expanded_string (Result, <<["$location", fn]>>)
			elseif Result = Void and not use_external_git_diff_command  then
				Result := "path-to-git-diff-tool $location"
			end
		end

	external_svn_diff_command (a_location: detachable PATH): detachable STRING_32
		local
			fn: READABLE_STRING_32
		do
			Result := external_svn_diff_command_pref.value
			if Result.is_whitespace then
				Result := Void
			end
			if Result /= Void and a_location /= Void then
				fn := a_location.name
				if fn.has (' ') then
					fn := {STRING_32} "%"" + fn + {STRING_32} "%""
				end
				Result := expanded_string (Result, <<["$location", fn]>>)
			elseif Result = Void and not use_external_svn_diff_command  then
				Result := "path-to-svn-diff-tool $location"
			end
		end

	expanded_string (a_pattern: READABLE_STRING_GENERAL; a_values: ITERABLE [TUPLE [name: READABLE_STRING_GENERAL; text: READABLE_STRING_GENERAL]]): STRING_32
		local
			i: INTEGER
		do
			create Result.make_from_string_general (a_pattern)
			i := 0
			across
				a_values as ic
			loop
				i := i + 1
				Result.replace_substring_all (ic.item.name, ic.item.text)
				Result.replace_substring_all ("$" + i.out, ic.item.text)
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

	set_use_external_git_diff_command (v: BOOLEAN)
		do
			use_external_git_diff_command_pref.set_value (v)
		end

	set_use_external_svn_diff_command (v: BOOLEAN)
		do
			use_external_svn_diff_command_pref.set_value (v)
		end

	set_external_git_diff_command (v: READABLE_STRING_GENERAL)
		do
			external_git_diff_command_pref.set_value_from_string (v)
		end

	set_external_svn_diff_command (v: READABLE_STRING_GENERAL)
		do
			external_svn_diff_command_pref.set_value_from_string (v)
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
