indexing
	description: "Question"
	external_name: "ISE.Examples.Calculator.Question"
	
class 
	QUESTION 

inherit 
	STATE 
		redefine 
			process
		end

create
	make

feature -- Basic Operations
	
	operation is
		indexing
			description: "Useless"
			external_name: "Operation"
		do
		end

	process is 
		indexing
			description: "Get a number from user input."
			external_name: "Process"
		do 
			io.put_string ("Enter a number, followed by <return>: ")
			io.read_real
			operand_stack.put (io.last_real)
		end
	
end -- class QUESTION 

--|----------------------------------------------------------------
--| .NET: library of reusable components for ISE Eiffel.
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

