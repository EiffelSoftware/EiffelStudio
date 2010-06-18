class
	TEST

create
	make

feature

	make
	    local
	        zero: REAL_64
	        minus_one: REAL_64
	        minus_zero: REAL_64
	        abs_minus_zero: REAL_64
	    do
	        zero := 0.
	        minus_one := -1
	        minus_zero := zero * minus_one
	        abs_minus_zero := minus_zero.abs
	        print (abs_minus_zero)
	        print ("%N")
	    end

end
