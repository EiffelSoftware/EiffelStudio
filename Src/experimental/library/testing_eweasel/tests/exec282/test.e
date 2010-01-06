class TEST

create
	make

feature
	 make
		local
			a: ARRAY [B [STRING]]
		do
			create a.make (1, 10)
		end
end
