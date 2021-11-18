note
	description: "Eiffel Vision radio menu item. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

class
	EV_RADIO_MENU_ITEM_IMP

inherit
	EV_RADIO_MENU_ITEM_I
		redefine
			interface
		end

	EV_MENU_ITEM_IMP
		redefine
			allow_on_activate,
			interface,
			make,
			initialize_menu_item
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			Precursor {EV_MENU_ITEM_IMP}
			{GTK}.gtk_check_menu_item_set_draw_as_radio (menu_item, True)
			enable_select
		end

	initialize_menu_item
			-- <Precursor>
		do
			set_c_object ({GTK}.gtk_radio_menu_item_new (default_pointer))
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
				-- We do not want select actions to be called.
				ignore_select_actions := True
				{GTK}.gtk_check_menu_item_set_active (menu_item, True)
				ignore_select_actions := False
			end
		end

feature {EV_ANY_I} -- Implementation

	disable_select
			-- Used to deselect is without firing actions.
		do
			if is_selected then
				ignore_select_actions := True
				{GTK}.gtk_check_menu_item_set_active (menu_item, False)
				ignore_select_actions := False
			end
		end

	ignore_select_actions: BOOLEAN
		-- Should select_actions be called.

	allow_on_activate: BOOLEAN
			-- <Precursor>
		do
			Result := not ignore_select_actions and then is_selected and then parent_imp /= Void
		end

	set_radio_group (a_gslist: POINTER)
			-- Make current a member of `a_gslist' radio group.
		do
			{GTK}.gtk_radio_menu_item_set_group (menu_item, a_gslist)
		end

	radio_group: POINTER
		do
			Result := {GTK}.gtk_radio_menu_item_get_group (menu_item)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_RADIO_MENU_ITEM note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_RADIO_MENU_ITEM_IMP
