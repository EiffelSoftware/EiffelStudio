class EXTEND_TABLE [T, U->HASHABLE]

inherit

	HASH_TABLE [T, U]

creation

	make

feature -- Iterartion

	offright: BOOLEAN is obsolete "Use `after'"
		do
			Result := after
		end;

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

	position_for_iteration : INTEGER is
		obsolete "Use pos_for_iter"
		do
			Result := pos_for_iter
		end

	go (p: INTEGER) is
			-- set position_for_iteration to p
		do
			pos_for_iter := p;
			if p < keys.lower then
				pos_for_iter := keys.lower - 1	
			end;
		end;

end
