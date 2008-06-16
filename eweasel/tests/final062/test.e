class TEST
create
	make

feature {NONE}

	make
		local
			t1: TEST1 [STRING]
		do
			create t1.make
		end

end
