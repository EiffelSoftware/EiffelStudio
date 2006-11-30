
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
		do
			weasel := 47.0;
			hamster := 47;
			shark := 47;
			print ($make); io.new_line;
			print ($wimp); io.new_line;
			print ($weasel); io.new_line;
			print ($shark); io.new_line;
			print ($hamster); io.new_line;
		end;
	
	wimp is
		do
		end;

	weasel: DOUBLE;
	hamster: INTEGER;
	shark: INTEGER;
end

