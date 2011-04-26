note
	description: "[
						The Quick Access Toolbar (QAT) is a small, customizable toolbar
					 that exposes a set of Commands that are specified by the application
					  or selected by the user.
																							 ]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_QUICK_ACCESS_TOOLBAR

inherit
	EV_COMMAND_HANDLER_OBSERVER

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list
			create default_buttons.make (10)

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

	default_buttons: ARRAYED_LIST [EV_RIBBON_ITEM]
			-- Default buttons

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
				if a_execution_verb = {EV_EXECUTION_VERB}.execute then
					select_actions.call (Void)
				elseif a_execution_verb = {EV_EXECUTION_VERB}.preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB}.cancel_preview then

				end
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

end
