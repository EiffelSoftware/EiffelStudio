class
	TEST1 [G -> STRING, H -> ANY create default_create end]

inherit
	TEST2 [H, CELL [INTEGER]]

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
