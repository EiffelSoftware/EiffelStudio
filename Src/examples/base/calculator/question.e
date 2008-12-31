note
	legal: "See notice at end of class."
	status: "See notice at end of class."
class 
	QUESTION 

inherit 
	STATE 
		redefine 
			process
		end

feature 
	
	operation
			-- Useless.
		do
		end

	process 
			-- Get a number from user input.
		do 
			io.putstring ("Enter a number, followed by <return>: ")
			io.read_real
			operand_stack.put (io.lastreal)
		end
	
note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class QUESTION 

