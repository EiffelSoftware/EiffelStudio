class MT_MESSAGE

inherit

	MT_MESSAGE_EXTERNAL

Creation

	make

feature {NONE} -- Initialization

	make(selector : STRING) is
		-- Get message from its name
		require
			selector_is_not_void : selector /= Void
			selector_is_not_empty : not selector.empty
		local
			c_selector : ANY
		do
			c_selector := selector.to_c	
			mid := c_get_message($c_selector)
		end -- make

feature {NONE} -- Implementation
	
	mid : INTEGER -- Identifier in dataabse

end -- class MT_MESSAGE

--|----------------------------------------------------------------
--| EiffelStore: library of reusable components for ISE Eiffel.
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

