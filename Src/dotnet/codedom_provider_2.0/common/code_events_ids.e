note
	description: "List of all events identifiers"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENTS_IDS

feature -- General Errors

	Invalid_event_identifier: INTEGER = 1
			-- Invalid event identifier
	
	Invalid_event_context: INTEGER = 2
			-- Invalid event context

	Not_implemented: INTEGER = 3
			-- Construct has not been implemented yet
	
	Not_supported: INTEGER = 4
			-- Construct is not supported

	Missing_setup_key: INTEGER = 5
			-- Setup keys in regsitry are missing

	Missing_installation_directory: INTEGER = 6
			-- Installation directory in registry is missing

	Missing_default_config: INTEGER = 7
			-- No default configuration information could be found

	Missing_current_process_file_name: INTEGER = 8
			-- No default configuration information could be found
		
	Cannot_load_type: INTEGER = 9
			-- Type could not be loaded

	Corrupt_installation: INTEGER = 10
			-- Installation is corrupt

	Missing_compiler_key: INTEGER = 11
			-- Compiler keys in registry are missing

	Missing_ise_eiffel: INTEGER = 12
			-- ISE_EIFFEL value in registry is missing

	Missing_ise_platform: INTEGER = 13
			-- ISE_PLATFORM value in registry is missing

feature -- General Warning

	Incorrect_result: INTEGER = 1001
			-- The operation returned an incorrect value (should be harmless)

	Failed_assignment_attempt: INTEGER = 1002
			-- An assignment attempt that should have succeeded failed.

	File_lock: INTEGER = 1003
			-- Operation failed due to a file lock

	Missing_input: INTEGER = 1004
			-- Input is missing

	Missing_dotnet_member: INTEGER = 1005
			-- .NET member is missing

feature -- General Information

	Does_nothing: INTEGER = 2001
			-- Construct does not need processing

	Rescued_exception: INTEGER = 2002
			-- An exception was rescued

	Missing_config: INTEGER = 2003
			-- No specific configuration for current process found, using default configuration

	Log: INTEGER = 2004
			-- Generic log information

	File_deletion: INTEGER = 2005
			-- File is being deleted

	Consuming_assembly: INTEGER = 2006
			-- Assembly is being consumed

feature -- Consumer Errors

	Missing_current_type: INTEGER = 3001
			-- Construct is missing current type information

	Missing_current_routine: INTEGER = 3002
			-- Construct is missing current routine information

	Missing_feature_name: INTEGER = 3003
			-- Feature name is missing

	Non_external_type: INTEGER = 3004
			-- Type is not external and hasn't been registered as generated

	Missing_consumed_type: INTEGER = 3005
			-- Type not found in Eiffel Assembly Cache

	No_assembly: INTEGER = 3006
			-- Type assembly cannot be retrieved because type is generated

	Missing_implementing_type: INTEGER = 3007
			-- Could not find implementing type for feature
	
	Missing_variable_type: INTEGER = 3008
			-- Variable type is missing

	Missing_type_name: INTEGER = 3009
			-- Name of type is missing

	Missing_assignment_target: INTEGER = 3010
			-- Statement is missing assignment target
			
	Missing_assignment_source: INTEGER = 3011
			-- Statement is missing assignment source
	
	Missing_comment_text: INTEGER = 3012
			-- Comment is missing text

	Missing_condition: INTEGER = 3013
			-- Condition statement is missing condition expression

	Missing_expression: INTEGER = 3014
			-- Expression statement is missing expression

	Missing_right_operand: INTEGER = 3015
			-- Binary expression is missing right operand

	Missing_left_operand: INTEGER = 3016
			-- Binary expression is missing left operand

	Missing_variable_name: INTEGER = 3017
			-- Variable name is missing

	Missing_variable: INTEGER = 3018
			-- Variable is missing

	Missing_array_information: INTEGER = 3019
			-- Array creation expression is missing some information

	Missing_argument_name: INTEGER = 3020
			-- Argument name is missing

	Missing_argument_type: INTEGER = 3021
			-- Argument type is missing

	Missing_argument: INTEGER = 3022
			-- Argument is missing

	Failed_merge: INTEGER = 3023
			-- Partial class merging failed

