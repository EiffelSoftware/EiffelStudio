
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
feature

	a: DOUBLE;

	weasel
		do
			io.put_string ("Calling wimp%N");
			a := 47.29;
			wimp;
			io.put_string ("Back from wimp%N");
			a := 0.0;
		end

	wimp
		do
			io.put_string ("In wimp%N");
		end

	show (b: BOOLEAN): BOOLEAN
		do
			io.put_string ("Checking invariant%N");
			Result := b;
		end
invariant
	good_a_value: show (a = 0.0);
end
