class
	TEST1 [G -> HASHABLE]

create
	make

feature

	s: HASH_TABLE [like args.item_for_iteration, like args.key_for_iteration]

	make
		do
			create s.make (10)
		end

	args: HASH_TABLE [$ACTUAL_GENERIC_1, $ACTUAL_GENERIC_2]

	formal_g: G

end
