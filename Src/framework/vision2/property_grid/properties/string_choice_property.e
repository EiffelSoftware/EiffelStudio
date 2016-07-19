note
	description: "Property with several string values to choose from."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_CHOICE_PROPERTY

inherit
	CHOICE_PROPERTY [READABLE_STRING_32]
		rename
			set_value as set_string_32_value
		undefine
			is_valid_value,
			set_string_32_value
		end

	STRING_PROPERTY
		undefine
			initialize_actions,
			initialize,
			create_interface_objects,
			deactivate,
			update_text_on_deactivation,
			activate_action
		end

create
	make_with_choices

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
