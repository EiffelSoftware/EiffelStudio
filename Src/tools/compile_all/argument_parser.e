note
	description: "Argument parser for all classes compilation tool."
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

	name: STRING = "Compile All Tool"
			-- Application name

	version: STRING
			-- Application version
		once
			create Result.make (5)
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.major_version)
			Result.append_character ('.')
			Result.append_integer ({EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version)
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Argument switches
		once
			create Result.make (9)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Directory where to look for configuration files.", True, False, "location", "A directory to look for ecf files", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (eifgen_switch, "Directory where projects will be compiled.", True, False, "eifgen", "A directory where the projects will be compiled", False))
			Result.extend (create {ARGUMENT_FILE_SWITCH}.make (ignore_switch, "Ignore file with files/targets to ignore.", True, False, "ignore.ini", "INI file with the ignores.", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (log_verbose_switch, "Verbose logging of actions?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (ecb_switch, "Use ecb instead of ec?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (clean_switch, "Clean before compilation?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (c_compile_switch, "Compile generated C code?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (melt_switch, "Melt the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (freeze_switch, "Freeze the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (finalize_switch, "Finalize the project?", True, False))
		end

feature -- Status Report

	use_directory_location: BOOLEAN
			-- Indicates if `location' represents a directory
		local
			l_file: RAW_FILE
		once
			create l_file.make (location)
			Result := l_file.is_directory
		ensure
			result_not_directory: Result /= (create {DIRECTORY}.make (location)).exists
		end

feature -- Access

	location: STRING
			-- Location of files to use
		once
			if has_option (location_switch) then
				Result := option_of_name (location_switch).value
			else
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory.as_attached
			end
		ensure
			location_not_void: Result /= Void
			location_not_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make (Result)).exists or (create {DIRECTORY}.make (Result)).exists
		end

	eifgen: STRING
			-- Location where the projects are compiled.
		once
			if has_option (eifgen_switch) then
				Result := option_of_name (eifgen_switch).value
			end
		end

	ignore: STRING
			-- File with the ignores.
		once
			if has_option (ignore_switch) then
				Result := option_of_name (ignore_switch).value
			end
		ensure
			Result_ok: Result /= Void implies not Result.is_empty and then (create {RAW_FILE}.make (Result)).exists or (create {DIRECTORY}.make (Result)).exists
		end

	is_ecb: BOOLEAN
		once
			Result := has_option (ecb_switch)
		end

	is_parse_only: BOOLEAN
			-- Only parse and check dependencies?
		once
			Result := not is_melt and not is_freeze and not is_finalize
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

feature {NONE} -- Switch names

	location_switch: STRING = "l"
	eifgen_switch: STRING = "eifgen"
	ignore_switch: STRING = "ignore"
	log_verbose_switch: STRING = "log_verbose"
	ecb_switch: STRING = "ecb"
	clean_switch: STRING = "clean"
	c_compile_switch: STRING = "c_compile"
	melt_switch: STRING = "melt"
	freeze_switch: STRING = "freeze"
	finalize_switch: STRING = "finalize";

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
