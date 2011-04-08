note
	description: "Summary description for {EV_RIBBON_HELP_BUTTON}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_HELP_BUTTON

inherit
	EV_COMMAND_HANDLER_OBSERVER

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
			if command_list.has (a_command_id) then
				if a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_execute then
					select_actions.call (Void)
				elseif a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_cancelpreview then

				end
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

end
