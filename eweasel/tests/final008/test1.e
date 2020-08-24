
--| Copyright (c) 1993-2020 University of Southern California, Eiffel Software and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
convert
	to_expanded: {expanded TEST1}
feature

	to_expanded: expanded TEST1
		do
			create Result
			Result.set_value (value)
			Result.set_a (a)
		end

	value: INTEGER;

	set_a (v: DOUBLE)
		do
			a := v;
		end

	set_value (v: INTEGER)
		do
			value := v;
		end
	
	weasel (arg: expanded TEST1): expanded TEST1
		do
			Result := arg;
		end

	a: DOUBLE	
end
