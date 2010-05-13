class
	TEST1 [G -> HASHABLE, H -> ANY create default_create end]

inherit
	TEST2 [H, G]

feature

	make
		local
			v: like item
		do
			create v
		end

	item: H
		do
		end

end
