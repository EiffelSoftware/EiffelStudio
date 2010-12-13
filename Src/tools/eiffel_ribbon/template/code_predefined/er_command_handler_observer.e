note
	description: "Summary description for {ER_COMMAND_HANDLER_OBSERVER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ER_COMMAND_HANDLER_OBSERVER

feature -- Action handlers

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		deferred
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		deferred
		end

feature {NONE}	-- Register

	register_observer
			--
		local
			l_shared: ER_SHARED_RESOURCES
		do
			create l_shared
			l_shared.command_handler_singleton.add_observer (Current)
		end
end
