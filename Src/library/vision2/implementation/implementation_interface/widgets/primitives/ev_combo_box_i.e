indexing 
	description: "EiffelVision Combo-box. Implementation interface"
	status: "See notice at end of class"
	names: widget
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_COMBO_BOX_I

inherit
	EV_TEXT_FIELD_I

feature -- Access

	get_item (index: INTEGER): EV_COMBO_BOX_ITEM is
			-- Text at the one-based `index'
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index < count
		deferred
		ensure
			result_not_void: Result /= Void
		end

	selected_item: EV_COMBO_BOX_ITEM is
			-- Give the item which is currently selected
		require
			exists: not destroyed
		deferred
		end

feature -- Measurement

	extended_height: INTEGER is
			-- height of the combo-box when the children are
			-- visible.
		require
			exists: not destroyed
		deferred
		end

feature -- Status report

	count: INTEGER is
			-- number of items in the list of the combo-box
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	select_item (index: INTEGER) is
			-- Select an item at the one-based `index' of the list.
		require
			exists: not destroyed
			index_large_enough: index > 0
			index_small_enough: index <= count
		deferred
		end

feature -- Element change

	clear_items is
			-- Remove all the elements of the combo-box.
		require
			exists: not destroyed
		deferred
		end

feature -- Event : command association

	add_selection_command (a_command: EV_COMMAND; arguments: EV_ARGUMENTS) is	
			-- Make `command' executed when an item is
			-- selected.
		require
			exists: not destroyed
		deferred
		end

feature {EV_COMBO_BOX_ITEM} -- Implementation

	add_item (an_item: EV_COMBO_BOX_ITEM) is
			-- Add an item to the list of the combo-box
		deferred
		end

end -- class EV_COMBO_BOX_I

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
