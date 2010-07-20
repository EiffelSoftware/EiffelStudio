class TEST

create
	make

feature
	 make
		local
			a: ARRAY [B [STRING]]
			b: B [STRING]
		do
			create a.make_filled (b, 1, 10)
		end
end
