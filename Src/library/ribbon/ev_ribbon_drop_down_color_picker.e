note
	description: "Summary description for {EV_RIBBON_DROP_DOWN_COLOR_PICKER}."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_RIBBON_DROP_DOWN_COLOR_PICKER

inherit
	EV_RIBBON_BUTTON

feature -- Query

	color: detachable EV_COLOR
			-- Current selected color
		local
			l_key: EV_PROPERTY_KEY
			l_value: EV_PROPERTY_VARIANT
			l_command_id: NATURAL_32
			l_wel_color: WEL_COLOR_REF
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_color
				create l_value.make_empty
				l_ribbon.get_command_property (l_command_id, l_key, l_value)

				create l_wel_color.make_by_color (l_value.uint32_value.as_integer_32)
				create Result.make_with_8_bit_rgb (l_wel_color.red, l_wel_color.green, l_wel_color.blue)
				l_value.destroy
			end
		end

end
