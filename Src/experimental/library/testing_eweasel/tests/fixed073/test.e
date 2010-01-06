
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

	-- To reproduce error:
	-- 1. Compile class as is. Finish_freezing.
	-- 2. Uncomment the line below declaring `b' of type INTEGER
	--    and comment out the line below it declaring
	--    it of type STRING (thereby changing its type).
	-- 3. Rerun es3.  The invalid class is accepted.
	-- 4. Now change the type of `b' back to STRING. Rerun es3.
	-- 5. Next, uncomment the declaration and call of `try'. Rerun es3.
	-- 6. Then, redo steps 2 and 3.
	-- 7. Comment out the print in the body of `try'. Rerun es3.
	-- 8. Uncomment out the print in the body of `try'. Rerun es3.
	-- 9. Execute the system: disaster.
creation
	make
feature
	
	make is
		local
			c: like b;
		do
			c := "Hey you Eiffel weasel";
			io.putstring (c); io.new_line;
		end;
	
	$ANCHOR_DECL
	
end 
