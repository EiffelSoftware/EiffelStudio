indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class EMPTY 

