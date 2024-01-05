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

	copyright: IMMUTABLE_STRING_32
			-- <Precursor>
		once
			create Result.make_from_string_general ("Copyright Eiffel Software 2011-2024. All Rights Reserved.")
		end

	files: LIST [PATH]
			-- List of files to resave
		local
			l_options: like values
			f: RAW_FILE
		once
			l_options := values.twin
			from l_options.start until l_options.after loop
				create f.make_with_name (l_options.item)
				if f.exists and then f.is_readable and not f.is_directory then
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

	replacements: detachable LIST [STRING_32]
			-- List of replacements
		once
			if
				has_option (replace_switch) and then
				attached options_of_name (replace_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING_32]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value.to_string_32)
					end
				end
			end
		end

	variable_expansions: detachable LIST [STRING_32]
			-- List of variable expansions
		once
			if
				has_option (variable_expansions_switch) and then
				attached options_of_name (variable_expansions_switch) as opts and then not opts.is_empty
			then
				create {ARRAYED_LIST [STRING_32]} Result.make (opts.count)
				across
					opts as c
				loop
					if c.item.has_value then
						Result.force (c.item.value.to_string_32)
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

	root_directory: PATH
		once
			if has_option (root_switch) and then attached option_of_name (root_switch) as o and then o.has_value then
				create Result.make_from_string (o.value)
			else
				Result := current_working_path -- Current working directory
			end
		end

	base_name: detachable STRING_32
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

	non_switched_argument_name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string ({STRING_32} "path")
		end

	non_switched_argument_description: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Eiffel configuration file or directory")
		end

	non_switched_argument_type: IMMUTABLE_STRING_32
			--  <Precursor>
		once
			create Result.make_from_string ({STRING_32} "Eiffel configuration file/directory")
		end

	name: IMMUTABLE_STRING_32
		once
			create Result.make_from_string_general ({APPLICATION_CONSTANTS}.executable_name)
		end

	version: IMMUTABLE_STRING_32
			--  <Precursor>
		local
			s: STRING_32
		once
			create s.make (5)
			s.append_natural_16 ({APPLICATION_CONSTANTS}.major_version)
			s.append_character ('.')
			s.append_natural_16 ({APPLICATION_CONSTANTS}.minor_version)
			create Result.make_from_string (s)
		end

feature {NONE} -- Switches

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
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

	current_working_path: PATH
		do
			Result := exec_env.current_working_path
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

