indexing
	description: "Display button."
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

	library: "[
			EiffelStore: library of reusable components for ISE Eiffel.
			]"

	status: "[
			Copyright (C) 1986-2001 Interactive Software Engineering Inc.
			All rights reserved. Duplication and distribution prohibited.
			May be used only with ISE Eiffel, under terms of user license. 
			Contact ISE for any other use.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class DV_BUTTON


