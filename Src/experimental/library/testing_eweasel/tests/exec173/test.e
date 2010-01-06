
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
			create x
			x.set_value2 (47.25)
			x.try
			create y
			y.set_value2 (True)
			y.try
			create z
			z.set_value2 ("weasel")
			z.try
		end
	
	x: TEST1 [DOUBLE]
	y: TEST1 [BOOLEAN]
	z: TEST1 [STRING]
end
