indexing
	description:
		"Eiffel Vision item list. Implementation interface."
	status: "See notice at end of class."
	keywords: "item, list"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ITEM_LIST_I [G -> EV_ITEM]

inherit
	EV_DYNAMIC_LIST_I [G]
		redefine
			interface
		end

feature -- Access

	item_by_data (data: ANY): like item is
			-- First item with `data'.
		require
			data_not_void: data /= Void
		local
			c: CURSOR
			curr_data: like data
		do
			c := cursor
			from
				interface.start
			until
				interface.after or Result /= Void
			loop
				curr_data := interface.item.data
				if equal (curr_data, data) then
					Result := interface.item
				end
				interface.forth
			end
			go_to (c)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ITEM_LIST [G]
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'

end -- class EV_ITEM_LIST_I

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

