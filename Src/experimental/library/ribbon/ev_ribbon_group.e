note
	description: "[
					The Group organizes related Commands and controls within a Tab.
																										]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_GROUP

inherit
	EV_COMMAND_HANDLER_OBSERVER
		redefine
			execute,
			update_property
		end

	EV_RIBBON_TEXTABLE

	EV_RIBBON_TOOLTIPABLE

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

feature -- Query

	buttons: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- All buttons in current group

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_execution_verb, a_property_key, a_property_value, a_command_execution_properties)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
			end

		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			Result := Precursor (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			if command_list.has (a_command_id) then
				Result := {WEL_COM_HRESULT}.s_ok
				Result := update_property_for_text (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				Result := update_property_for_tooltip (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

;note
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
