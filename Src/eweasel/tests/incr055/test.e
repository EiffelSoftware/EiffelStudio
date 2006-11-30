
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

	-- To reproduce error:
	-- Compile classes as is.
	-- When compiler reports VDRD error, delete declaration of `try'
	--	from TEST2, uncomment declaration of `try' in TEST and 
	--	comment out inheritance clause for TEST2 in TEST.
	-- Resume.  Exception trace while freezing.

class TEST
$INHERITANCE

creation
	make
feature

	make is
		do
		end;

	$TEST_ROUTINE
end
