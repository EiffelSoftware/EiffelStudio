class EXTEND_TABLE [T, U->HASHABLE]

inherit

	HASH_TABLE [T, U]

creation

	make

feature -- Iterartion

	start is
			-- Iteration initialization
		do
			pos_for_iter := keys.lower - 1;
			forth
		end;

	offright: BOOLEAN is
			-- Is the cursor at the end ?
		do
			Result := pos_for_iter > keys.upper
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
				pos_for_iter := pos_for_iter + 1;
				stop := offright or else valid_key (keys.item (pos_for_iter))
			end
		end;

	item_for_iteration: T is
			-- Element at current iteration position
		require
			not_offright: not offright
		do
			Result := content.item (pos_for_iter)
		end;

	key_for_iteration: U is
			-- Key at current iteration position
		require
			not_offright: not offright
		do
			Result := keys.item (pos_for_iter)
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

feature {NONE} -- Cursor for iteration

	pos_for_iter: INTEGER;
			-- Cursor for iteration primitives

end
