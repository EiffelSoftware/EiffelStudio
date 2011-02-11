note
	description: "Summary description for {EV_RIBBON_SPINNER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_SPINNER

inherit
	EV_RIBBON_BUTTON

feature -- Query

	decimal_value: REAL_64
			--
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_decimal
				create l_value.make_empty
				{EV_RIBBON}.get_UI_Command_Property (l_command_id, l_key.pointer, l_value.pointer.item, l_ribbon.item)
				Result := l_value.decimal_value
			end
		end

feature -- Command

	set_decimal_value (a_value: REAL_64)
			--
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_decimal
				create l_value.make_empty
				l_value.set_decimal_value (a_value)
				{EV_RIBBON}.set_UI_Command_Property (l_command_id, l_key.pointer, l_value.pointer.item, l_ribbon.item)
				l_value.destroy
			end
		end
end
