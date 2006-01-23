indexing
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
			on_activate,
			interface,
			make
		end

	EV_RADIO_PEER_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a menu item.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_radio_menu_item_new (NULL))
			{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_show_toggle (c_object, True)
			enable_select
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is this menu item checked?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_check_menu_item_struct_active (c_object).to_boolean
		end

feature -- Status setting

	enable_select is
			-- Select this menu item.
		do
			if not is_selected then
				-- We do not want select actions to be called.
				ignore_select_actions := True
				{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (c_object, True)
				ignore_select_actions := False
			end
		end

feature {EV_ANY_I} -- Implementation

	disable_select is
			-- Used to deselect is without firing actions.
		do
			if is_selected then
				ignore_select_actions := True
				{EV_GTK_EXTERNALS}.gtk_check_menu_item_set_active (c_object, False)
				ignore_select_actions := False				
			end
		end

	ignore_select_actions: BOOLEAN
		-- Should select_actions be called.

	on_activate is
		do
			if is_selected and not ignore_select_actions then
				Precursor
			end
		end

	set_radio_group (a_gslist: POINTER) is
			-- Make current a member of `a_gslist' radio group.
		do
			{EV_GTK_EXTERNALS}.gtk_radio_menu_item_set_group (c_object, a_gslist)
		end

	radio_group: POINTER is
		do
			Result := {EV_GTK_EXTERNALS}.gtk_radio_menu_item_group (c_object)
		end

	interface: EV_RADIO_MENU_ITEM;

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




end -- class EV_RADIO_MENU_ITEM_IMP

