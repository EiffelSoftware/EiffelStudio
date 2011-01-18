class
	ADDER_BRANCH

inherit
	TREE_BRANCH [INTEGER]
	ADDER_IMP

create
	make

feature

	make (a_left, a_right: separate PAR_TREE [INTEGER])
		do
			left  := a_left
			right := a_right
		end

end
