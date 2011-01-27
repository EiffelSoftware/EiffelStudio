note
	description: "Abstract representation of a button in a ribbon."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_BUTTON

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
			-- Select actions executed just after user clicked on button.

	text: STRING_32
			-- Text of button.
		deferred
		end

	set_text (a_text: STRING_32)
			-- Set `text' with `a_text'
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_label
				create l_enum
				{EV_RIBBON}.c_invalidate_ui_command (l_command_id, l_enum.ui_invalidations_property, l_key.pointer, l_ribbon.item)
				text_to_set := a_text
			end
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
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
		do
			if command_list.has (a_command_id) then

				create l_key.share_from_pointer (a_property_key)
				if l_key.is_label then
					if attached text_to_set as l_text then
						create l_value.share_from_pointer (a_property_new_value)
						l_value.set_string_value (l_text)
						text_to_set := void
					end
				else

				end

			end
		end

feature {NONE} -- Implementation

	command_list: ARRAY [NATURAL_32]
			-- Command ids handled by current

	text_to_set: detachable STRING_32
			-- Text will be used by `update_property'
end

