indexing 
	description: "EiffelVision Combo-box. A combo-box contains a %
				% text field and a button. When the button is    %
				% pressed, a list of possible choices is opened."
	note: "The `height' of a combo-box is the one of the text  %
		% field. To have the height of the text field plus the %
		% list, use extended_height."
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_COMBO_BOX

inherit
	EV_TEXT_FIELD
		redefine
			implementation,
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create a combo-box with `par' as parent.
		do
			!EV_COMBO_BOX_IMP!implementation.make (par)
			widget_make (par)
		end

feature -- Access

	get_item (index: INTEGER): EV_COMBO_BOX_ITEM is
			-- Text at the zero-based `index'
		require
			exists: not destroyed
			index_large_enough: index >= 0
			index_small_enough: index < count
		do
			Result := implementation.get_item (index)
		end

	selected_item: EV_COMBO_BOX_ITEM is
			-- Give the item which is currently selected
		require
			exists: not destroyed
		do
			Result := implementation.selected_item
		end

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
			exists: not destroyed
		do
			Result := implementation.extended_height
		end

feature -- Status report

	count: INTEGER is
			-- number of items in the list of the combo-box
		require
			exists: not destroyed
		do
			Result := implementation.count
		end

feature -- Element change

	clear_items is
			-- Remove all the elements of the combo-box.
		require
			exists: not destroyed
		do
			implementation.clear_items
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
			-- Make `command' executed when an item is
			-- selected.
		require
			exists: not destroyed
		do
			implementation.add_selection_command (a_command, arguments)
		end

feature -- Implementation

	implementation: EV_COMBO_BOX_I

end -- class EV_COMBO_BOX

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
