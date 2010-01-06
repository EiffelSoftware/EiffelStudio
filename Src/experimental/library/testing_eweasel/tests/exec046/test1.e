
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
inherit
	EXCEPTIONS
	EXCEP_CONST
creation
	make
feature	
	make (v: INTEGER) is
		do
			value := v;
		end;

	set_value (v: INTEGER) is
		do
			value := v;
		rescue
			if assertion_violation and exception = Class_invariant then
				value := 0
			end
		end

	value: INTEGER;

	check_invariant: BOOLEAN is
		do
			io.putstring ("Checking invariant of TEST2%N");
			Result := True;
		end

invariant
	checking: check_invariant;
	non_negative_value: value >= 0;
end
