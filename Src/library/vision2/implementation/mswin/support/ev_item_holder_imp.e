indexing
	description:
			" EiffelVision item container. This class%
			% has been created to centralise the%
			% implementation of several features for%
			% EV_LIST_IMP and EV_MENU_ITEM_HOLDER"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_HOLDER_IMP

inherit
	EV_ITEM_HOLDER_I

	EV_ITEM_EVENTS_CONSTANTS_IMP
		rename
			command_count as item_command_count
		end

feature -- Element change

	add_item (item_imp: like item_type) is
			-- Add `item_imp' to the list.
		do
			insert_item (item_imp, count + 1)
		end

	insert_item (item_imp: like item_type; index: INTEGER) is
			-- Insert `item_imp' at the `index' position.
		deferred
		end

	move_item (item_imp: like item_type; index: INTEGER) is
			-- Move `item_imp' to the `index' position.
		do
			remove_item (item_imp)
			insert_item (item_imp, index)
		end

	remove_item (item_imp: like item_type) is
			-- Remove `item_imp' from the list.
		deferred
		end

feature {NONE} -- Implementation

	item_type: EV_ITEM_IMP is
			-- An empty feature to give a type.
			-- We don't use the genericity because it is
			-- too complicated with the multi-platform design.
			-- Need to be redefined.
		deferred
		end

end -- class EV_ITEM_HOLDER_IMP

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
