
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
			print (io~put_string (?))
			try (~weasel)
  		end
	
	try (p: PROCEDURE [ANY, TUPLE]) is
		local
			s: ARRAY [STRING]
		do
			p.call (Void)
			print ((s~make (?, 2)).generating_type); io.new_line
  		end
	
	weasel is
		do
			io.put_string ("Weasels%N")
  		end
	
invariant
	{ARRAY [STRING]}~make /= Void
end
