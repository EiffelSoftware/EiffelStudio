class MT_ATTACH 


feature -- Action

	execute is
		-- Execute routine
	do
		body.execute
	end

feature -- State

	body: MT_ROUTINE -- routine

feature -- Change of state

	set_behavior (r: MT_ROUTINE) is
		-- Set routine with 'r'
	local
		c_name : ANY
		c_args : ARRAY[ANY]
	once
		body := r
		c_name := r.name.to_c
		c_args := r.arguments
		clip ($execute, $c_name, $c_args)
	end -- set_behaviour

	
feature {NONE} -- External routine

	clip (routine: POINTER; routine_name: POINTER; arguments: POINTER) is
		external 
			"C"
		end

end

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

