
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
		
	-- To reproduce error:
	-- Compile class as is.
	-- Switch types of `t' and `b' in TEST1 (i.e. change type of `t'
	--	to BOOLEAN and type of `b' to INTEGER).  Save and rerun es3.
	-- When es3 reports violations of VWEQ and VWBE in class TEST,
	--	switch types of `t' and `b' back to what they were
	--	originally (when they were correct).  Save and hit return.
	--	Es3 still reports the same validity violations even
	--	though there are none.
	-- Change class TEST without modifying it (add blank line and 
	-- 	delete it), save and hit return again to es3.  Es3 now
	--	realizes that everything is OK even though no class texts
	--	have been changed.  Only date of TEST has changed.
inherit TEST1;

creation
	make
feature
	
	make is
		do
			from
			until
				t /= 3
			loop
				check b end
			end
		end;
		
	
end 
