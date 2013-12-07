
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile class as is (with `es3 -f').  Finish_freezing.
	-- Execute `test'.  Address of attribute is same as its value,
	--	which is almost certainly wrong.

class TEST
creation
	make
feature
	
	make is
		local
			p: POINTER
		do
			weasel := 47.0;
			hamster := 47;
			shark := 47;
			p := $make
			p := $wimp
			p := $weasel
			if p = default_pointer + 47 then
				io.put_string ("Not OK")
			end
			p := $shark
			if p = default_pointer + 47 then
				io.put_string ("Not OK")
			end
			p := $hamster
			if p = default_pointer + 47 then
				io.put_string ("Not OK")
			end
		end;
	
	wimp is
		do
		end;

	weasel: DOUBLE;
	hamster: INTEGER;
	shark: INTEGER;
end

