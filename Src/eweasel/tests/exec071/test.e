
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			!!original_string.make (args.item (2).to_integer);
			original_string.fill_blank;
			original_depth := args.item (1).to_integer;
			f (original_depth, original_string);
		end;

	original_string: STRING;
	
	original_depth: INTEGER;

	f (depth: INTEGER s: STRING) is 
		do 
			if depth > 0 then 
				f (depth - 1, s.substring (1, s.count - 1)); 
			end 
		end;
	
end
