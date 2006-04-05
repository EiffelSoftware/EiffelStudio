indexing
	description: "List of all events identifiers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENTS_IDS

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
		
	Cannot_load_type: INTEGER is 9
			-- Type could not be loaded

	Corrupt_installation: INTEGER is 10
			-- Installation is corrupt

	Missing_compiler_key: INTEGER is 11
			-- Compiler keys in registry are missing

	Missing_ise_eiffel: INTEGER is 12
			-- ISE_EIFFEL value in registry is missing

	Missing_ise_platform: INTEGER is 13
			-- ISE_PLATFORM value in registry is missing

feature -- General Warning

	Incorrect_result: INTEGER is 1001
			-- The operation returned an incorrect value (should be harmless)

	Failed_assignment_attempt: INTEGER is 1002
			-- An assignment attempt that should have succeeded failed.

	File_lock: INTEGER is 1003
			-- Operation failed due to a file lock

	Missing_input: INTEGER is 1004
			-- Input is missing

	Missing_dotnet_member: INTEGER is 1005
			-- .NET member is missing

feature -- General Information

	Does_nothing: INTEGER is 2001
			-- Construct does not need processing

	Rescued_exception: INTEGER is 2002
			-- An exception was rescued

	Missing_config: INTEGER is 2003
			-- No specific configuration for current process found, using default configuration

	Log: INTEGER is 2004
			-- Generic log information

	File_deletion: INTEGER is 2005
			-- File is being deleted

feature -- Consumer Errors

	Missing_current_type: INTEGER is 3001
			-- Construct is missing current type information

	Missing_current_routine: INTEGER is 3002
			-- Construct is missing current routine information

	Missing_feature_name: INTEGER is 3003
			-- Feature name is missing

	Non_external_type: INTEGER is 3004
			-- Type is not external and hasn't been registered as generated

	Missing_consumed_type: INTEGER is 3005
			-- Type not found in Eiffel Assembly Cache

	No_assembly: INTEGER is 3006
			-- Type assembly cannot be retrieved because type is generated

	Missing_implementing_type: INTEGER is 3007
			-- Could not find implementing type for feature
	
	Missing_variable_type: INTEGER is 3008
			-- Variable type is missing

	Missing_type_name: INTEGER is 3009
			-- Name of type is missing

	Missing_assignment_target: INTEGER is 3010
			-- Statement is missing assignment target
			
	Missing_assignment_source: INTEGER is 3011
			-- Statement is missing assignment source
	
	Missing_comment_text: INTEGER is 3012
			-- Comment is missing text

	Missing_condition: INTEGER is 3013
			-- Condition statement is missing condition expression

	Missing_expression: INTEGER is 3014
			-- Expression statement is missing expression

	Missing_right_operand: INTEGER is 3015
			-- Binary expression is missing right operand

	Missing_left_operand: INTEGER is 3016
			-- Binary expression is missing left operand

	Missing_variable_name: INTEGER is 3017
			-- Variable name is missing

	Missing_variable: INTEGER is 3018
			-- Variable is missing

	Missing_array_information: INTEGER is 3019
			-- Array creation expression is missing some information

	Missing_argument_name: INTEGER is 3020
			-- Argument name is missing

	Missing_argument_type: INTEGER is 3021
			-- Argument type is missing

	Missing_argument: INTEGER is 3022
			-- Argument is missing

feature -- Consumer Warnings

	Missing_creation_type: INTEGER is 4001
			-- Construct is missing creation type information

	Missing_array_size: INTEGER is 4002
			-- Construct is missing array size information

	Missing_initializers: INTEGER is 4003
			-- Construct is missing initializers

	Missing_target_object: INTEGER is 4004
			-- Construct is missing target object

	Missing_indices: INTEGER is 4005
			-- Construct is missing indices

	Missing_delegate_type: INTEGER is 4006
			-- Construct is missing delegate type

	Missing_parameters: INTEGER is 4007
			-- Construct is missing parameters information

	Missing_current_namespace: INTEGER is 4008
			-- Construct is missing namespace information

	Missing_method: INTEGER is 4009
			-- Construct is missing method information

	Missing_return_type: INTEGER is 4010
			-- Return type is missing

	Missing_statements: INTEGER is 4011
			-- Return type is missing

	Missing_members: INTEGER is 4012
			-- Construct is missing members

	Missing_type: INTEGER is 4013
			-- Type definition is missing

	Missing_consumed_assembly: INTEGER is 4014
			-- Assembly is missing from Eiffel Assembly Cache

	Non_generated_type: INTEGER is 4015
			-- Type used in feature is external but should be generated

	Missing_feature: INTEGER is 4016
			-- Feature with given name could not be found in given type with given dynamic arguments

	Variable_name_not_found: INTEGER is 4017
			-- Lookup of variable with given name failed
	
	Feature_name_not_found: INTEGER is 4018
			-- Lookup of feature with given name failed

	Missing_types: INTEGER is 4019
			-- Namespace does not define types

	Missing_namespaces: INTEGER is 4020
			-- Compile unit does not define namespaces

	Missing_output: INTEGER is 4021
			-- No output file has been defined for generation

	Invalid_identifier: INTEGER is 4022
			-- Invalid identifier

	Missing_reference: INTEGER is 4023
			-- Reference was not found

	Type_in_cache: INTEGER is 4024
			-- Type is already in cache

	Wrong_feature_kind: INTEGER is 4025
			-- Feature is not of expected kind

	Missing_return_expression: INTEGER is 4026
			-- Return statement is missing expression

	Missing_snippet_value: INTEGER is 4027
			-- Snippet statement is missing value

	Missing_test_expression: INTEGER is 4028
			-- Iteration statement is missing test expression

	Ambiguous_match: INTEGER is 4029
			-- Multiple features with given name

	Missing_parent: INTEGER is 4030
			-- Parent routine is missing

	Duplicated_type: INTEGER is 4031
			-- Type is duplicated

feature -- Consumer Information

	Void_argument: INTEGER is 5001
			-- List of arguments contains a void reference

	Void_statement: INTEGER is 5002
			-- List of statements contains a void reference

feature -- Producer Errors

feature -- Producer Warnings

feature -- Producer Information

feature -- Compiler Errors

	Missing_compiler: INTEGER is 9001
			-- Compiler cannot be instantiated

	Missing_source_file: INTEGER is 9002
			-- Source file is missing

	Missing_compiler_path: INTEGER is 9003
			-- Compiler path setting is missing

feature -- Compiler Warnings

	File_exists: INTEGER is 10001
			-- Overwriting existing Eiffel source file

	Missing_temporary_files: INTEGER is 10002
			-- Missing temporary files in compiler parameters

	Could_not_copy: INTEGER is 10003
			-- Could not copy file

	Missing_file: INTEGER is 10004
			-- File is missing

	Missing_directory: INTEGER is 10005
			-- Directory is missing

	Missing_assembly: INTEGER is 10006
			-- Assembly is missing

	Precompile_failed: INTEGER is 10007
			-- Precompilation failed

feature -- Compiler Information

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
end -- class CODE_EVENTS_IDS

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------