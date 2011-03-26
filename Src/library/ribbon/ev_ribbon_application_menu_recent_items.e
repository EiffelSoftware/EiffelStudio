note
	description: "Summary description for {EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS}."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_RIBBON_APPLICATION_MENU_RECENT_ITEMS

inherit
	EV_COMMAND_HANDLER_OBSERVER

create
	make_with_command_list
	
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
		do
--			create select_actions
		end

feature {EV_RIBBON} -- Command

	execute (a_command_id: NATURAL_32; a_execution_verb: INTEGER; a_property_key: POINTER; a_property_value: POINTER; a_command_execution_properties: POINTER): NATURAL_32
			-- <Precursor>
		do
			if command_list.has (a_command_id) then
				if a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_execute then
--					select_actions.call (Void)
				elseif a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_preview then

				elseif a_execution_verb = {EV_EXECUTION_VERB_CONSTANTS}.ui_executionverb_cancelpreview then

				end
			end
		end

	update_property (a_command_id: NATURAL_32; a_property_key: POINTER; a_property_current_value: POINTER; a_property_new_value: POINTER): NATURAL_32
			-- <Precursor>
		local
			l_key: EV_PROPERTY_KEY
--			l_value: EV_PROPERTY_VARIANT
		do
			if command_list.has (a_command_id) then

				create l_key.share_from_pointer (a_property_key)
				if l_key.is_recent_items then

				else
				end

			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

end
