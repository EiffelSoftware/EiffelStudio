class TEST
	
create
	make

feature {NONE}

	make
		local
			test3: TEST3
		do
			create test3.make
			test3.clear
		end

end
