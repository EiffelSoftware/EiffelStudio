indexing	
	description:
		"[
			Menu item with state displayed as a circular check box.
			`is_selected' is mutually exclusive with respect to other radio menu
			items between separators in a menu.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "radio, item, menu, check, select, unselect"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_RADIO_MENU_ITEM

inherit
	EV_MENU_ITEM
		redefine
			implementation,
			create_implementation,
			is_in_default_state
		end

	EV_RADIO_PEER
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end

	EV_SELECTABLE
		undefine
			initialize
		redefine
			implementation,
			is_in_default_state
		end
	
create
	default_create,
	make_with_text,
	make_with_text_and_action
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state?
			-- Radio buttons are selected by default.
		do
			Result := Precursor {EV_MENU_ITEM}
				and then Precursor {EV_RADIO_PEER}
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_RADIO_MENU_ITEM_I
		-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_RADIO_MENU_ITEM_IMP} implementation.make (Current)
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




end -- class EV_RADIO_MENU_ITEM

