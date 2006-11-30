
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST

creation
	make
feature
	
	make is
		local
		do
			print (try (3));
		end;
	
	try (arg: like m): like arg is
		local
			x: like arg;
		do
			Result := arg;
		end;

	m: INTEGER;
end 
