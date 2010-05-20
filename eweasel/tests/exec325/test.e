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
			-- Run test.
		local
			test1: TEST1 [INTEGER_32]
			test2: TEST1 [CHARACTER_8]
		do
			create test1
			test1.do_something
			print (test1.f)
			print ("%N")

			create test2
			test2.do_something
			print (test1.f)
			print ("%N")

			do_something
			print (f)
			print ("%N")
		end

	f: INTEGER
		do

		end

end
