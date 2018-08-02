note
	description: "Summary description for {ECF_FOREACH_ARGUMENT_PARSER}."
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_FOREACH_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		redefine
			sub_system_name
		end

	ECF_FOREACH_ARGUMENTS

	APPLICATION_COMMAND_ARGUMENT_PARSER

create
	make,
	make_with_source

feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR})
		end

	make_with_source (src: ARGUMENT_SOURCE)
			-- Initialize argument parser
		do
			make
			set_argument_source (src)
		end

feature -- Access

	regexp_pattern: detachable READABLE_STRING_32
			-- Pattern matching ecf file name.
		do
			if has_option (regexp_pattern_switch) and then attached option_of_name (regexp_pattern_switch) as o and then o.has_value then
				Result := o.value
			end
		end

	expression: STRING_32
			-- Expression to evaluate for each ecf file.
		once
			create Result.make_empty
			across
				values as ic
			loop
				if not Result.is_whitespace then
					Result.append_character (' ')
				end
				Result.append (ic.item)
			end
		end

	directories: LIST [PATH]
			-- List of directories to locate ecfs in
		local
			l_options: like values
			d: DIRECTORY
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				create d.make (l_options.item)
				if d.exists and then d.is_readable then
					l_options.forth
				else
					l_options.remove
				end
			end
			create {ARRAYED_LIST [PATH]} Result.make (l_options.count)
			l_options.do_all (agent (s: IMMUTABLE_STRING_32; res: LIST [PATH])
					do
						res.force (create {PATH}.make_from_string (s))
					end (?, Result))
		end

	execution_forced: BOOLEAN
		once
			Result := has_option (execution_forced_switch)
		end

	simulation_enabled: BOOLEAN
		once
			Result := has_option (simulation_switch)
		end

	verbose: BOOLEAN
		once
			Result := has_option (verbose_switch)
		end

	included_paths: detachable LIST [PATH]
			-- Path of file or directory to scan for libraries ecf.
		once
			if
				has_option (include_switch) and then
				attached options_of_name (include_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [PATH]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (create {PATH}.make_from_string (c.item.value))
					end
				end
			end
		end

	excluded_directories: detachable LIST [PATH]
		once
			if
				has_option (exclude_switch) and then
				attached options_of_name (exclude_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [PATH]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (create {PATH}.make_from_string (c.item.value))
					end
				end
			end
		end

feature {NONE} -- Usage

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "command")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Command expression to execute for each ecf file (available variables: {{ecf}}, {{uuid}}, {{system}}, {{target}} )")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Command expression")
		end

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({ECF_UPDATER_COMMAND}.default_name)
		end

	sub_system_name: detachable IMMUTABLE_STRING_32
			-- Sub system name
			-- (from ARGUMENT_BASE_PARSER)
			-- (export status {NONE})
		do
			Result := name
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (6)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (regexp_pattern_switch, "Regexp pattern to match ecf filename", True, False, regexp_pattern_switch, "regexp-pattern", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (include_switch, "Include <directory>", True, True, include_switch, "directory", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (exclude_switch, "Exclude <directory>", True, True, exclude_switch, "directory", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (simulation_switch, "Simulation mode", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (execution_forced_switch, "Execution forced", True, False))
		end

	simulation_switch: STRING = "n|simulation"
	execution_forced_switch: STRING = "f|force"
	regexp_pattern_switch: STRING = "regexp-match"
	include_switch: STRING = "include"
	exclude_switch: STRING = "exclude"
	verbose_switch: STRING = "v|verbose"
	expression_switch: STRING = "e|expression"

feature {NONE} -- Implementation

	exec_env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	current_working_path: PATH
		do
			Result := exec_env.current_working_path
		end

;note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

