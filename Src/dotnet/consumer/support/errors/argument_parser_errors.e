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

	No_destination_if_put_in_eac: INTEGER is 0x03000005
			-- Both /d and /e options used

	Non_signed_assembly: INTEGER is 0x03000006
			-- Try to put unsigned assembly in EAC
	
	Invalid_assembly: INTEGER is 0x03000007
			-- Specified file is not a valid .NET assembly

	Eac_not_initialized: INTEGER is 0x03000008
			-- EAC not initialized
			
	Cannot_force_local_and_eac: INTEGER is 0x03000009
			-- Cannot force local and put in EAC
			
	Dependancies_must_be_generated: INTEGER is 0x03000010
			-- EAC dependancies must be generated
			
	Cannot_force_and_exclude_references: INTEGER is 0x03000011

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
			Result.put ("Cannot specify destination with '/e' option", No_destination_if_put_in_eac)
			Result.put ("Cannot put unsigned assemblies in cache", Non_signed_assembly)
			Result.put ("Specified file is not a valid .NET assembly", Invalid_assembly)
			Result.put ("EAC not initialized, run 'emitter /init' first", Eac_not_initialized)
			Result.put ("Assemblies that are added to EAC, cannot have their dependancies consumed locally", Cannot_force_local_and_eac)
			Result.put ("Assemblies that are added to EAC, must have their dependacies consumed", Dependancies_must_be_generated)
			Result.put ("Cannot force assembly dependancies into local path if no dependancies are consumed", Cannot_force_and_exclude_references)
		end

end -- class ARGUMENT_PARSER_ERRORS

