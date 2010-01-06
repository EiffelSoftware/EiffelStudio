
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
			create x1
			x1.try
			x1.try2
			create x2
			x2.try
			x2.try2
			create x3
			x3.try
			x3.try2
			create x4
			x4.try
			x4.try2
		end;

	x1: TEST1 [STRING]
	x2: TEST2 [STRING]
	x3: TEST3
	x4: TEST4

end
