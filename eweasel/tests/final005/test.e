
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
creation
	make

feature

	make is
		do
			io.putbool (is_bigger ("weasel", "weasel", "weasel"));
			io.new_line;
		end

	is_bigger (s1, s2, s3: STRING): BOOLEAN is
		do
			Result := is_greater (concat (<<s1, "/", s2>>), s3);
		end

	is_greater (s1, s2: STRING): BOOLEAN is
		do
			Result := s1 > s2;
		end

	concat (list: ARRAY [STRING]): STRING is
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
				!!Result.make (len);
				pos := list.lower;
			until
				pos > list.upper
			loop
				Result.append (list.item (pos));
				pos := pos + 1;
			end;
		end;
				
end
