
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

indexing
	-- To reproduce error:
	-- Compile with class as is.  After es3 finishes freezing,
	-- uncomment the lines below with `, class' and recompile.
	-- When es3 reports syntax error, comment out the line below
	-- with `, class' on it and hit return to retry.
	
	abc: text 
	$INDEX_ITEM

class TEST
creation
	make
feature
	make is
		do
		end;
end 

