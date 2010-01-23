class ZZ [G, H -> COMPARABLE]

inherit
	STORABLE

create

	make

feature

	make
		do
			create attr1.make (create {KL_COMPARABLE_COMPARATOR [H]}.make)
		end

	attr1: MY_AVL_TREE [H, G]

end
