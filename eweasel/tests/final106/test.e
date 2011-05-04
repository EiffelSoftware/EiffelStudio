class TEST
create
	make

feature {NONE}

	make
		do
			create t1.make
		end

	t1: TEST2 [INTEGER]

end
