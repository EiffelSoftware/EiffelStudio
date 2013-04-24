note
	description: "[
					The Spinner is a composite control that consists of an increment button,
					a decrement button, and an edit control, all of which are used to provide
					decimal values to the application.
																								]"
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
				l_ribbon.get_command_property (l_command_id, l_key, l_value)
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
			l_result: BOOLEAN
		do
			l_command_id := command_list.item (command_list.lower)
			check command_id_valid: l_command_id /= 0 end

			if attached ribbon as l_ribbon then
				create l_key.make_decimal
				create l_value.make_empty
				l_value.set_decimal_value (a_value)
				l_result := l_ribbon.set_command_property (l_command_id, l_key, l_value)
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
