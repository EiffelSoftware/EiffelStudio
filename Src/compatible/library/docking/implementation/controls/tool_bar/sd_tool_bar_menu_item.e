note
	description: "Toolbar menu item used in SD_MENU_TOOL_BAR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR_MENU_ITEM

inherit
	SD_TOOL_BAR_TOGGLE_BUTTON
		export
			{ANY} on_pointer_motion, on_pointer_leave
		end

create
	make

feature -- Command

	set_menu (a_menu: EV_MENU)
			-- Set `menu' with `a_menu'
		require
			not_void: a_menu /= Void
		do
			menu := a_menu
		ensure
			set: menu = a_menu
		end

feature -- Query

	menu: EV_MENU;
			-- Menu items.

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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
