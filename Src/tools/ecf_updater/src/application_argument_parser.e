note
	description: "Summary description for {APPLICATION_ARGUMENT_PARSER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION_ARGUMENT_PARSER

inherit
	ARGUMENT_MULTI_PARSER
		rename
			make as make_multi_parser
		end

	APPLICATION_ARGUMENTS

	SHARED_FILE_SYSTEM

create
	make


feature {NONE} -- Initialization

	make
			-- Initialize argument parser
		do
			make_multi_parser (False, False)
			set_non_switched_argument_validator (create {ARGUMENT_FILE_OR_DIRECTORY_VALIDATOR})
		end

feature -- Access

	copyright: STRING
			-- <Precursor>
		once
			Result := "Copyright Eiffel Software 2011-2012. All Rights Reserved."
		end

	files: LIST [STRING]
			-- List of files to resave
		local
			l_options: like values
			l_result: ARRAYED_LIST [attached STRING]
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				if not file_system.is_file_readable (l_options.item) then
					l_options.remove
				else
					l_options.forth
				end
			end
			create l_result.make (l_options.count)
			l_options.do_all (agent l_result.force)
			Result := l_result
		end

	directories: LIST [STRING]
			-- List of directories to locate ecfs in
		local
			l_options: like values
			l_result: ARRAYED_LIST [attached STRING]
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				if not file_system.is_directory_readable (l_options.item) then
					l_options.remove
				else
					l_options.forth
				end
			end
			create l_result.make (l_options.count)
			l_options.do_all (agent l_result.force)
			Result := l_result
		end

	replacements: detachable LIST [STRING]
			-- List of replacements
		once
			if
				has_option (replace_switch) and then
				attached options_of_name (replace_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end

	variable_expansions: detachable LIST [STRING]
			-- List of variable expansions
		once
			if
				has_option (variable_expansions_switch) and then
				attached options_of_name (variable_expansions_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value)
					end
				end
			end
		end


--	use_directory_recursion: BOOLEAN
--			-- Indicates if directories should be recursively scanned
--		once
--			Result := has_option (recursive_switch)
--		end

	execution_forced: BOOLEAN
		once
			Result := has_option (force_switch)
		end

	backup_enabled: BOOLEAN
		once
			Result := has_option (backup_switch)
		end

	simulation_enabled: BOOLEAN
		once
			Result := has_option (simulation_switch)
		end

	diff_enabled: BOOLEAN
		once
			Result := has_option (diff_switch)
		end

	verbose: BOOLEAN
		once
			Result := has_option (verbose_switch)
		end

	root_directory: STRING
		once
			if has_option (root_switch) and then attached option_of_name (root_switch) as o and then o.has_value then
				Result := o.value
			else
				Result := current_working_directory -- Current working directory
			end
		end

	base_name: detachable STRING
		once
			if has_option (eiffel_library_switch) then
				Result := "$EIFFEL_LIBRARY"
			elseif has_option (ise_library_switch) then
				Result := "$ISE_LIBRARY"
			elseif has_option (base_variable_switch) and then attached option_of_name (base_variable_switch) as o and then o.has_value then
				Result := "$" + o.value
			elseif has_option (base_switch) and then attached option_of_name (base_switch) as o and then o.has_value then
				Result := o.value
			end
		end

feature {NONE} -- Usage

	non_switched_argument_name: STRING = "path"
			--  <Precursor>

	non_switched_argument_description: STRING = "Eiffel configuration file or directory"
			--  <Precursor>

	non_switched_argument_type: STRING = "Eiffel configuration file/directory"
			--  <Precursor>

	name: STRING
		once
			Result := {APPLICATION_CONSTANTS}.executable_name
		end

	version: attached STRING
			--  <Precursor>
		once
			create Result.make (5)
			Result.append_natural_16 ({APPLICATION_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_natural_16 ({APPLICATION_CONSTANTS}.minor_version)
		end

feature {NONE} -- Switches

	switches: attached ARRAYED_LIST [attached ARGUMENT_SWITCH]
			-- Retrieve a list of switch used for a specific application
		once
			create Result.make (12)
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (root_switch, "Root directory", True, False, root_switch, "Root directory", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (force_switch, "Force execution without any confirmation", True, False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (base_switch, "Base name", True, False, base_switch, "Could be $ISE_LIBRARY", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (base_variable_switch, "Base variable name", True, False, base_variable_switch, "Could be ISE_LIBRARY", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (ise_library_switch, "Use $ISE_LIBRARY for 'base'", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (eiffel_library_switch, "Use $EIFFEL_LIBRARY for 'base'", True, False))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (replace_switch, "Replace ", True, True, replace_switch, "use FOO=BAR to replace FOO with BAR (case sensitive)", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (variable_expansions_switch, "Expand variable VAR with value", True, True, replace_switch, "use VAR=value to expand VAR environment variable with 'value'", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (verbose_switch, "Verbose output", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (backup_switch, "Backup modified files", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (simulation_switch, "Simulation mode", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (diff_switch, "Display diff", True, False))

		end

	diff_switch: STRING = "d|diff"
	backup_switch: STRING = "b|backup"
	simulation_switch: STRING = "n|simulation"
	root_switch: STRING = "r|root"
	force_switch: STRING = "f|force"
	verbose_switch: STRING = "v|verbose"
	base_switch: STRING = "base"
	base_variable_switch: STRING = "base_variable"
	eiffel_library_switch: STRING = "eiffel_library"
	ise_library_switch: STRING = "ise_library"
	replace_switch: STRING = "r|replace"
	variable_expansions_switch: STRING = "x|expand-variable-with"

feature {NONE} -- Implementation

	exec_env: EXECUTION_ENVIRONMENT
		once
			create Result
		end

	current_working_directory: STRING
		do
			Result := exec_env.current_working_directory
		end

;note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
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

