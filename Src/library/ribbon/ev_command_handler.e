note
	description: "[
					EiffelRibbon UI Command Handler class
					
					The class gathering Command information and handling Command events from 
					the Windows Ribbon framework.
																					]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COMMAND_HANDLER

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
			set_object_and_function_address

			create observers.make (100)
		end

feature -- Command

	add_observer (a_observer: EV_COMMAND_HANDLER_OBSERVER)
			--
		do
			observers.extend (a_observer)
		end

	remove_observer (a_observer: EV_COMMAND_HANDLER_OBSERVER)
			--
		do
			observers.prune_all (a_observer)
		end

feature {NONE} -- Observers

	observers: ARRAYED_LIST [EV_COMMAND_HANDLER_OBSERVER]
			--

feature {NONE} -- Implementation

	execute (a_command_handler: POINTER; a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		local
			l_result: NATURAL_32
			l_property_key: EV_PROPERTY_KEY
			l_propery_value: EV_PROPERTY_VARIANT
			l_observer: like observers
			l_ribbon: detachable EV_RIBBON
		do
			create l_property_key.share_from_pointer (a_property_key)
			create l_propery_value.share_from_pointer (a_property_value)
			from
				l_observer := observers.twin
				l_observer.start
			until
				l_observer.after or l_result /= 0
			loop
				l_ribbon := l_observer.item.ribbon
				if l_ribbon /= Void and then l_ribbon.command_handler = a_command_handler then
					l_result := l_observer.item.execute (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
				end

				l_observer.forth
			end
		end

	update_property (a_command_handler: POINTER; a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		local
			l_result: NATURAL_32
			l_observer: like observers
			l_ribbon: detachable EV_RIBBON
		do
			from
				l_observer := observers.twin
				l_observer.start
			until
				l_observer.after or l_result /= 0
			loop
				l_ribbon := l_observer.item.ribbon
				check should_not_void: l_ribbon /= Void end
				if l_ribbon /= Void and then l_ribbon.command_handler = a_command_handler then
					l_result := l_observer.item.update_property (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				end

				l_observer.forth
			end
		end

feature {NONE} -- Externals

	set_object_and_function_address
			-- Set object and function addresses
			-- This set callbacks in C codes, so `execute' and `update_property' can be called in C codes.
		do
			c_set_command_handler_object ($Current)
			c_set_execute_address ($execute)
			c_set_update_property_address ($update_property)
		end

	c_set_command_handler_object (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"eiffel_ribbon.h%""
		end

	c_release_command_handler_object
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
