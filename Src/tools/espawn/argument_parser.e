note
	description: "[
		Used to parser command-line arguments.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			switch_groups
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize parser
		do
			make_multi_parser (False, True)
			set_is_using_separated_switch_values (False)
		end

feature -- Access

	commands: LINEAR [STRING]
			-- List of commands
		require
			is_successful: is_successful
		once
			Result := values
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	for_32bit: BOOLEAN
			-- Indiciates if tool should be run in a 32bit emulated enironment
		require
			is_successful: is_successful
		do
			Result := not {PLATFORM}.is_64_bits or else has_option (x86_switch)
		ensure
			true_for_64bit: not {PLATFORM}.is_64_bits implies Result
		end

	specific_compiler_code: STRING
			-- The user specified compiler code to use to establish an environment
		require
			is_successful: is_successful
			use_specific_compiler: use_specific_compiler
		do
			if attached option_of_name (use_compiler_switch) as l_option then
				Result := l_option.value
			else
				Result := ""
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	ignore_failures: BOOLEAN
			-- Indicates if process execution failures should be ignored
		require
			is_successful: is_successful
		once
			Result := has_option (ignore_switch)
		end

	manual: BOOLEAN
			-- Inidicates if user wants to manually setup their environment
		require
			is_successful: is_successful
		once
			Result := has_option (manual_switch)
		end

	asynchronous: BOOLEAN
			-- Inidicates if commands should be launched aynchronously
		require
			is_successful: is_successful
		once
			Result := has_option (aync_switch)
		end

	max_jobs: NATURAL_16
			-- Maximum number of jobs used.
		require
			is_successful: is_successful
		once
			if asynchronous then
				if
					attached {ARGUMENT_NATURAL_OPTION} option_of_name (aync_switch) as l_option and then
					l_option.has_value
				then
					Result := l_option.natural_16_value
				end
				if Result = 0 then
					Result := host_cpu_count
				end
			else
				Result := 1
			end
		ensure
			result_positive: Result > 0
		end

	list_available_compilers: BOOLEAN
			-- Indicates if espawn should list the available compiler codes
		require
			is_successful: is_successful
		once
			Result := has_option (list_compilers_switch)
		end

feature -- Status report

	use_specific_compiler: BOOLEAN
			-- Inidicate if a specific compiler code should be used
		require
			is_successful: is_successful
		once
			Result := has_option (use_compiler_switch)
		end

feature {NONE} -- Usage

	copyright: STRING = "Copyright Eiffel Software 1985-2021. All Rights Reserved."
			-- <Precursor>

	name: STRING = "Eiffel Environment Command Spawn Utility"
			-- <Precursor>

	version: STRING
			-- <Precursor>
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append ((create {EIFFEL_CONSTANTS}).two_digit_minimum_minor_version)
		end

	non_switched_argument_description: STRING = "Command or application to execute."
			-- <Precursor>

	non_switched_argument_name: STRING = "command"
			-- <Precursor>

	non_switched_argument_type: STRING = "A command"
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- <Precursor>
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_SWITCH}.make (manual_switch, "Suppresses automatic configuration.", False, False))
			if {PLATFORM}.is_64_bits then
				Result.extend (create {ARGUMENT_SWITCH}.make (x86_switch, "Forces use of a 32bit environment.", True, False))
			else
				Result.extend (create {ARGUMENT_SWITCH}.make_hidden (x86_switch, True, False))
			end
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (use_compiler_switch, "Forces espawn to use an specific environment.", True, False, "code", "The code related to a compiler, use -l to list codes.", False))
			Result.extend (create {ARGUMENT_NATURAL_SWITCH}.make_with_range (aync_switch, "Process commands asynchronously.", True, False, "count", "Number of commands executing concurrently.", True, 1, {NATURAL_16}.max_value))
			Result.extend (create {ARGUMENT_SWITCH}.make (ignore_switch, "Use to ignore failures.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (list_compilers_switch, "List available compiler codes.", False, False))
		end

	switch_groups: ARRAYED_LIST [ARGUMENT_GROUP]
			-- Valid switch grouping
		once
			create Result.make (3)
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (x86_switch), switch_of_name (use_compiler_switch), switch_of_name (aync_switch), switch_of_name (ignore_switch)>>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (manual_switch), switch_of_name (aync_switch), switch_of_name (ignore_switch)>>, True))
			Result.extend (create {ARGUMENT_GROUP}.make (<<switch_of_name (list_compilers_switch), switch_of_name (x86_switch)>>, False))
		end

feature {NONE} -- Switch names

	manual_switch: STRING = "m|manual"
	x86_switch: STRING = "x86"
	aync_switch: STRING = "a|async"
	ignore_switch: STRING = "i|ignore"
	list_compilers_switch: STRING = "l|list"
	use_compiler_switch: STRING = "u|use"

feature {NONE} -- Externals

	host_cpu_count: NATURAL_16
			-- Number of CPUs.
		external
			"C inline use <windows.h>"
		alias
			"[
				{
					SYSTEM_INFO SysInfo;
					ZeroMemory (&SysInfo, sizeof (SYSTEM_INFO));
					GetSystemInfo (&SysInfo);
					return (EIF_NATURAL) SysInfo.dwNumberOfProcessors;
				}
			]"
		end

;note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
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
