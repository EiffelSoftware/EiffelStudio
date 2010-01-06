
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
			create x
			x.try
		end

	default_create
                do
			print ("In TEST default_create%N")
		end

	x: TEST1 [DOUBLE, INTEGER, TEST2 [DOUBLE, INTEGER]]
end
