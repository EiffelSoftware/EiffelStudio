indexing
	description: 
		"EiffelVision menu, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_MENU_I
	
inherit
	EV_MENU_ITEM_HOLDER_I

feature {NONE} -- Initialization

	make is
			-- Create an empty menu.
		deferred
		end	

	make_with_text (txt: STRING) is
			-- Create an empty menu with `label' as label. 
		deferred
		end	

feature -- Access

	count: INTEGER is
			-- Number of items in the menu.
		deferred
--			Result := ev_children.count
		end

	get_item (index: INTEGER): EV_MENU_ITEM is
			-- Give the item of the list at the zero-base
			-- `index'.
		require
			exists: not destroyed
			item_exists: (index <= count) and (index >= 0)
		deferred
--			Result ?= (ev_children.i_th (index)).interface
		end

	text: STRING is
			-- Label of the current menu
		require
			exists: not destroyed
		deferred
		end

feature -- Element change

	set_parent (par: EV_MENU_HOLDER) is
			-- Make `par' the new parent of the item.
		require
			exists: not destroyed
		deferred
		end

feature {EV_MENU_ITEM_IMP, EV_OPTION_BUTTON_IMP} -- Implementation

--	ev_children: ARRAYED_LIST [EV_MENU_ITEM_IMP]
--			-- List of the children

--	clear_ev_children is
--			-- Clear all the items of the list.
--9		require
--			exists: not destroyed
--		local
--			list: ARRAYED_LIST [EV_MENU_ITEM_IMP]
--		do
--			from
--				list := ev_children
--				list.start
--			until
--				list.after
--			loop
--				list.item.interface.remove_implementation
--				list.forth
--			end
--			list.wipe_out
--		end

end -- class EV_MENU_I

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
