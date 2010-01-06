class TEST

inherit
	TEST1 [STRING]
		redefine
			f
		end

create
	make

feature

	make
		do

		end

	t1: TEST3 [INTEGER, INTEGER]

	f
		do
		end

end

