note
	description	: "preference for a choice between path."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date:"
	revision: "$Revision$"

class
	PATH_CHOICE_PREFERENCE

inherit
	CHOICE_PREFERENCE [PATH]

	PATH_LIST_PREFERENCE
		undefine
			text_value,
			set_value_from_string,
			generating_preference_type,
			string_type,
			escaped_characters
		end

create {PREFERENCE_FACTORY}
	make, make_from_string_value

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
