note
	description:
		"[
			Menu bar containing drop down menus. See EV_MENU.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "menu, bar, item, file, edit, help"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MENU_BAR

inherit
	EV_MENU_ITEM_LIST
		redefine
			implementation
		end

	EV_POSITIONED
		undefine
			is_equal,
			is_in_default_state
		redefine
			implementation
		end

create
	default_create

feature -- Status report

	parent: detachable EV_WINDOW
			-- Parent of `Current'.
		do
			Result := implementation.parent
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_MENU_BAR_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_MENU_BAR_IMP} implementation.make
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
