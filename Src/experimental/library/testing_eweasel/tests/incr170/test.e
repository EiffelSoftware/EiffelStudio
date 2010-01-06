
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class 
	TEST
inherit
	TEST1
	$PARENT
creation
	make
feature

	make is
		local
			$ATTRIBUTES
		do
			attr := "weasel"
			$INSTRUCTIONS
			io.put_string (attr); io.new_line
		end;

	attr: STRING;
end

