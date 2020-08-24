
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
inherit
	EXCEPTIONS

create

	make
feature

	make
		local
			tried: BOOLEAN;
		do
			if not tried then
				print (compare ('a', 'b', False)); io.new_line;
			end
		rescue
			tried := True;
			io.put_string ("In make rescue clause%N");
			retry;
		end;

	compare (c1, c2: CHARACTER; flag: BOOLEAN): BOOLEAN
		local
			s: STRING;
			tried: BOOLEAN;
		do
			if not tried then 
				create s.make (0);
				s.append ("wimp");
				if flag then
					Result := c1 = c2;
				else
					Result := caseless_char_eq(c1, c2);
				end;
			end
		rescue
			io.put_string ("In compare rescue clause - string is ");
			io.put_string (s); io.new_line;
			tried := True;
			retry;
		end;
    
	caseless_char_eq (c1, c2:CHARACTER): BOOLEAN
		do
			io.put_string ("Raising exception%N");
			raise("weasels");
		end;

end
