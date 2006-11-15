indexing
	description: "Argument parser for all classes compilation tool."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER

inherit
	ARGUMENT_OPTION_PARSER
		export
			{NONE} all
			{ROOT_CLASS} execute, successful, set_use_separated_switch_values
		end

create
	make

feature {NONE} -- Access

	name: STRING = "Compile All Tool"
			-- Application name

	version: STRING is
			-- Application version
		once
			Result := {EIFFEL_ENV}.major_version.out + "." + {EIFFEL_ENV}.minor_version.out
		end

	switches: ARRAYED_LIST [ARGUMENT_SWITCH]
			-- Argument switches
		once
			create Result.make (7)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Directory where to look for configuration files.", True, False, "location", "A directory to look for ecf files", False))
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (eifgen_switch, "Directory where projects will be compiled.", True, False, "eifgen", "A directory where the projects will be compiled", False))
			Result.extend (create {ARGUMENT_SWITCH}.make (log_verbose_switch, "Verbose logging of actions?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_clean_switch, "Clean before compilation?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_melt_switch, "Do not melt the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_freeze_switch, "Do not freeze the project?", True, False))
			Result.extend (create {ARGUMENT_SWITCH}.make (no_finalize_switch, "Do not finalize the project?", True, False))
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
				Result := (create {EXECUTION_ENVIRONMENT}).current_working_directory
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_exists: (create {RAW_FILE}.make (Result)).exists or (create {DIRECTORY}.make (Result)).exists
		end

	eifgen: STRING
			-- Location where the projects are compiled.
		once
			if has_option (eifgen_switch) then
				Result := option_of_name (eifgen_switch).value
			end
		end

	is_parse_only: BOOLEAN
			-- Only parse and check dependencies?
		once
			Result := has_option (no_melt_switch) and has_option (no_freeze_switch) and has_option (no_finalize_switch)
		end

	is_log_verbose: BOOLEAN
			-- Log verbose status information?
		once
			Result := has_option (log_verbose_switch)
		end

	is_clean: BOOLEAN
			-- Clean before compilation?
		once
			Result := not has_option (no_clean_switch)
		end

	is_melt: BOOLEAN
			-- Melt the project?
		once
			Result := not has_option (no_melt_switch)
		end

	is_freeze: BOOLEAN
			-- Freeze the project?
		once
			Result := not has_option (no_freeze_switch)
		end

	is_finalize: BOOLEAN
			-- Finalize the project?
		once
			Result := not has_option (no_finalize_switch)
		end

feature {NONE} -- Switch names

	location_switch: STRING = "l"
	eifgen_switch: STRING = "eifgen"
	log_verbose_switch: STRING = "log_verbose"
	no_clean_switch: STRING = "no_clean"
	no_melt_switch: STRING = "no_melt"
	no_freeze_switch: STRING = "no_freeze"
	no_finalize_switch: STRING = "no_finalize";

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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
