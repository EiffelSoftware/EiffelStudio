
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is.  Finish_freezing.  Execute `test 10000'.
	-- Prints wrong values (all zeroes).  Also, dies after awhile.
	-- Uncomment first line in body of `concat'.  Re-compile and re-run.
	-- Correct values printed, but still dies with run-time panic.

class TEST

inherit
	ARGUMENTS
creation
	make
feature

	make is
		local
			s: STRING;
			k, count: INTEGER;
		do
			count := argument (1).to_integer;
			!!s.make (20);
			s.append ("turkey");
			from
				k := 1;
			until
				k > count
			loop
				io.putint (k);
				io.putchar ('%T');
				io.putstring (concat (
					<< 001B, 111B, 100B >>).out);
				io.new_line;
				k := k + 1;
			end
		end;

	animal: STRING is "weasel";

	concat (list: ARRAY [BIT 5]): BIT 15 is
		local
			k, m, pos, the_count, total_len: INTEGER;
			elem: BIT 5;
		do
			-- k := k;	-- Uncomment this line and recompile
					-- after incorrect output.
			from
				k := list.lower;
			until
				k > list.upper
			loop
				total_len := total_len + list.item (k).count;
				k := k + 1;
			end;
			
			from
				pos := 1;
				k := list.lower;
			until
				k > list.upper
			loop
				elem := list.item (k);
				the_count := elem.count;
				
				from
					m := 1;
				until
					m > the_count
				loop
					Result.put (elem.item (m), pos);
					pos := pos + 1;
					m := m + 1;
				end;
				k := k + 1;
			end
		end;

end

