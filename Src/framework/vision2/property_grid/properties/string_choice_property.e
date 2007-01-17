indexing
	description: "Property with several string values to choose from."
	date: "$Date$"
	revision: "$Revision$"

class
	STRING_CHOICE_PROPERTY [G -> STRING_GENERAL]

inherit
	CHOICE_PROPERTY [G]
		undefine
			is_valid_value,
			set_value
		end

	STRING_PROPERTY [G]
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
