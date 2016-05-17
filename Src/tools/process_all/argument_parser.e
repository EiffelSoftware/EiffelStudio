note
	description: "Argument parser."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		rename
			make as make_option_parser
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the argument parser
		do
			make_option_parser (False)
			set_is_using_separated_switch_values (True)
		end

feature {NONE} -- Access

	name: STRING_32 = "Process-All Tool"
			-- Application name

	version: STRING_32
			-- Application version
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append ((create {EIFFEL_CONSTANTS}).two_digit_minimum_minor_version)
		end

	copyright: STRING_32 = "Copyright Eiffel Software 2006-2016. All Rights Reserved."
			-- <Precursor>

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Argument switches
		once
			create Result.make (9)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Directory where to look for configuration files.", True, False, "directory", "A directory to look for ecf files", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (compdir_switch, "Directory where projects will be compiled.", True, False, "directory", "A directory where the projects will be compiled", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (logdir_switch, "Directory where logs will be stored (if verbose logging is enabled).", True, False, "directory", "A directory where the logs will be stored", False))
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (ignore_switch, "Ignore file with files/targets to ignore.", True, False, "ignore.ini", "INI file with the ignores.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (log_verbose_switch, "Verbose logging of actions?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (list_failures_switch, "Display a list of failed project(s) with associated log filename if available.", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (ecb_switch, "Use ecb instead of ec?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (experiment_switch, "Use experimental library during compilation?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (compatible_switch, "Use compatible library during compilation?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (c_compile_switch, "Compile generated C code?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (melt_switch, "Melt the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (freeze_switch, "Freeze the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (finalize_switch, "Finalize the project?", True, False))

			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "Clean before compilation?", True, False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (keep_switch, "Keep EIFGENs related data after compilation? (by default they are removed)", True, False, "status", "{all | passed | failed}", True))

			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (options_switch, "Comma separated option(s)", True, True, "key=value", "dotnet=(true|false)%N...", False))
			Result.extend (create {ARGUMENT_VALUE_SWITCH}.make (interface_switch, "Comma separated option(s) to customize the output", True, True,
						"key=value",
						"for instance key %"template%": using any of #action, #target, #uuid, #system, #ecf , #absolute_ecf variables %N...", False))

			Result.extend (create {ARGUMENT_SWITCH}.make (test_switch, "Run tests found in systems.", True, False))
			Result.extend (create {ARGUMENT_NATURAL_SWITCH}.make_with_range (nproc_switch, "Maximum number of processors to use. If not specified, all available CPUs will be used.", True, False, "n", "Number of processors", False, 1, {NATURAL_16}.max_value))
		end

feature -- Status Report

	use_directory_location: BOOLEAN
			-- Indicates if `location' represents a directory
		local
			l_file: RAW_FILE
		once
			create l_file.make_with_path (location)
			Result := l_file.is_directory
		ensure
			result_not_directory: Result /= (create {DIRECTORY}.make_with_path (location)).exists
		end

feature -- Access

	location: PATH
			-- Location of files to use
		once
			if has_option (location_switch) then
				create Result.make_from_string (option_of_name (location_switch).value)
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_path
			end
		ensure
			location_not_void: Result /= Void
			location_not_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make_with_path (Result)).exists or (create {DIRECTORY}.make_with_path (Result)).exists
		end

	compilation_dir: detachable PATH
			-- Location where the projects are compiled.
		once
			if attached option_of_name (compdir_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		end

	logs_dir: detachable PATH
			-- Location where the logs are stored.
		once
			if attached option_of_name (logdir_switch) as l_option then
				create Result.make_from_string (l_option.value)
			end
		end

	ignore: detachable IMMUTABLE_STRING_32
			-- File with the ignores.
		once
			if has_option (ignore_switch) then
				Result := option_of_name (ignore_switch).value
			end
		ensure
			Result_ok: Result /= Void implies not Result.is_empty and then (create {RAW_FILE}.make_with_name (Result)).exists or (create {DIRECTORY}.make (Result)).exists
		end

	is_ecb: BOOLEAN
		once
			Result := has_option (ecb_switch)
		end

	is_experiment: BOOLEAN
			-- Use experimental library?
		once
			Result := has_option (experiment_switch)
		end

	is_compatible: BOOLEAN
			-- Use experimental library?
		once
			Result := has_option (compatible_switch)
		end

	is_parse_only: BOOLEAN
			-- Only parse and check dependencies?
		once
			Result := not is_melt and not is_freeze and not is_finalize and not is_test
		end

	is_log_verbose: BOOLEAN
			-- Log verbose status information?
		once
			Result := has_option (log_verbose_switch)
		end

	is_clean: BOOLEAN
			-- Clean before compilation?
		once
			Result := has_option (clean_switch)
		end

	is_test: BOOLEAN
			-- Is for test?
		once
			Result := has_option (test_switch)
		end

	has_keep: BOOLEAN
			-- Keep EIFGENs after compilation?
			--| By default: compilation data is removed after related compilation(s)
			--| if we melt+freeze+finalize then
			--| the data are removed only after the last compilation made on the same target
		once
			Result := has_option (keep_switch)
		end

	has_keep_all: BOOLEAN
			-- Keep EIFGENs after any compilation?
		once
			if has_option (keep_switch) then
				if attached option_of_name (keep_switch).value as v and then not v.is_empty then
				 	Result := v.is_case_insensitive_equal ("all")
				else
					Result := True
				end
			end
		end

	has_keep_failed: BOOLEAN
			-- Keep EIFGENs after Failed compilation?
		once
			if has_option (keep_switch) then
				Result := attached option_of_name (keep_switch).value as v and then v.is_case_insensitive_equal ("failed")
			end
		end

	has_keep_passed: BOOLEAN
			-- Keep EIFGENs after Passed compilation?
		once
			if has_option (keep_switch) then
				Result := attached option_of_name (keep_switch).value as v and then v.is_case_insensitive_equal ("passed")
			end
		end

	is_c_compile: BOOLEAN
			-- Compile generated C code?
		once
			Result := has_option (c_compile_switch)
		end

	is_melt: BOOLEAN
			-- Melt the project?
		once
			Result := has_option (melt_switch)
		end

	is_freeze: BOOLEAN
			-- Freeze the project?
		once
			Result := has_option (freeze_switch)
		end

	is_finalize: BOOLEAN
			-- Finalize the project?
		once
			Result := has_option (finalize_switch)
		end

	list_failures: BOOLEAN
			-- Finalize the project?
		once
			Result := has_option (list_failures_switch)
		end

	has_max_processors: BOOLEAN
			-- Indicates if user specified a number of processors
		once
			Result := has_option (nproc_switch)
		end

	max_processors: NATURAL_8
			-- Maximum number of processors to utilize
		require
			is_successful: is_successful
			has_max_processors: has_max_processors
		once
			if attached {ARGUMENT_NATURAL_OPTION} option_of_name (nproc_switch) as l_value then
				Result := l_value.natural_8_value
			else
				check False end
			end
		ensure
			result_positive: Result > 0
		end

feature -- Access: -interface

	interface_output_action_template: detachable IMMUTABLE_STRING_32
			-- Template for output action
		once
			if attached interface_item ("template") as s then
				Result := s
			end
		end

	interface_text (m: READABLE_STRING_GENERAL): IMMUTABLE_STRING_32
			-- Value for -options text.`m'=value
		do
			if attached interface_item ("text." + m) as s then
				Result := s
			else
				create Result.make_from_string_general (m)
			end
		end

feature -- Access: -options		

	skip_dotnet: BOOLEAN
			-- Skip dotnet target?
		once
			Result := options_has_false ("dotnet")
		end

	ec_options: IMMUTABLE_STRING_32
			-- 'ec' compiler option for any action
		once
			if attached options_item ("ec") as l_opt then
				Result := l_opt
			else
				create Result.make_empty
			end
		end

	melt_ec_options: IMMUTABLE_STRING_32
			-- 'ec' compiler option when melting
		once
			if attached options_item ("ec.melt") as l_opt then
				Result := l_opt
			else
				create Result.make_empty
			end
		end

	freeze_ec_options: IMMUTABLE_STRING_32
			-- 'ec' compiler option when freezing
		once
			if attached options_item ("ec.freeze") as l_opt then
				Result := l_opt
			else
				create Result.make_empty
			end
		end

	finalize_ec_options: IMMUTABLE_STRING_32
			-- 'ec' compiler option when finalizing
		once
			if attached options_item ("ec.finalize") as l_opt then
				Result := l_opt
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Implementation: -interface	

	interface_item (a_name: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_32
		do
			Result := interface_options.item (a_name)
		end

	interface_options: STRING_TABLE [IMMUTABLE_STRING_32]
		once
			Result := concatenated_multiple_options (interface_switch, ',')
		end

feature {NONE} -- Implementation: -options		

	options_has_true (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached options_item (a_name) as v then
				Result := v.is_case_insensitive_equal ("true")
			end
		end

	options_has_false (a_name: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached options_item (a_name) as v then
				Result := v.is_case_insensitive_equal ("false")
			end
		end

	options_item (a_name: READABLE_STRING_GENERAL): detachable IMMUTABLE_STRING_32
		do
			Result := options.item (a_name)
		end

	options: STRING_TABLE [IMMUTABLE_STRING_32]
		once
			Result := concatenated_multiple_options (options_switch, ',')
		end

feature {NONE} -- Concatenated value for multiple switch		

	concatenated_multiple_options (a_switch: READABLE_STRING_GENERAL; a_separator: CHARACTER): STRING_TABLE [IMMUTABLE_STRING_32]
			-- Table of options related to multiple option
		local
			sep: CHARACTER_32
			s,k,v: STRING_32
			p: INTEGER
		do
			if
				has_option (a_switch) and then
			 	attached options_of_name (a_switch) as lst and then not lst.is_empty
			then
				create Result.make_caseless (lst.count)
				Result.compare_objects
				across
					lst as lst_cursor
				loop
					if lst_cursor.item.has_value then
						s := lst_cursor.item.value
						if not s.is_empty then
								-- If first character is not alpha character, let's take it for separator
							sep := s.item (1)
							if sep.is_alpha then
								sep := a_separator
							else
								s := s.substring (2, s.count)
							end
							across
								s.split (sep) as c
							loop
								s := c.item
								s.left_adjust
								p := s.index_of ('=', 1)
								if p > 0 then
									k := s.substring (1, p - 1)
									k.right_adjust
									v := s.substring (p + 1, s.count)
									if
										not v.is_empty and then
										v.item (1) = '"' and then
										v.item (v.count) = '"'
									then
										v := v.substring (2, v.count - 1)
									end
									Result.force (v, k)
								else
									Result.force ("true", s)
								end
							end
						end
					end
				end
			else
				create Result.make (0)
			end
		end

feature {NONE} -- Switch names

	location_switch: STRING = "l"
	compdir_switch: STRING = "compdir"
	logdir_switch: STRING = "logdir"
	experiment_switch: STRING = "experiment"
	compatible_switch: STRING = "compat"
	ignore_switch: STRING = "ignore"
	log_verbose_switch: STRING = "log_verbose"
	ecb_switch: STRING = "ecb"
	clean_switch: STRING = "clean"
	keep_switch: STRING = "keep"
	c_compile_switch: STRING = "c_compile"
	melt_switch: STRING = "melt"
	freeze_switch: STRING = "freeze"
	finalize_switch: STRING = "finalize"
	options_switch: STRING = "options"
	interface_switch: STRING = "interface"
	list_failures_switch: STRING = "list_failures"
	test_switch: STRING = "tests"
	nproc_switch: STRING = "nproc"
	;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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
