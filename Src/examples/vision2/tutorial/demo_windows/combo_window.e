indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	COMBO_WINDOW

inherit
	DEMO_WINDOW

	EV_COMBO_BOX
		redefine
			make
		end
	WIDGET_COMMANDS
	TEXT_COMPONENT_COMMANDS
	TEXT_FIELD_COMMANDS
	LIST_COMMANDS

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
			-- We create the box first without parent because it
			-- is faster.
		do
			{EV_COMBO_BOX} Precursor (par)
--			set_editable (False)

			!! item1.make_with_text (Current, "Item 1")
			!! item2.make (Current)
			item2.set_text ("Item 2")
			item2.set_selected (True)
			!! item3.make_with_text (Current, "Item 3")
			set_text ("Please select an item")
			select_all
			create event_window.make (Current)
			add_widget_commands (Current, event_window, "combo box")
			add_text_component_commands (Current, event_window, "Combo box")
			add_text_field_commands (Current, event_window, "combo box")
			add_list_commands (Current, event_window, "Combo box")
			set_parent (par)
		end

	set_tabs is
			-- Set the tabs for the action window
		do
			set_primitive_tabs
			tab_list.extend(text_field_tab)
			tab_list.extend(list_tab)
			tab_list.extend(combo_tab)
			create action_window.make(Current, tab_list)
		end


feature -- Access

	item1: EV_LIST_ITEM
			-- an item

	item2: EV_LIST_ITEM
			-- an item

	item3: EV_LIST_ITEM
			-- an item

	end -- class COMBO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

