indexing
	description: "Display button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_BUTTON

inherit
	EV_BUTTON

	DV_SENSITIVE_CONTROL
		undefine
			default_create,
			copy
		end

create
	make_with_text,
	make_with_text_and_action

feature -- Basic operations

	set_action (action: PROCEDURE [ANY, TUPLE]) is
			-- Set `action' to associated button action.
		obsolete
			"Use `add_action'."
		do
			select_actions.extend (action)
		end

	add_action (action: PROCEDURE [ANY, TUPLE]) is
			-- Set `action' to associated button action.
		do
			select_actions.extend (action)
		end

	activate is
			-- Activate control.
		do
			select_actions.call ([])
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"





end -- class DV_BUTTON




