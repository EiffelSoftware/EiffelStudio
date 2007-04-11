
--| Copyright (c) 1993, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.

class 
	TEST
creation	
	make
feature
	make
		do
		create l_test_4.default_create
		end	

	$VTGD1_1 l_test_1: MULTI [INTEGER]
	$VTGD1_2 l_test_2: MULTI [INTEGER, INTEGER, INTEGER, ANY, ANY, ANY, ANY]
	$VTGD2_1 l_test_3: MULTI [NUMERIC, COMPARABLE_NUMERIC, COMPARABLE]
	$VTGD3_1 l_test_4: MULTI [COMPARABLE_NUMERIC, COMPARABLE, NUMERIC]
	--numeric: NUMERIC -- if you comment in this line it will work

end
