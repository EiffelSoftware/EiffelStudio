note
	description: "Abstract representation of a checkbox in a ribbon"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_CHECKBOX

inherit
	EV_RIBBON_ITEM

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
		do
			create select_actions
		end

feature -- Access

	select_actions: EV_NOTIFY_ACTION_SEQUENCE
			-- Select actions executed just after user clicked on check box.

	text: STRING_32
			-- Text of check box.
		deferred
		end

	is_selected: BOOLEAN
			-- If current has been checked?
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_boolean
				create l_value.make_empty
				{EV_RIBBON}.get_UI_Command_Property (l_command_id, l_key.pointer, l_value.pointer.item, l_ribbon.item)
				Result := l_value.boolean_value
				l_value.destroy
			end
		end

feature -- Command

	enable_select
			-- Make `is_selected' true
		do
			set_selected (True)
		end

	disable_select
			-- Make `is_selected' false
		do
			set_selected (False)
		end

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

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

	set_selected (a_bool: BOOLEAN)
			-- Set `is_selected' with `a_bool'
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_boolean
				create l_value.make_empty
				l_value.set_boolean_value (a_bool)
				{EV_RIBBON}.set_UI_Command_Property (l_command_id, l_key.pointer, l_value.pointer.item, l_ribbon.item)
				l_value.destroy
			end
		end

end
