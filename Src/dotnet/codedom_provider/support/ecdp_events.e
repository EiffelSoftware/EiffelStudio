indexing
	description: "List of possible events that might occur during CodeDom manipulation%
					%includes error, warnings and informational messages."
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_EVENTS

inherit
	ECDP_EVENTS_IDS
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
		ensure
			has_source: Result /= Void
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
			Result.extend (["Missing setup key", "general", "Setup keys are missing, installation corrupted", Error],
						Missing_setup_key)
			Result.extend (["Missing installation directory", "general", "Installation directory missing from setup keys, installation corrupted", Error],
						Missing_installation_directory)

			-- General Warning
			Result.extend (["Incorrect Result", "general", "The operation returned an incorrect value: {1}", Warning],
						Incorrect_result)
			Result.extend (["Failed Assignment Attempt", "general", "An assignment attempt that should have succeeded failed: trying to assign an instance of {1} to an instance of {2} in {3}", Warning],
						Failed_assignment_attempt)
			Result.extend (["Missing Configuration Settings", "general", "No configuration information could be found", Warning],
						Missing_configs)
			Result.extend (["Missing Default Configuration Settings", "general", "No default configuration information could be found", Warning],
						Missing_default_config)

			-- General Information
			Result.extend (["Does Nothing", "general", "Construct does not require processing: {1}", Information],
						Does_nothing)
			Result.extend (["Rescued Exception", "general", "The following exception was rescued: {1}", Information],
						Rescued_exception)
			Result.extend (["Missing Configuration", "general", "No specific configuration for {1} found, using default configuration", Information],
						Missing_config)

			-- Consumer Errors
			Result.extend (["Missing Current Type", "consumer", "Construct is missing current type information: {1}", Error],
						Missing_current_type)
			Result.extend (["Missing Feature Name", "consumer", "Feature name is missing in: {1}", Error],
						Missing_feature_name)
			Result.extend (["Non external type", "consumer", "Type is not external and hasn't been registered as generated: {1}", Error],
						Non_external_type)
			Result.extend (["Missing consumed type", "consumer", "Type '{1}' missing from Eiffel Assembly Cache", Error],
						Missing_consumed_type)
			Result.extend (["No assembly", "consumer", "Type's assembly cannot be retrieved because it is generated: {1}", Error],
						No_assembly)
			Result.extend (["Missing implementing type", "consumer", "Could not find implementing type for feature `{1}'", Error],
						Missing_implementing_type)
			
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
						Missing_return_type)
			Result.extend (["Missing Members", "consumer", "Members information is missing in {1}", Warning],
						Missing_members)
			Result.extend (["Missing type", "consumer", "Type definition for '{1}' is missing", Warning],
						Missing_type)
			Result.extend (["Missing consumed assembly", "consumer", "Assembly '{1}' is missing from Eiffel Assembly Cache", Warning],
						Missing_consumed_assembly)
			Result.extend (["Non generated type", "consumer", "Type '{1}' used in `{2}' of {3} is external but should be generated", Warning],
						Non_generated_type)
			Result.extend (["Missing feature", "consumer", "Feature `{1}' could not be found in type {2}", Warning],
						Missing_feature)
			Result.extend (["Variable not found", "consumer", "Lookup of variable `{1}' failed", Warning],
						Variable_name_not_found)
			Result.extend (["Feature not found", "consumer", "Lookup of feature `{1}' failed", Warning],
						Feature_name_not_found)
			Result.extend (["Missing types", "consumer", "Namespace {1} does not define types", Warning],
						Missing_types)
			Result.extend (["Missing namespaces", "consumer", "Compile unit does not define namespaces", Warning],
						Missing_namespaces)

			-- Consumer Information
			
			-- Producer Errors
			
			-- Producer Warnings
			
			-- Producer Information
		end

end -- class ECDP_EVENTS

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