note
	description: "Dispatcher of ribbon framework events"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_DISPACHER

inherit
	EV_SHARED_RESOURCES

create
	make

feature {NONE} -- Init

	make
			-- Init
		do
			set_object_and_function_address
		end

feature {NONE} -- Implementation

	execute (a_command_handler: POINTER; a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- Responds to execute events on Commands bound to the Command handle
			-- This function is called from C codes
		do
			Result := command_handler_singleton.execute (a_command_handler, a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
		end

	update_property (a_command_handler: POINTER; a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- Responds to property update requests from the Ribbon framework
			-- This function is called from C codes
		do
			Result := command_handler_singleton.update_property (a_command_handler, a_command_id, a_property_key, a_property_current_value, a_property_new_value)
		end

	set_object_and_function_address
			-- Set object and function addresses
			-- This set callbacks in C codes.
		do
			c_set_eiffel_dispatcher ($Current)

				-- Creation
			c_set_on_create_ui_command_address ($on_create_ui_command)
			c_set_on_view_changed_address ($on_view_changed)

				-- Events
			c_set_execute_address ($execute)
			c_set_update_property_address ($update_property)
		end

	on_create_ui_command (a_iui_application: POINTER; a_command_id: NATURAL_32; a_ui_command_type: INTEGER; a_iui_command_handler: POINTER): NATURAL_32
			-- Called for each Command specified in the Windows Ribbon framework markup to bind the Command to an IUICommandHandler.
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
		do
				-- Dispatch to all EV_RIBBON instances
			create l_res
			l_list := l_res.ribbon_list
			from
				l_list.start
			until
				l_list.after
			loop
				l_list.item.on_create_ui_command (a_iui_application, a_command_id, a_ui_command_type, a_iui_command_handler)
				l_list.forth
			end
				-- HRESULT S_OK, must return S_OK, otherwise IUICommandHandler.updateProperty and execute will not be called
			Result := {WEL_COM_HRESULT}.s_ok
		end

	on_view_changed (a_iui_application: POINTER; a_view_id: NATURAL_32; a_type_id: INTEGER; a_view: POINTER; a_verb, a_reason_code: INTEGER): NATURAL_32
			-- Called when the state of a View changes.
		local
			l_res: EV_RIBBON_RESOURCES
			l_list: ARRAYED_LIST [EV_RIBBON]
		do
				-- Dispatch to all EV_RIBBON instances
			create l_res
			l_list := l_res.ribbon_list
			Result := {WEL_COM_HRESULT}.s_ok + 1
			from
				l_list.start
			until
				l_list.after or Result = {WEL_COM_HRESULT}.s_ok
			loop
				Result := l_list.item.on_view_changed (a_iui_application, a_view_id, a_type_id, a_view, a_verb, a_reason_code)
				l_list.forth
			end
		end

feature {NONE} -- Externals

	c_set_eiffel_dispatcher (a_object: POINTER)
			-- Set Current object address.
		external
			"C signature (EIF_REFERENCE) use %"eiffel_ribbon.h%""
		end

	c_release_eiffel_dispatcher
			-- Release Current pointer in C
		external
			"C use %"eiffel_ribbon.h%""
		end

	c_set_on_create_ui_command_address (a_address: POINTER)
			-- Set on_create_ui_command function address
		external
			"C use %"eiffel_ribbon.h%""
		end

	c_set_on_view_changed_address (a_address: POINTER)
			-- Set on_create_ui_command function address
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

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
