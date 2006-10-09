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
			create Result.make (1)
			Result.extend (create {ARGUMENT_DIRECTORY_SWITCH}.make (location_switch, "Directory where to look for configuration files.", True, False, "location", "A directory to look for ecf files", False))
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

feature {NONE} -- Switch names

	location_switch: STRING = "l";

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
