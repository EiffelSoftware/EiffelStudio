class TEST 

create
	make

feature

	make
		local
			a: A [B, C [ANY, B]]
			e: E [B, C [ANY, B]]
			f: F [B, C [ANY, B]]
		do
			create a
			create e
			create f
		end

end
