class EXTEND_TABLE [T, U->HASHABLE]

inherit

	HASH_TABLE [T, U]

creation

	make

feature -- Iterartion

	start is
			-- Iteration initialization
		do
			position_for_iteration := keys.lower - 1;
			forth
		end;

	offright: BOOLEAN is
			-- Is the cursor at the end ?
		do
			Result := position_for_iteration > keys.upper
		end;

	forth is
			-- Advance iteration
		require
			not_offright: not offright
		local
			stop: BOOLEAN
		do
			from
			until
				stop
			loop
				position_for_iteration := position_for_iteration + 1;
				stop := offright 
					or else valid_key (keys.item (position_for_iteration))
			end
		end;

	item_for_iteration: T is
			-- Element at current iteration position
		require
			not_offright: not offright
		do
			Result := content.item (position_for_iteration)
		end;

	key_for_iteration: U is
			-- Key at current iteration position
		require
			not_offright: not offright
		do
			Result := keys.item (position_for_iteration)
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
				other.offright
			loop
				force (other.item_for_iteration, other.key_for_iteration);
				other.forth
			end
		end;

feature -- Cursor for iteration

	position_for_iteration : INTEGER;
			-- Cursor for iteration primitives

	go (p: INTEGER) is
			-- set position_for_iteration to p
		do
			position_for_iteration := p;
			if p < keys.lower then
				position_for_iteration := keys.lower - 1	
			end;
		end;

end
