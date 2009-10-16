class TEST

inherit
	TEST4 [STRING]
		redefine
			force
		end

create
	make

feature

	make
		do

		end

	t1: TEST3 [INTEGER, INTEGER]

	force
		do
		end

end

