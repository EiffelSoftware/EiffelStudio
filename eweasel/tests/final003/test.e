
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create
	make

feature

	make
		do
			io.putstring (new_file_name ("Weasel")); io.new_line;
		end;

	new_file_name (pre: STRING): STRING
		local
	    		seq: TEST1;
		do 
			create seq;
			Result := concat (<< pre, "_", formatted (seq.seq_value), "_" >>);
		end;

	formatted (i : INTEGER): STRING
		do
			Result := "weasel";
		end;

	concat (list: ARRAY [STRING]): STRING
			-- Concatenation of all the strings in `list'.
			-- Void strings are ignored.
		require
			list_not_void: list /= Void
		local
			pos, len: INTEGER;
		do
			from
				pos := list.lower;
			until
				pos > list.upper
			loop
				len := len + list.item (pos).count;
				pos := pos + 1;
			end;
			from 
				create Result.make (len);
				pos := list.lower;
			until
				pos > list.upper
			loop
				Result.append (list.item (pos));
				pos := pos + 1;
			end;
		ensure
			result_not_void: Result /= Void;
		end;
end
