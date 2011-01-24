note
	description: "Summary description for {EV_RIBBON_CHECKBOX}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_CHECKBOX

inherit
	EV_COMMAND_HANDLER_OBSERVER

	EV_RIBBON_ITEM

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= void
		do
			command_list := a_list

			create_interface_objects
			register_observer
		ensure
			set: command_list = a_list
		end

	create_interface_objects
			-- Create objects
		do
			create select_actions
		end

feature {EV_RIBBON}

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked on button

feature {EV_RIBBON} -- Command

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				select_actions.call (Void)
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

end -- class EV_RIBBON_CHECKBOX
