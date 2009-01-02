
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class CHILD

creation
	make
feature
	make is
		do
			!!attribute_field;
		end;

	weasel is
		do
		end

	is_valid: BOOLEAN is
		do
			Result := attribute_field.valid;
		end

	attribute_field: TEST1;
	
invariant
	always_valid: is_valid;

end
