class EXTEND_TABLE [T, U->HASHABLE]

inherit
	HASH_TABLE [T, U]

creation
	make

feature -- Merging

	merge (other: EXTEND_TABLE [T, U]) is
			-- Merge `other' into Current.
		require
			other_exists: other /= Void
		do
			from
				other.start
			until
				other.after
			loop
				force (other.item_for_iteration, other.key_for_iteration);
				other.forth
			end
		end;

feature -- Cursor for iteration

	go (p: INTEGER) is
			-- set position_for_iteration to p
		do
			iteration_position := p;
			if p < 0 then
				iteration_position := - 1	
			end;
		end;

end
