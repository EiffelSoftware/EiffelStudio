indexing
	description: "List of all events identifiers"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_EVENTS_IDS

feature -- General Errors

	Invalid_event_identifier: INTEGER is 1
			-- Invalid event identifier
	
	Invalid_event_context: INTEGER is 2
			-- Invalid event context

	Not_implemented: INTEGER is 3
			-- Construct has not been implemented yet
	
	Not_supported: INTEGER is 4
			-- Construct is not supported

feature -- General Warning

	Incorrect_result: INTEGER is 1001
			-- The operation returned an incorrect value (should be harmless)

	Failed_assignment_attempt: INTEGER is 1002
			-- An assignment attempt that should have succeeded failed.

	Missing_configs: INTEGER is 1003
			-- No configuration information could be found

	Missing_default_config: INTEGER is 1004
			-- No default configuration information could be found

feature -- General Information

	Does_nothing: INTEGER is 2001
			-- Construct does not need processing

	Rescued_exception: INTEGER is 2002
			-- An exception was rescued

	Missing_config: INTEGER is 2003
			-- No specific configuration for current process found, using default configuration

feature -- Consumer Errors

	Missing_current_type: INTEGER is 10001
			-- Construct is missing current type information

	Missing_feature_name: INTEGER is 10002
			-- Feature name is missing

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

feature -- Consumer Information

feature -- Producer Errors

feature -- Producer Warnings

feature -- Producer Information
	
end -- class ECDP_EVENTS_IDS

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