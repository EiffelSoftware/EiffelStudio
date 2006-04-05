indexing
	description: "List of possible events that might occur during CodeDom manipulation%
					%includes error, warnings and informational messages."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EVENTS

inherit
	CODE_EVENTS_IDS
		export
			{NONE} all
		end

feature -- Access

	event_name (an_id: INTEGER): STRING is
			-- Name of event with id `an_id'.
		require
			valid_id: is_event_id (an_id)
		do
			Result ?= events.item (an_id).item (1)
		ensure
			has_name: Result /= Void
		end

	event_source (an_id: INTEGER): STRING is
			-- Source of event with id `an_id'
		require
			valid_id: is_event_id (an_id)
		do
			Result ?= events.item (an_id).item (2)
		ensure
			has_source: Result /= Void
		end

	event_message (an_id: INTEGER): STRING is
			-- Message for event with id `an_id'
		require
			valid_id: is_event_id (an_id)
		do
			Result ?= events.item (an_id).item (3)
		ensure
			has_message: Result /= Void
		end
	
	event_severity (an_id: INTEGER): INTEGER is
			-- Severity of event with id `an_id'
		require
			valid_id: is_event_id (an_id)
		do
			Result := events.item (an_id).integer_item (4)
		end

	event_message_marker (an_index: INTEGER): STRING is
			-- Message marker at index `an_index'
		require
			valid_index: an_index > 0
		do
			create Result.make (3)
			Result.append ("{")
			Result.append (an_index.out)
			Result.append ("}")
		ensure
			non_void_marker: Result /= Void
		end

	Error, Warning, Information: INTEGER is unique
			-- Events severity values

feature -- Status Report

	is_event_id (an_id: INTEGER): BOOLEAN is
			-- Is `an_id' a valid event id?
		do
			Result := events.has (an_id)
		end

	is_valid_context (an_id: INTEGER; a_context: TUPLE): BOOLEAN is
			-- Is `a_context' valid for event with id `an_id'?
		require
			valid_id: is_event_id (an_id)
			non_void_context: a_context /= Void
		do
			Result := event_arguments_count (an_id) = a_context.count
		end

	event_arguments_count (an_id: INTEGER): INTEGER is
			-- Number of contextual arguments required for event with id `an_id'
		require
			valid_id: is_event_id (an_id)
		local
			l_message: STRING
		do
			from
				l_message := event_message (an_id)
			until
				not l_message.has_substring (event_message_marker (Result + 1))
			loop
				Result := Result + 1
			end
		end
		
feature {NONE} -- Implementation

	events: HASH_TABLE [TUPLE [STRING, STRING, STRING, INTEGER], INTEGER] is
			-- List of events
			--| Item is tuple of name, source, message and severity
			--| Key is event id
			--| Message uses indeces between curly braces to insert contextual information
		once
			create Result.make (25)
			
			-- General Errors
			Result.extend (["Invalid Event Identifier", "general", "Cannot find event with identifier {1}", Error],
						Invalid_event_identifier)
			Result.extend (["Invalid Event Context", "general", "Invalid number of arguments for event {1}: Found {2} argument(s) but expected {3}", Error],
						Invalid_event_context)
			Result.extend (["Not Implemented", "general", "Construct has not been implemented yet: {1}", Error],
						Not_implemented)
			Result.extend (["Not Supported", "general", "Construct is not supported: {1}", Error],
						Not_supported)
			Result.extend (["Missing Setup Key", "general", "Setup keys are missing, corrupt installation", Error],
						Missing_setup_key)
			Result.extend (["Missing installation directory", "general", "Installation directory missing from setup keys, corrupt installation", Error],
						Missing_installation_directory)
			Result.extend (["Missing Default Configuration Settings", "general", "No default configuration information could be found", Error],
						Missing_default_config)
			Result.extend (["Missing Current Process File Name", "general", "Could not retrieve current process filename", Error],
						Missing_current_process_file_name)
			Result.extend (["Cannot Load Type", "general", "Could not load type `{1}' from assembly `{2}'", Error],
						Cannot_load_type)
			Result.extend (["Corrupt Installation", "general", "Installation of Codedom Provider is corrupt, please reinstall", Error],
						Corrupt_installation)
			Result.extend (["Missing Compiler Key", "general", "Compiler keys are missing, corrupt installation", Error],
						Missing_compiler_key)
			Result.extend (["Missing ISE_EIFFEL", "general", "ISE_EIFFEL value is not defined, corrupt installation", Error],
						Missing_ise_eiffel)
			Result.extend (["Missing ISE_PLATFORM", "general", "ISE_PLATFORM value is not defined, corrupt installation", Error],
						Missing_ise_platform)

			-- General Warning
			Result.extend (["Incorrect Result", "general", "The operation returned an incorrect value: {1}", Warning],
						Incorrect_result)
			Result.extend (["Failed Assignment Attempt", "general", "An assignment attempt that should have succeeded failed: trying to assign an instance of {1} to an instance of {2} in {3}", Warning],
						Failed_assignment_attempt)
			Result.extend (["File Lock", "general", "Operation {1} failed because of a file lock on {2}", Warning],
						File_lock)
			Result.extend (["Missing Input", "general", "Operation {1} cannot execute because input is missing", Warning],
						Missing_input)
			Result.extend (["Missing .NET member", "general", "Member {1} cannot be found in type {2}.", Warning],
						Missing_dotnet_member)

			-- General Information
			Result.extend (["Does Nothing", "general", "Construct does not require processing: {1}", Information],
						Does_nothing)
			Result.extend (["Rescued Exception", "general", "The following exception was rescued: {1}", Information],
						Rescued_exception)
			Result.extend (["Missing Configuration", "general", "No specific configuration for {1} found, using default configuration", Information],
						Missing_config)
			Result.extend (["Log", "general", "{1}", Information],
						Log)
			Result.extend (["File Deletion", "general", "File `{1}' was deleted", Information],
						File_deletion)

			-- Consumer Errors
			Result.extend (["Missing Current Type", "consumer", "Construct is missing current type information: {1}", Error],
						Missing_current_type)
			Result.extend (["Missing Current Routine", "consumer", "Construct is missing current routine information: {1}", Error],
						Missing_current_routine)
			Result.extend (["Missing Feature Name", "consumer", "Feature name is missing in: {1}", Error],
						Missing_feature_name)
			Result.extend (["Non External Type", "consumer", "Type is not external and hasn't been registered as generated: {1}", Error],
						Non_external_type)
			Result.extend (["Missing Consumed Type", "consumer", "Type '{1}' is missing from Eiffel Assembly Cache", Error],
						Missing_consumed_type)
			Result.extend (["No Assembly", "consumer", "Type's assembly cannot be retrieved because it is generated: {1}", Error],
						No_assembly)
			Result.extend (["Missing Implementing Type", "consumer", "Could not find implementing type for feature `{1}'", Error],
						Missing_implementing_type)
			Result.extend (["Missing Variable Type", "consumer", "Could not find type of variable `{1}'", Error],
						Missing_variable_type)
			Result.extend (["Missing Comment Text", "consumer", "Comment in {1} is missing text", Error],
						Missing_comment_text)
			Result.extend (["Missing Assignment Target", "consumer", "Assignment target is missing from assignment statement in `{1}'", Error],
						Missing_assignment_target)
			Result.extend (["Missing Assignment Source", "consumer", "Assignment source is missing from assignment statement in `{1}'", Error],
						Missing_assignment_source)
			Result.extend (["Missing Condition", "consumer", "Condition statement is missing condition expression in `{1}'", Error],
						Missing_condition)
			Result.extend (["Missing Expression", "consumer", "Expression statement is missing expression in `{1}'", Error],
						Missing_expression)
			Result.extend (["Missing Right Operand", "consumer", "Binary expression is missing right operand in `{1}'", Error],
						Missing_right_operand)
			Result.extend (["Missing Left Operand", "consumer", "Binary expression is missing left operand in `{1}'", Error],
						Missing_left_operand)
			Result.extend (["Missing Variable Name", "consumer", "Variable name is missing in `{1}'", Error],
						Missing_variable_name)
			Result.extend (["Missing Variable", "consumer", "Variable with name `{1}' is missing in `{2}'", Error],
						Missing_variable)
			Result.extend (["Missing Array Information", "consumer", "Array creation expression is missing some information in `{1}'", Error],
						Missing_array_information)
			Result.extend (["Missing Argument Name", "consumer", "Argument name is missing in argument reference expression in `{1}'", Error],
						Missing_argument_name)
			Result.extend (["Missing Argument Type", "consumer", "Argument type of argument `{1}' in `{2}' is missing", Error],
						Missing_argument_type)
			Result.extend (["Missing Argument", "consumer", "Argument with name `{1}' is missing in `{2}'", Error],
						Missing_argument)
			Result.extend (["Missing Type Name", "consumer", "Type in namespace `{1}' is missing name", Error],
						Missing_type_name)

			-- Consumer Warnings
			Result.extend (["Missing Array Size", "consumer", "Array creation expression is missing size information", Warning],
						Missing_array_size)
			Result.extend (["Missing Initializers", "consumer", "Construct is missing initializers: {1}", Warning],
						Missing_initializers)
			Result.extend (["Missing Target Object", "consumer", "Construct is missing target object: {1}", Warning],
						Missing_target_object)
			Result.extend (["Missing Indices", "consumer", "Construct is missing indices: {1}", Warning],
						Missing_indices)
			Result.extend (["Missing Delegate Type", "consumer", "Construct is missing delegate type: {1}", Warning],
						Missing_delegate_type)
			Result.extend (["Missing Parameters", "consumer", "Construct is missing parameters information: {1}", Warning],
						Missing_parameters)
			Result.extend (["Missing Current Namespace", "consumer", "Construct is missing current namespace information: {1}", Warning],
						Missing_current_namespace)
			Result.extend (["Missing Method", "consumer", "Construct is missing method information: {1}", Warning],
						Missing_method)
			Result.extend (["Missing Return Type", "consumer", "Return type is missing in {1}", Warning],
						Missing_return_type)
			Result.extend (["Missing Statements", "consumer", "Statements are missing in {1}", Warning],
						Missing_statements)
			Result.extend (["Missing Members", "consumer", "Members information is missing in {1}", Warning],
						Missing_members)
			Result.extend (["Missing type", "consumer", "Type definition for '{1}' is missing", Warning],
						Missing_type)
			Result.extend (["Missing Consumed Assembly", "consumer", "Assembly '{1}' is missing from Eiffel Assembly Cache", Warning],
						Missing_consumed_assembly)
			Result.extend (["Non Generated Type", "consumer", "Type '{1}' used in `{2}' of {3} is external but should be generated", Warning],
						Non_generated_type)
			Result.extend (["Missing Feature", "consumer", "Feature `{1}' could not be found in type {2}", Warning],
						Missing_feature)
			Result.extend (["Variable Not Found", "consumer", "Lookup of variable `{1}' failed", Warning],
						Variable_name_not_found)
			Result.extend (["Feature Not Found", "consumer", "Lookup of feature `{1}' failed", Warning],
						Feature_name_not_found)
			Result.extend (["Missing Types", "consumer", "Namespace {1} does not define types", Warning],
						Missing_types)
			Result.extend (["Missing Namespaces", "consumer", "Compile unit does not define namespaces", Warning],
						Missing_namespaces)
			Result.extend (["Missing Output", "consumer", "No output file has been defined for generation, using {1}", Warning],
						Missing_output)
			Result.extend (["Invalid Identifier", "consumer", "Identifier is invalid: {1}", Warning],
						Invalid_identifier)
			Result.extend (["Missing Reference", "consumer", "Referenced assembly could not be found: {1}", Warning],
						Missing_reference)
			Result.extend (["Type in cache", "consumer", "Type `{1}' is already in cache", Warning],
						Type_in_cache)
			Result.extend (["Wrong Feature Kind", "consumer", "Feature `{1}' is not of the right kind", Warning],
						Wrong_feature_kind)
			Result.extend (["Missing Return Expression", "consumer", "Return statement in `{1}' is missing expression", Warning],
						Missing_return_expression)
			Result.extend (["Missing Snippet Value", "consumer", "Snippet statement in `{1}' is missing value", Warning],
						Missing_snippet_value)
			Result.extend (["Missing Test Expression", "consumer", "Loop statement in `{1}' is missing test expression", Warning],
						Missing_test_expression)
			Result.extend (["Ambiguous Match", "consumer", "Multiple features found with name `{1}' in type {2}", Warning],
						Ambiguous_match)
			Result.extend (["Missing Parent", "consumer", "Parent of feature `{1}' is missing", Warning],
						Missing_parent)
			Result.extend (["Duplicated Type", "consumer", "Type with name `{1}' already found, ignoring second instance", Warning],
						Duplicated_type)

			-- Consumer Information
			Result.extend (["Void Argument", "consumer", "Arguments list of feature `{1}' contain a Void reference", Information],
						Void_argument)

			-- Producer Errors
			
			-- Producer Warnings
			
			-- Producer Information
			
			-- Compiler Errors

			Result.extend (["Missing Compiler", "compiler", "Compiler could not be instantiated, check registration data", Error],
						Missing_compiler)
			Result.extend (["Missing Source File", "compiler", "Source file `{1}' is missing", Error],
						Missing_source_file)
			Result.extend (["Missing Compiler Path", "compiler", "Path to compiler setting is missing, installation is corrupted.", Error],
						Missing_compiler_path)

			-- Compilation directory is missing

			-- Compiler Warnings
			Result.extend (["File Already Exists", "compiler", "File `{1}' is being overwritten", Warning],
						File_exists)
			Result.extend (["Missing Temporary Files", "compiler", "Missing temporary files in compiler parameters or Missing temporary directory in temporary files", Warning],
						Missing_temporary_files)
			Result.extend (["Missing File", "compiler", "File {1} is missing", Warning],
						Missing_file)
			Result.extend (["Missing Directory", "compiler", "Directory {1} is missing", Warning],
						Missing_directory)
			Result.extend (["Copy Failed", "compiler", "Could not copy file {1} to {2}", Warning],
						Could_not_copy)
			Result.extend (["Missing Assembly", "compiler", "Could not find assembly `{1}'", Warning],
						Missing_assembly)
			Result.extend (["Precompilation Failed", "compiler", "Could not precompile ace file `{1}' in cache `{2}'", Warning],
						Precompile_failed)

			-- Overwriting existing Eiffel source file

			-- Compiler Information

		end

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
end -- class CODE_EVENTS

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