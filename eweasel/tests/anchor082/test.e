class TEST 

create
	make

feature

	make
		local
			t: A [B, C [ANY, B]]
		do
			create t
		end

end
