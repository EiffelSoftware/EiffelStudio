class 
	EMPTY

inherit 
	STATE
		redefine
			process
		end

feature 

	operation is 
			-- Empty the stack and set accumulator and register to 0.
		do 
			from
				register := 0.0
			until
				operand_stack.count = 1
			loop
				operand_stack.remove
			end
			operand_stack.replace (0.0)
		ensure then
			register = 0.0;
			operand_stack.count = 1
			operand_stack.item = 0.0
		end
	
	process is
			-- Process user's answer.
		do
			operation
		end

end -- class EMPTY 

--|----------------------------------------------------------------
--| EiffelBase: Library of reusable components for Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering (ISE).
--| For ISE customers the original versions are an ISE product
--| covered by the ISE Eiffel license and support agreements.
--| EiffelBase may now be used by anyone as FREE SOFTWARE to
--| develop any product, public-domain or commercial, without
--| payment to ISE, under the terms of the ISE Free Eiffel Library
--| License (IFELL) at http://www.eiffel.com/products/base/license.html.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

