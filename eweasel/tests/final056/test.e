class TEST
	
create
	make

feature {NONE}

	make
		local
			test1: TEST1 [HASHABLE]
		do
			create test1.make
		end

end
