
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	EXCEPTIONS
	EXCEP_CONST
create
	make
feature	
	make (v: INTEGER)
		do
			value := v;
		end;

	set_value (v: INTEGER)
		do
			value := v;
		rescue
			if assertion_violation and exception = Class_invariant then
				value := 0
			end
		end

	value: INTEGER;

	check_invariant: BOOLEAN
		do
			io.putstring ("Checking invariant of TEST2%N");
			Result := True;
		end

invariant
	checking: check_invariant;
	non_negative_value: value >= 0;
end
