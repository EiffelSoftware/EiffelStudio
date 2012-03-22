class MY_TREE1_CURSOR

inherit
	TWO_WAY_TREE_CURSOR [INTEGER]
		redefine
			active
		end

create
	make

feature {TWO_WAY_TREE} -- Access

	active: MY_TREE1
			-- Current node

end
