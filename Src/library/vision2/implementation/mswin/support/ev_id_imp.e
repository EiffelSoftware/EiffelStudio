indexing
	description: "Eiffel Vision item id. Mswindows implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ID_IMP

feature {NONE} -- Initialization

	make_id is
			-- Generate new ID and assign it to `id'.
		do
			id := counter.item
			counter.set_item (id + 1)
		end

feature -- Access

	id: INTEGER
			-- Unique identifier within system.

feature {NONE} -- Implementation

	counter: INTEGER_REF is
			-- Counter to set unique id's to items.
		once
			create Result
			Result.set_item (1)
		end

invariant
	make_called: id > 0

end -- class EV_ID_IMP

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

