class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			chain_fill
		end

	chain_fill
			-- When Current = other only one element is appended.
		local
			chain: CHAIN [INTEGER]
		do
			create {LINKED_LIST [INTEGER]} chain.make
			chain.extend (1)
			chain.extend (2)
			chain.extend (3)
			chain.fill (chain)
			check chain.count = 6 end
			-- chain.count = 3 would also make some sense, but for sure not 4
		end
		
end