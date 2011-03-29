note
	description: "Summary description for {EV_RIBBON_APPLICATION_MENU}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_APPLICATION_MENU

inherit
	EV_COMMAND_HANDLER_OBSERVER

feature {NONE} -- Initialization

	make_with_command_list (a_list: ARRAY [NATURAL_32])
			-- Creation method
		require
			not_void: a_list /= Void
		do
			command_list := a_list
			create recent_items.make_with_command_list (a_list) -- Recent items use the commnand id of ApplicationMenu

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

	groups: ARRAYED_LIST [EV_RIBBON_APPLICATION_MENU_GROUP]
			-- All groups in current tab

	recent_items: EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS
			-- Recent items list in right pane

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

feature {NONE} -- Command handler

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
		end

end
