note
	description: "Property with several string values to choose from."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_CHOICE_PROPERTY

inherit
	CHOICE_PROPERTY [STRING_32]
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
			deactivate,
			update_text_on_deactivation,
			activate_action
		end

create
	make_with_choices

end
