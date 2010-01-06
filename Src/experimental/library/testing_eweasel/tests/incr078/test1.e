
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1 [G -> TEST2]
feature
	try (arg: G) is
		do
			print (arg.a.generator); io.putchar ('%T');
			print (arg.b.generator); io.new_line;
		end

end
