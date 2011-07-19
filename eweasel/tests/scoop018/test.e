
class TEST
inherit
	ANY
		redefine
			default_create
		end
create
	make, default_create
feature
	make
		do 
		   default_create
		   start (y)
		end

	default_create
		do 
		   create x
		   create y
		end

	try_test (b: separate TEST2)
	     do
	     end

	start (b: separate TEST2)
		do
			b.try_test2 (x, create {separate TEST})
	        end

	x: separate TEST1

	y: separate TEST2
end
