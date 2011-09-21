note
	description: "[
					The Windows Ribbon framework provides a specialized Drop-Down Color Picker control 
					that exposes a variety of color settings through a split button and customizable 
					drop-down color selector.
																										]"
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

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
