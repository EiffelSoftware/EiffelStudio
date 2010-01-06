
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

$EXPANDED class TEST2
inherit
	ANY
		redefine
			default_create
		end
create
	$CREATION_PROCS
feature
	

	default_create is 
		do 
			print ("Called default_create%N") 
		end
	
	make2 is 
		do 
			print ("Called make2%N") 
		end
end
