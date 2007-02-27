indexing
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
			make as make_parser
		export
			{NONE} all
			{ANY} successful, execute
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize parser
		do
			make_parser (False, True, False)
			set_show_switch_arguments_inline (True)
			if not {PLATFORM}.is_windows  then
				set_use_separated_switch_values (True)
			end
		end

feature -- Access

	commands: LINEAR [STRING] is
			-- List of commands
		require
			successful: successful
		once
			Result := values
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	for_32bit: BOOLEAN is
			-- Indiciates if tool should be run in a 32bit emulated enironment
		do
			Result := not {C_CONFIG_MANAGER}.is_windows_x64 or else has_option (x86_switch)
		ensure
			true_for_64bit: not {C_CONFIG_MANAGER}.is_windows_x64 implies Result
		end

	ignore_failures: BOOLEAN is
			-- Indicates if process execution failures should be ignored
		require
			successful: successful
		once
			Result := has_option (ignore_switch)
		end

	manual: BOOLEAN is
			-- Inidicates if user wants to manually setup their environment
		require
			successful: successful
		once
			Result := has_option (manual_switch)
		end

	asynchronous: BOOLEAN is
			-- Inidicates if commands should be launched aynchronously
		require
			successful: successful
		once
			Result := has_option (aync_switch)
		end

	max_processors: NATURAL_16 is
			-- Maximum number of processors to untilize
		require
			successful: successful
		local
			l_option: ARGUMENT_NATURAL_OPTION
		once
			if asynchronous then
				l_option ?= option_of_name (aync_switch)
				if l_option /= Void and then l_option.has_value then
					Result := l_option.natural_16_value
				end
				if Result = 0 or Result > resident_cpu_count then
					Result := resident_cpu_count
				end
			else
				Result := 1
			end
		ensure
			result_positive: Result > 0
		end

feature {NONE} -- Usage

	name: STRING_8 = "Eiffel Environment Command Spawn Utility"
			-- Full name of application

	version: STRING_8 = "6.0"
			-- Version number of application

	loose_argument_description: STRING_8 = "Command or application to execute."
			-- Description of lose argument, used in usage information

	loose_argument_name: STRING_8 = "command"
			-- Name of lose argument, used in usage information

	loose_argument_type: STRING_8 = "A command"
			-- Type of lose argument, used in usage information.
			-- A type is a short description of the argument. I.E. "Configuration File"

	switches: ARRAYED_LIST [ARGUMENT_SWITCH] is
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (1)
			Result.extend (create {ARGUMENT_SWITCH}.make (manual_switch, "Supresses automatic configuration", True, False))
			if {C_CONFIG_MANAGER}.is_windows_x64 then
				Result.extend (create {ARGUMENT_SWITCH}.make (x86_switch, "Forces use of a 32bit environment, ignored if -" + manual_switch + " is used.", True, False))
			else
				Result.extend (create {ARGUMENT_SWITCH}.make_hidden (x86_switch, "Ineffective.", True, False))
			end
			Result.extend (create {ARGUMENT_NATURAL_SWITCH}.make_with_range (aync_switch, "Process commands asynchronously", True, False, "count", "Number of processors to utilize", True, 1, {NATURAL_16}.max_value))
			Result.extend (create {ARGUMENT_SWITCH}.make (ignore_switch, "Use to ignore failures", True, False))

		end

feature {NONE} -- Switch names

	manual_switch: STRING = "manual"
	x86_switch: STRING = "x86"
	aync_switch: STRING = "async"
	ignore_switch: STRING = "ignore"

feature {NONE} -- Externals

	resident_cpu_count: NATURAL_16 is
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

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
