note
	description	: "Preference for a choice among STRING_32 values."

class
	STRING_CHOICE_PREFERENCE

inherit
	CHOICE_PREFERENCE [STRING_32]

	STRING_LIST_PREFERENCE
		undefine
			escaped_characters,
			generating_preference_type,
			is_valid_string_for_selection,
			select_value_from_string,
			set_value_from_string,
			string_type,
			text_value
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

note
	date: "$Date: рп$"
	revision: "$Revision$"
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
