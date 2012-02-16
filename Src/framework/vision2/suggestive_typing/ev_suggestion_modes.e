note
	description: "Constants used to set the various suggestion mode that can be used by {EV_ABSTRACT_SUGGESTION_FIELD}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SUGGESTION_MODES

feature -- Access

	none: INTEGER = 0
			-- No suggestions are provided.

	list: INTEGER = 1
			-- Suggestions are shown via a list.

	inline: INTEGER = 2
			-- Suggestions are shown inside the underlying `{EV_ABSTRACT_SUGGESTION_FIELD}'.

feature -- Status report

	is_valid_mode (a_mode: INTEGER): BOOLEAN
			-- Is `a_mode' a valid mode for Current
		do
				-- Currently we only support `none' and `list'.
			Result := a_mode >= 0 and a_mode <= 1
		end

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
