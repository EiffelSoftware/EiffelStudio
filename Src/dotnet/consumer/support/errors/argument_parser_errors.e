indexing
	description: "Errors that may occur during command line parsing"
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

end -- class ARGUMENT_PARSER_ERRORS

