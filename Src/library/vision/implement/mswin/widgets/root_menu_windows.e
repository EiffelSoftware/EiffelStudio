indexing

	description: "Menus which can be attached to a window";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	ROOT_MENU_WINDOWS

inherit 
	G_ANY_WINDOWS

feature -- Initialization

	make_root is
			-- Create the root menu details
		do
			!! menu_id.make (1, 16384)
			!! menu_buttons.make (17)
		end

feature -- Access

	menu_id: INTEGER_GENERATOR_WINDOWS

	menu_buttons: HASH_TABLE [WIDGET_WINDOWS, INTEGER]

feature -- Status report

	value: INTEGER is
			-- Value of the menu
		do
			Result := menu_id.value
		end

feature -- Status setting

	add (widget: WIDGET_WINDOWS) is
			-- Add a widget to the menu
		do
			menu_id.next
			menu_buttons.put (widget, menu_id.value)
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
			ww: WIDGET_WINDOWS
			tb: TOGGLE_B_WINDOWS
		do
			ww := menu_buttons.item (id)
			if ww /= Void then
				tb ?= ww
				if tb /= Void then
					tb.set_toggle_on
					toggle_value_changed_actions.execute (tb, Void)
				else
					activate_actions.execute (ww, Void)
				end
			end
		end

end -- class ROOT_MENU_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------


