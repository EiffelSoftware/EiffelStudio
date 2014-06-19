class TEST 

create
	make

feature

	make
		local
			a: A [B, C [ANY, B]]
		do
			create a
		end

end
