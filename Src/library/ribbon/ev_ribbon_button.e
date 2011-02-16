﻿note
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

feature -- Command

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
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
				text_to_set := a_text
			end
		end

	set_small_image (a_image: EV_PIXEL_BUFFER)
			-- Set small image
		require
			not_void: a_image /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_small_image
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
				small_image_to_set := a_image
			end
		end

	set_large_image (a_image: EV_PIXEL_BUFFER)
			-- Set large image
		require
			not_void: a_image /= Void
		local
			l_key: EV_PROPERTY_KEY
			l_command_id: NATURAL_32
			l_enum: EV_UI_INVALIDATIONS_ENUM
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_large_image
				create l_enum
				l_ribbon.invalidate (l_command_id, l_enum.ui_invalidations_property, l_key)
				large_image_to_set := a_image
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
				elseif l_key.is_small_image then
					if attached small_image_to_set as l_image then
						create l_value.share_from_pointer (a_property_new_value)
						l_value.set_image (l_image)
						small_image_to_set := Void
					end
				elseif l_key.is_large_image then
					if attached large_image_to_set as l_image then
						create l_value.share_from_pointer (a_property_new_value)
						l_value.set_image (l_image)
						large_image_to_set := Void
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

	small_image_to_set: detachable EV_PIXEL_BUFFER
			-- Image will be used by `update_proptery'

	large_image_to_set: detachable EV_PIXEL_BUFFER
			-- Image will be used by `update_proptery'

end

