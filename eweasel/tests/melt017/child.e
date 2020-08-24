
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class CHILD

create
	make
feature
	make
		do 
			create attribute_field;
		end;

	weasel
		do
		end

	is_valid: BOOLEAN
		do
			Result := attribute_field.valid;
		end

	attribute_field: TEST1;
	
invariant
	always_valid: is_valid;

end
