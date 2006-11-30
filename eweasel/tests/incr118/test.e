
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	MEMORY
creation
	make
feature

	make (args: ARRAY [STRING]) is
		local
			k, count: INTEGER;
			s: STRING;
		do
			collection_off;
			count := args.item (1).to_integer;
			from
				k := 1;
			until
				k > count
			loop
				s := concat (<< 1B, 1B, 1B >>).out;
				k := k + 1;
			end
		end;

	concat (list: ARRAY [BIT 500]): $RETURN_TYPE is
		local
			k, total_len: INTEGER;
		do
			from
				k := list.lower;
			until
				k > list.upper
			loop
				total_len := total_len + list.item (k).count;
				k := k + 1;
			end;
			io.putint (total_len); io.new_line;
		end;

end

