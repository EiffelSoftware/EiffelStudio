note
	description: "Summary description for {SHORTCUT_PREFERENCE_GRID_ITEM}."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHORTCUT_PREFERENCE_GRID_EDITABLE_ITEM

inherit
	EV_GRID_EDITABLE_ITEM
		redefine
			handle_key
		end

create
	default_create,
	make_with_text

feature {NONE} -- Implementation

	handle_key (a_key: EV_KEY)
			-- Handle the Escape key for cancelling activation.
		do
			-- Do not interprete `Escape' as deactivation+cancel event
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
