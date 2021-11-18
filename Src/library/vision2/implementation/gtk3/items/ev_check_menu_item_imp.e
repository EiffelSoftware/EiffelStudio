note
	description: "EiffelVision check menu. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_CHECK_MENU_ITEM_IMP

inherit
	EV_CHECK_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			old_make,
			interface,
			allow_on_activate,
			make,
			initialize_menu_item
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a menu.
		do
			assign_interface (an_interface)
		end

	initialize_menu_item
			-- <Precursor>
		do
			set_c_object ({GTK}.gtk_check_menu_item_new)
		end

	make
			-- <Precursor>
		do
			Precursor {EV_MENU_ITEM_IMP}
			{GTK}.gtk_check_menu_item_set_draw_as_radio (menu_item, True)
			disable_select
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is this menu item checked?
		do
			Result := {GTK}.gtk_check_menu_item_get_active (menu_item)
		end

feature -- Status setting

	enable_select
			-- Select this menu item.
		do
			if not is_selected then
				ignore_select_actions := True
				{GTK}.gtk_check_menu_item_set_active (menu_item, True)
				ignore_select_actions := False
			end
		end

	disable_select
			-- Deselect this menu item.
		do
			if is_selected then
				ignore_select_actions := True
				{GTK}.gtk_check_menu_item_set_active (menu_item, False)
				ignore_select_actions := False
			end
		end

feature {NONE} -- Implementation

	allow_on_activate: BOOLEAN
			-- Is the activate signal allowed to be propagated?
		do
			Result := parent_imp /= Void and then not ignore_select_actions
		end

	ignore_select_actions: BOOLEAN
			-- Should select actions be ignore, yes if enable_select is called.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CHECK_MENU_ITEM note option: stable attribute end;

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

end -- class EV_CHECK_MENU_ITEM_IMP
