class DS_HASH_TABLE [G, K -> HASHABLE]

inherit

	DS_SPARSE_TABLE [G, K]
		redefine
			new_cursor
		end

create

	make_with_test

feature

	new_cursor: DS_HASH_TABLE_CURSOR [G, K]
		do
			create Result.make (Current)
		end

end