feature -- Consumer Warnings

	Missing_creation_type: INTEGER = 4001
			-- Construct is missing creation type information

	Missing_array_size: INTEGER = 4002
			-- Construct is missing array size information

	Missing_initializers: INTEGER = 4003
			-- Construct is missing initializers

	Missing_target_object: INTEGER = 4004
			-- Construct is missing target object

	Missing_indices: INTEGER = 4005
			-- Construct is missing indices

	Missing_delegate_type: INTEGER = 4006
			-- Construct is missing delegate type

	Missing_parameters: INTEGER = 4007
			-- Construct is missing parameters information

	Missing_current_namespace: INTEGER = 4008
			-- Construct is missing namespace information

	Missing_method: INTEGER = 4009
			-- Construct is missing method information

	Missing_return_type: INTEGER = 4010
			-- Return type is missing

	Missing_statements: INTEGER = 4011
			-- Return type is missing

	Missing_members: INTEGER = 4012
			-- Construct is missing members

	Missing_type: INTEGER = 4013
			-- Type definition is missing

	Missing_consumed_assembly: INTEGER = 4014
			-- Assembly is missing from Eiffel Assembly Cache

	Non_generated_type: INTEGER = 4015
			-- Type used in feature is external but should be generated

	Missing_feature: INTEGER = 4016
			-- Feature with given name could not be found in given type with given dynamic arguments

	Variable_name_not_found: INTEGER = 4017
			-- Lookup of variable with given name failed
	
	Feature_name_not_found: INTEGER = 4018
			-- Lookup of feature with given name failed

	Missing_types: INTEGER = 4019
			-- Namespace does not define types

	Missing_namespaces: INTEGER = 4020
			-- Compile unit does not define namespaces

	Missing_output: INTEGER = 4021
			-- No output file has been defined for generation

	Invalid_identifier: INTEGER = 4022
			-- Invalid identifier

	Missing_reference: INTEGER = 4023
			-- Reference was not found

	Type_in_cache: INTEGER = 4024
			-- Type is already in cache

	Wrong_feature_kind: INTEGER = 4025
			-- Feature is not of expected kind

	Missing_return_expression: INTEGER = 4026
			-- Return statement is missing expression

	Missing_snippet_value: INTEGER = 4027
			-- Snippet statement is missing value

	Missing_test_expression: INTEGER = 4028
			-- Iteration statement is missing test expression

	Ambiguous_match: INTEGER = 4029
			-- Multiple features with given name

	Missing_parent: INTEGER = 4030
			-- Parent routine is missing

	Duplicated_type: INTEGER = 4031
			-- Type is duplicated

feature -- Consumer Information

	Void_argument: INTEGER = 5001
			-- List of arguments contains a void reference

	Void_statement: INTEGER = 5002
			-- List of statements contains a void reference

feature -- Producer Errors

feature -- Producer Warnings

feature -- Producer Information

feature -- Compiler Errors

	Missing_compiler: INTEGER = 9001
			-- Compiler cannot be instantiated

	Missing_source_file: INTEGER = 9002
			-- Source file is missing

	Missing_compiler_path: INTEGER = 9003
			-- Compiler path setting is missing

	Failed_config_save: INTEGER = 9004
			-- Configuration file could not be saved

feature -- Compiler Warnings

	File_exists: INTEGER = 10001
			-- Overwriting existing Eiffel source file

	Missing_temporary_files: INTEGER = 10002
			-- Missing temporary files in compiler parameters

	Could_not_copy: INTEGER = 10003
			-- Could not copy file

	Missing_file: INTEGER = 10004
			-- File is missing

	Missing_directory: INTEGER = 10005
			-- Directory is missing

	Missing_assembly: INTEGER = 10006
			-- Assembly is missing

	Precompile_failed: INTEGER = 10007
			-- Precompilation failed

feature -- Compiler Information

	Compiler_output: INTEGER = 11001;
			-- Compiler output

note
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

