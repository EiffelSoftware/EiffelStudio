﻿note
	description: "[
					A Tab contains groups of related controls.
																									]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_TAB

inherit
	EV_COMMAND_HANDLER_OBSERVER

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

	groups: ARRAYED_LIST [EV_RIBBON_GROUP]
			-- All groups in current tab

	text: STRING = "Tab 1"
			-- Text of tab

feature {NONE}	--Action handling

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				Result := update_property_for_text (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
				Result := update_property_for_tooltip (a_command_id, a_property_key, a_property_current_value, a_property_new_value)
			end
		end

feature {NONE}	-- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

end
