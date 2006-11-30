
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

expanded class
	CLASS_A

inherit
	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create is
			-- Initialize
		do
			counter.set_item (counter.item + 1)
			print (counter.item)
			io.new_line;
			a_value := 8
		ensure then
			a_value_ok: a_value = 8
		end
		
	a_value : INTEGER

	counter: INTEGER_REF is
			-- 
		once
			create Result
		end

	to_reference: ANY is
		do
		end

invariant
	CLASS_A_violation: a_value = 8

end -- class CLASS_A
