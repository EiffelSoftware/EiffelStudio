note
	description: "Summary description for {SCM_FLAT_CONFIG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_FLAT_CONFIG

inherit
	SCM_CONFIG

create
	make_from_config

feature {NONE} -- Initialization

	make_from_config (cfg: SCM_CONFIG)
		do
			use_external_git_diff_command := cfg.use_external_git_diff_command
			use_external_svn_diff_command := cfg.use_external_svn_diff_command
			status_auto_check_enabled := cfg.status_auto_check_enabled
		end

feature -- Access

	git_command: detachable READABLE_STRING_32

	svn_command: detachable READABLE_STRING_32

	status_auto_check_enabled: BOOLEAN

	use_external_git_diff_command: BOOLEAN

	use_external_svn_diff_command: BOOLEAN

	external_git_diff_command_value: detachable READABLE_STRING_32

	external_svn_diff_command_value: detachable READABLE_STRING_32

	external_git_diff_command (a_location: detachable PATH): detachable READABLE_STRING_32
		local
			fn: READABLE_STRING_32
		do
			Result := external_git_diff_command_value
			if Result /= Void and then Result.is_whitespace then
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

	external_svn_diff_command (a_location: detachable PATH): detachable READABLE_STRING_32
		local
			fn: READABLE_STRING_32
		do
			Result := external_svn_diff_command_value
			if Result /= Void and then Result.is_whitespace then
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
			git_command := v
		end

	set_svn_command (v: READABLE_STRING_GENERAL)
		do
			svn_command := v
		end

	set_use_external_git_diff_command (v: BOOLEAN)
		do
			use_external_git_diff_command := v
		end

	set_use_external_svn_diff_command (v: BOOLEAN)
		do
			use_external_svn_diff_command := v
		end

	set_external_git_diff_command (v: READABLE_STRING_GENERAL)
		do
			external_git_diff_command_value := v
		end

	set_external_svn_diff_command (v: READABLE_STRING_GENERAL)
		do
			external_svn_diff_command_value := v
		end

	set_status_auto_check_enabled (b: BOOLEAN)
		do
			status_auto_check_enabled := b
		end


note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
