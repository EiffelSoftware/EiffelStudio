indexing
	description: "Errors that may occur during command line parsing"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ARGUMENT_PARSER_ERRORS

inherit
	ERROR_MANAGER

feature -- Access

	Error_category: INTEGER_8 is 0x03
			-- Error category

	Invalid_switch: INTEGER is 0x03000001
			-- Invalid switch in command line
			-- Error context is invalid switch.

	Invalid_destination_path: INTEGER is 0x03000002
			-- Non existent destination path
			-- Error context is invalid path.

	Invalid_target_path: INTEGER is 0x03000003
			-- Non existent target assembly path
			-- Error context is invalid path.

	No_target: INTEGER is 0x03000004
			-- No target assembly specified

	Invalid_assembly: INTEGER is 0x03000007
			-- Specified file is not a valid .NET assembly	

	Version_should_be_specified: INTEGER is 0x03000012
			-- Version of the CLR runtime needs to be specified
			
	invalid_version_specified: INTEGER is 0x03000013
			-- Specified CLR version number is invalid
			
	no_operation: INTEGER is 0x03000014
			-- No operation to perform

feature {NONE} -- Implementation

	error_message_table: HASH_TABLE [STRING, INTEGER] is
			-- Table of correspondance between error codes and error messages
		once
			create Result.make (10)
			Result.put ("No error", No_error)
			Result.put ("Invalid command line switch", Invalid_switch)
			Result.put ("Invalid destination path", Invalid_destination_path)
			Result.put ("Invalid target assembly path", Invalid_target_path)
			Result.put ("Missing target assembly", No_target)
			Result.put ("Specified file is not a valid .NET assembly", Invalid_assembly)
			Result.put ("Version of the CLR runtime must be specified with `ver[sion]' option", Version_should_be_specified)
			Result.put ("Invalid CLR version number specified with `ver[sion]' option", invalid_version_specified)
			Result.put ("No operation specified.", no_operation)
		end

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


end -- class ARGUMENT_PARSER_ERRORS

