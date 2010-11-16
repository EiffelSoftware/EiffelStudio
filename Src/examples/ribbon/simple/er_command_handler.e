note
	description: "[
					EiffelRibbon UI Command Handler class
					
					The class gathering Command information and handling Command events from 
					the Windows Ribbon framework.
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_COMMAND_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			set_object_and_function_address
		end

feature {NONE} -- Implementation

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		do
			print ("%N Command handler execute in Eiffel. Command id is: " + a_command_id.out + " Execution verb is: " + a_execution_verb.out)
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		do
			print ("%N Command handler update_property in Eiffel. Command id is: " + a_command_id.out)
		end

feature {NONE} -- Externals

	set_object_and_function_address
			-- Set object and function addresses
			-- This set callbacks in C codes, so `execute' and `update_property' can be called in C codes.
		do
			c_set_object ($Current)
			c_set_execute_address ($execute)
			c_set_update_property_address ($update_property)
		end

	c_set_object (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"eiffel_ribbon.h%""
		end

	c_release_object
			-- Release Current pointer in C
		external
			"C use %"eiffel_ribbon.h%""
		end

	c_set_execute_address (a_address: POINTER)
			-- Set execute function address
		external
			"C use %"eiffel_ribbon.h%""
		end

	c_set_update_property_address (a_address: POINTER)
			-- Set update function address
		external
			"C use %"eiffel_ribbon.h%""
		end

end
