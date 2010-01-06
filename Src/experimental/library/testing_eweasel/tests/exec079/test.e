
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS
	MEMORY
creation
	make
feature
	make (args: ARRAY [STRING]) is
		do
			collection_off;
			no_message_on_failure
			max := args.item (1).to_integer;
			try;
		end

	try is
		do
			count := count + 1;
			io.putstring ("Body: ");
			io.putint (count); io.new_line;
			if count < max then
				raise ("weasels");
			end
		rescue
			io.putstring ("Rescue: ");
			io.putint (count); io.new_line;
			if count = 1 then
				io.putstring ("Calling try recursively%N");
				try;
			end
			retry;
		end
	
	max: INTEGER
	
	count: INTEGER
end
