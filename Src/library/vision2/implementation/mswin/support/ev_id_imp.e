indexing
	description:
		" A common type or all the component that have an id%
		% and use it through a wm_command message to the %
		% parent."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ID_IMP

feature -- Access

	id: INTEGER
		-- Identifier of the item

feature -- Basic operations

	on_activate is
			-- Is called by the menu when the item is activated.
		deferred
		end

feature {NONE} -- Implementation

	new_id: INTEGER is
			-- Give a new unique id.
		do
			Result := counter.item
			counter.set_item (counter.item + 1)
		end

	counter: INTEGER_REF is
			-- A counter to set unique ids.
		once
			!! Result
			Result.set_item (1)
		end

end -- class EV_ID_IMP

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
