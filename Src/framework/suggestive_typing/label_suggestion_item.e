note
	description: "Simple implementation of {SUGGESTION_ITEM} consisting of only a text label."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	LABEL_SUGGESTION_ITEM

inherit
	SUGGESTION_ITEM

create
	make

feature {NONE} -- Initialization

	make (a_text: READABLE_STRING_GENERAL)
			-- Initialize current with `a_text'.
		do
			create text.make_from_string_general (a_text)
		ensure
			text_set: text.same_string_general (a_text)
		end

feature -- Access

	text: IMMUTABLE_STRING_32
			-- Associated text for suggestion.

invariant

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
