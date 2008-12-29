note
	description:
		"Specialized commands to control menus"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MENU_COMMANDS

inherit

	SHARED_GUI
		export
			{NONE} all
		end

	SHARED_MOUSE
		export
			{NONE} all
		end

feature -- Clicking menu items

	left_click (a_path: STRING)
			-- Click all menu items denoted by `a_path' with left mouse button.
		local
			l_items: LIST [EV_IDENTIFIABLE]
		do
			l_items := gui.menu_items_by_path (a_path)
			l_items.do_all (agent mouse.left_click_on (?))
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
