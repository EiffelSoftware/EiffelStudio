class MY_TREE3_CURSOR

inherit
	LINKED_TREE_CURSOR [INTEGER]
		redefine
			active
		end

create
	make

feature {LINKED_TREE} -- Access

	active: MY_TREE3
			-- Current node

end
