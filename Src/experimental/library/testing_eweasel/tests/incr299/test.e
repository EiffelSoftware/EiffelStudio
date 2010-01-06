
--| Copyright (c) 2008, David Hollenberg, USC Information Sciences Institute
--| All rights reserved.


class TEST
create
	make, try
feature
	
	make is
		do
			create x.make
		end
	
	try
		do
			print ("In try%N")
		end
	
	weasel
		do
			print ("In weasel%N")
		end
	
	$ADDED_FEATURE
	
	x: TEST1 [TEST]

end
