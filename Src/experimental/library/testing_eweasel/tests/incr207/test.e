
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make
feature
	make is
		do
			try
		end
	
	try is
        	indexing
            		$TAG: create {TEST2}.make 
        	end
		do
			print ("Weasel");
		end     
end
