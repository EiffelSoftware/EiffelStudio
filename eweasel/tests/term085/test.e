
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST
create 
	make
feature 
	make is
		do
			print (agent io.put_string (?))
			try (agent weasel)
  		end
	
	try (p: PROCEDURE [ANY, TUPLE]) is
		local
			s: ARRAY [STRING]
		do
			create s.make (1, 0)
			p.call (Void)
			print ((agent s.make (?, 2)).generating_type); io.new_line
  		end
	
	weasel is
		do
			io.put_string ("Weasels%N")
  		end
	
invariant
	agent {ARRAY [STRING]}.make /= Void
end
