class DS_SPARSE_TABLE_CURSOR [G, K]

inherit

	DS_SPARSE_CONTAINER_CURSOR [G, K]
		redefine
			container
		end

	DS_LINEAR_CURSOR [G]
		redefine
			container
		end

create

	make

feature

	container: DS_SPARSE_TABLE [G, K]

end
