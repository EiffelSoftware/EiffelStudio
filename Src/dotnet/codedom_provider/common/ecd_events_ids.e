indexing
	description: "List of all events identifiers"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_EVENTS_IDS

feature -- General Errors

	Invalid_event_identifier: INTEGER is 1
			-- Invalid event identifier
	
	Invalid_event_context: INTEGER is 2
			-- Invalid event context

	Not_implemented: INTEGER is 3
			-- Construct has not been implemented yet
	
	Not_supported: INTEGER is 4
			-- Construct is not supported

	Missing_setup_key: INTEGER is 5
			-- Setup keys in regsitry are missing

	Missing_installation_directory: INTEGER is 6
			-- Installation directory in registry is missing

	Missing_default_config: INTEGER is 7
			-- No default configuration information could be found

	Missing_current_process_file_name: INTEGER is 8
			-- No default configuration information could be found

feature -- General Warning

	Incorrect_result: INTEGER is 1001
			-- The operation returned an incorrect value (should be harmless)

	Failed_assignment_attempt: INTEGER is 1002
			-- An assignment attempt that should have succeeded failed.

	File_lock: INTEGER is 1003
			-- Operation failed due to a file lock

	Missing_input: INTEGER is 1004
			-- Input is missing

feature -- General Information

	Does_nothing: INTEGER is 2001
			-- Construct does not need processing

	Rescued_exception: INTEGER is 2002
			-- An exception was rescued

	Missing_config: INTEGER is 2003
			-- No specific configuration for current process found, using default configuration

	Log: INTEGER is 2004
			-- Generic log information

feature -- Consumer Errors

	Missing_current_type: INTEGER is 10001
			-- Construct is missing current type information

	Missing_current_routine: INTEGER is 10002
			-- Construct is missing current routine information

	Missing_feature_name: INTEGER is 10003
			-- Feature name is missing

	Non_external_type: INTEGER is 10004
			-- Type is not external and hasn't been registered as generated

	Missing_consumed_type: INTEGER is 10005
			-- Type not found in Eiffel Assembly Cache

	No_assembly: INTEGER is 10006
			-- Type assembly cannot be retrieved because type is generated

	Missing_implementing_type: INTEGER is 10007
			-- Could not find implementing type for feature

feature -- Consumer Warnings

	Missing_creation_type: INTEGER is 20001
			-- Construct is missing creation type information

	Missing_array_size: INTEGER is 20002
			-- Construct is missing array size information

	Missing_initializers: INTEGER is 20003
			-- Construct is missing initializers

	Missing_target_object: INTEGER is 20004
			-- Construct is missing target object

	Missing_indices: INTEGER is 20005
			-- Construct is missing indices

	Missing_delegate_type: INTEGER is 20006
			-- Construct is missing delegate type

	Missing_parameters: INTEGER is 20007
			-- Construct is missing parameters information

	Missing_current_namespace: INTEGER is 20008
			-- Construct is missing namespace information

	Missing_method: INTEGER is 20009
			-- Construct is missing method information

	Missing_return_type: INTEGER is 20010
			-- Return type is missing

	Missing_statements: INTEGER is 20011
			-- Return type is missing

	Missing_members: INTEGER is 20012
			-- Construct is missing members

	Missing_type: INTEGER is 20013
			-- Type definition is missing

	Missing_consumed_assembly: INTEGER is 20014
			-- Assembly is missing from Eiffel Assembly Cache

	Non_generated_type: INTEGER is 20015
			-- Type used in feature is external but should be generated

	Missing_feature: INTEGER is 20016
			-- Feature with given name could not be found in given type with given dynamic arguments

	Variable_name_not_found: INTEGER is 20017
			-- Lookup of variable with given name failed
	
	Feature_name_not_found: INTEGER is 20018
			-- Lookup of feature with given name failed

	Missing_types: INTEGER is 20019
			-- Namespace does not define types

	Missing_namespaces: INTEGER is 20020
			-- Compile unit does not define namespaces

	Missing_output: INTEGER is 20021
			-- No output file has been defined for generation

	Invalid_identifier: INTEGER is 20022
			-- Invalid identifier

feature -- Consumer Information

	Void_argument: INTEGER is 30001
			-- List of arguments contains a void reference

	Void_statement: INTEGER is 30002
			-- List of statements contains a void reference

feature -- Producer Errors

feature -- Producer Warnings

feature -- Producer Information

feature -- Compiler Errors

	Missing_source_file: INTEGER is 70001
			-- Source file is missing

feature -- Compiler Warnings

	File_exists: INTEGER is 80001
			-- Overwriting existing Eiffel source file

	Missing_temporary_files: INTEGER is 80002
			-- Missing temporary files in compiler parameters

	Could_not_copy: INTEGER is 80003
			-- Could not copy file

	Missing_file: INTEGER is 80004
			-- File is missing

	Missing_directory: INTEGER is 80005
			-- Directory is missing

feature -- Compiler Information

end -- class ECD_EVENTS_IDS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------