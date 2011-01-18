class
	ADDER_LEAF

inherit
	TREE_LEAF [INTEGER]
	ADDER_IMP

create
	make

feature

	make (a_list: SPECIAL [INTEGER])
		do
			list := a_list
		end

end
