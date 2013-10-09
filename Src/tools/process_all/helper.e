note
	description: "Helper"
	date: "$Date$"
	revision: "$Revision$"

class
	HELPER

feature -- Helper

	logs_filename (a_logs_dir: detachable PATH; a_action_mode: READABLE_STRING_GENERAL; a_target: separate CONF_TARGET): PATH
		require
			a_action_mode_not_void: a_action_mode /= Void
			a_target_not_void: a_target /= Void
		local
			l_logs_file_name: STRING_32
			l_system: separate CONF_SYSTEM
			l_entry: STRING_32
		do
			l_system := target_system (a_target)
			if attached system_path (l_system) as l_path and then attached l_path.entry as l_e then
				l_entry := l_e.name
			else
				l_entry := "no_ecf_path"
			end
			l_logs_file_name := l_entry + "-" + system_name (l_system) + "-" + any_out (system_uuid (l_system)) + "-" + target_name (a_target) + "-" + a_action_mode + ".log"
			if attached a_logs_dir as l_logs_dir then
				Result := l_logs_dir
			else
				create Result.make_current
			end
			Result := Result.extended (l_logs_file_name)
		end

feature {NONE} -- Separate wrappers

	target_name (a_target: separate CONF_TARGET): STRING_32
			-- Target name
		do
			create Result.make_from_separate (a_target.name)
		end

	system_name (a_system: separate CONF_SYSTEM): STRING_32
			-- System name
		do
			create Result.make_from_separate (a_system.name)
		end

	system_file_name (a_system: separate CONF_SYSTEM): STRING_32
			-- System file name
		do
			create Result.make_from_separate (a_system.file_name)
		end

	system_path (a_system: separate CONF_SYSTEM): PATH
			-- System path
		do
			create Result.make_from_separate (a_system.file_path)
		end

	system_uuid (a_system: separate CONF_SYSTEM): separate UUID
			-- System file name
		do
			Result := a_system.uuid
		end

	target_system (a_target: separate CONF_TARGET): separate CONF_SYSTEM
			-- Target system
		do
			Result := a_target.system
		end

	target_setting_msil_generation (a_target: separate CONF_TARGET): BOOLEAN
		do
			Result := a_target.setting_msil_generation
		end

	any_out (a_any: separate ANY): STRING
			-- Out from separate ANY
		do
			create Result.make_from_separate (a_any.out)
		end

feature -- Regex

	test_pass_output_regex: REGULAR_EXPRESSION
			-- Regex to extract test results
		once
			create Result
			Result.compile ("[a-zA-Z0-9-_]+ \([a-zA-Z0-9-_]+\): Pass")
		end

	test_output_regex: REGULAR_EXPRESSION
			-- Regex to extract test results
		once
			create Result
			Result.compile ("[a-zA-Z0-9-_]+ \([a-zA-Z0-9-_]+\): .*")
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
