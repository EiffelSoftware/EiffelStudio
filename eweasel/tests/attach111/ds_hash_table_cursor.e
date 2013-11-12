class DS_HASH_TABLE_CURSOR [G, K -> HASHABLE]

inherit

	DS_SPARSE_TABLE_CURSOR [G, K]
		redefine
			container
		end

create

	make

feature

	container: DS_HASH_TABLE [G, K]

end
