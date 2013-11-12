class DS_SPARSE_CONTAINER_CURSOR [G, K]

inherit

	DS_LINEAR_CURSOR [G]

create

	make

feature {NONE}

	make (a_container: like container)
		do
			container := a_container
		end

feature

	container: DS_SPARSE_CONTAINER [G, K]

end
