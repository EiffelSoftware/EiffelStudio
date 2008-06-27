class
	TEST

create
	make

feature

	make is
		local
			r1: STRING
		do
			bad_routine ("")
			bad_routine (r1.substring(1, 2).append ("")).do_nothing
		end

	bad_routine (other: ANY): like other is
		do
		end

end
