
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY;
	EXCEPTIONS
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			collection_off;
			original_depth := args.item (1).to_integer;
			f (original_depth, args.item (2).to_integer);
		end;

	original_depth: INTEGER;

	f (depth, exception_in_rescue_depth: INTEGER) is 
		do 
			if depth > 0 then 
				f (depth - 1, exception_in_rescue_depth); 
			elseif exception_in_rescue_depth > 0 then
				weasel (exception_in_rescue_depth);
			end 
		end;
	
	weasel (exception_in_rescue_depth: INTEGER) is
		local
			tried: BOOLEAN
		do
			if not tried then
				raise ("weasel");
			end
		rescue
			tried := True;
			f (original_depth, exception_in_rescue_depth - 1);
			retry;
		end
end
