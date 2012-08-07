class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
			-- Execute test.
		do
			linked_set_force_orig
			linked_set_sequence_put_orig
		end

	linked_set_force_orig
			-- Wrong inherited postcondition:
			-- `count; does not always increase.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.force (1)
		end

	linked_set_sequence_put_orig
			-- Wrong inherited postcondition:
			-- `count; does not always increase.
		local
			set: LINKED_SET [INTEGER]
		do
			create set.make
			set.extend (1)
			set.sequence_put (1)
		end

	
end