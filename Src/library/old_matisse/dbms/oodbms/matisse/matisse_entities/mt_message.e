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
