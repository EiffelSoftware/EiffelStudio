class ZZ

inherit
	STORABLE

create

	make

feature

	make
		do
			create attr1.make (create {KL_COMPARABLE_COMPARATOR [INTEGER]}.make)
		end

	attr1: DS_AVL_TREE [AA, INTEGER]

end
