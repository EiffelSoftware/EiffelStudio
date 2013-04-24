note
	description: "[
					The Help Button is a control that the user can click to display the application
					help system.
																										]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_HELP_BUTTON

inherit
	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute
		end

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		deferred
		end

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked on button.

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

feature {NONE} -- Command handler

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				if a_execution_verb = {EV_EXECUTION_VERB}.execute then
					select_actions.call (Void)
				elseif a_execution_verb = {EV_EXECUTION_VERB}.preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB}.cancel_preview then

				end
			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
