class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			linked_stack_copy
			linked_stack_make_1
			linked_stack_make_2
			linked_stack_replace
			linked_stack_is_equal
			linked_stack_make_orig
		end

	linked_stack_copy
			-- `copy' is inherited from LINKED_LIST
			-- and uses `item' to access each element of the other stack;
			-- however in LINKED_STACK `item' is redefined to return the top element,
			-- so the copy just has many copies of the top element.
		local
			stack1, stack2: LINKED_STACK [INTEGER]
		do
			create stack1.make
			stack1.put (1)
			stack1.put (2)
			create stack2.make
			stack2.copy (stack1)
			stack2.remove
			check stack2.item = 1 end
		end

	linked_stack_make_1
			-- Calling `make' not as a creation procedure can result in both `before' and `after' being True
			-- (if `after' was True before the call).
		local
			stack: LINKED_STACK [INTEGER]
		do
			create stack.make
			stack.put (1)
			stack.remove
			stack.make
		end

	linked_stack_make_2
			-- Calling `make' not as a creation procedure does not always produce an empty stack
			-- (contrary to the header comment of `make').
		local
			stack: LINKED_STACK [INTEGER]
		do
			create stack.make
			stack.put (1)
			stack.make
			check stack.is_empty end
		end

	linked_stack_replace
			-- `replace' does not always replace the top element
			-- (active does not always point to the `first_element').
		local
			stack: LINKED_STACK [INTEGER]
		do
			create stack.make
			stack.put (1)
			stack.remove
			stack.put (1)
			stack.put (2)
			stack.replace (3)
		end

	linked_stack_is_equal
			-- See `linked_stack_copy'.
		local
			stack1, stack2: LINKED_STACK [INTEGER]
		do
			create stack1.make
			stack1.put (1)
			stack1.put (2)
			create stack2.make
			stack2.put (2)
			stack2.put (2)
			check not stack1.is_equal (stack2) end
		end
		
	linked_stack_make_orig
			-- Calling `make' not as a creation procedure sets `before' to True
			-- without adjusting `active'.
		local
			stack: LINKED_STACK [INTEGER]
		do
			create stack.make
			stack.put (1)
			stack.put (2)
			stack.remove
			stack.put (1)
			stack.make
		end
		
end