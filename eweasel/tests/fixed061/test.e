
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce problem:
	-- Compile class as is, with /tmp/answer having a `F' to finalize.
	-- Generated C code won't compile with cc.

class 
	TEST
inherit
	DOUBLE_MATH
create	
	make
feature
	
	make
		local
			k, count: INTEGER;
			prime_list: LINKED_LIST [INTEGER];
		do
			from
				count := 0;
				k := 2 ;
				create prime_list.make;
			until
				k > 10000
			loop
				if prime (k, prime_list) then
					prime_list.extend (k);
					count := count + 1;
					io.putint (count); io.putchar (' ');
					io.putint (k); io.new_line;
				end;
				k := k + 1;
			end
		end;
	

	prime (n: INTEGER; known_primes: LINKED_LIST [INTEGER]): BOOLEAN
		local
			k: INTEGER;
			s: DOUBLE;
		do
			from
				known_primes.start;
				s := ceiling (sqrt (n));
			until
				known_primes.after or else k > s or else Result
			loop
				if n \\ known_primes.item = 0 then
					Result := True;
				end;
				known_primes.forth;
			end;
			Result := not Result;
		end;

end
