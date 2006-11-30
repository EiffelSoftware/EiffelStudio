
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is.  Prefix operator not accepted in
	--	strip expression.

class TEST

creation
	make
feature

	make is
		do
			ext ($ prefix "&&&");
			print (strip (prefix "&&&"));
			
			-- These remaining lines show how one cannot
			-- assign to an attribute with a prefix operator
			-- name or use it as a Choice in a When_part.
			
			-- prefix "&&&" := true;
			-- inspect
				-- 1
			-- when prefix "###" then
			-- end
		end;

	prefix "&&&": BOOLEAN;
	
	prefix "###": INTEGER is 1;

	ext (arg: ANY) is
		do
		end;
end
