indexing
	description: "Menus which can be attached to a window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ROOT_MENU_WINDOWS

inherit 
	G_ANY_IMP

feature -- Initialization

	make_root is
			-- Create the root menu details
		do
			!! menu_id.make (1, 2147483645)
			!! menu_buttons.make (30)
		end

feature -- Access

	new_id is
			-- Generate a new id.
		do
			menu_id.next
		end

	menu_id: INTEGER_GENERATOR_WINDOWS

	menu_buttons: HASH_TABLE [WIDGET_IMP, INTEGER]

feature -- Status report

	value: INTEGER is
			-- Value of the menu
		do
			Result := menu_id.value
		end

feature -- Status setting

	add (widget: WIDGET_IMP) is
			-- Add a widget to the menu.
		do
			if not menu_buttons.has_item (widget) then
				menu_id.next
				menu_buttons.put (widget, menu_id.value)
			end
		end

	add_with_id (widget: WIDGET_IMP; a_id: INTEGER) is
			-- Add a widget to the menu.
		do
			if not menu_buttons.has_item (widget) then
				menu_buttons.put (widget, a_id)
			end
		end

	remove (a_id: INTEGER) is
			-- Remove a widget from the menu.
		do
			if menu_buttons.has (a_id) then
				menu_buttons.remove (a_id)
			end
		end

	reset is
			-- Reset the contents of the menu
		do
			menu_id.reset
			!! menu_buttons.make (17)
		end

feature -- Basic operations

	execute (id: INTEGER) is
		local
			ww: WIDGET_IMP
			tb: TOGGLE_B_IMP
		do
			ww := menu_buttons.item (id)
			if ww /= Void then
				tb ?= ww
				if tb /= Void then
					if tb.state then
						tb.set_toggle_off
					else
						tb.set_toggle_on
					end
					toggle_value_changed_actions.execute (tb, Void)
					activate_actions.execute (tb, Void)
				else
					activate_actions.execute (ww, Void)
				end
			end
		end

end -- class ROOT_MENU_WINDOWS




--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

