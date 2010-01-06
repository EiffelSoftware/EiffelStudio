
--| Copyright (c) 1993-2006 University of Southern California and contributors.
--| All rights reserved.
--| Your use of this work is governed under the terms of the GNU General
--| Public License version 2.

class TEST1
convert
	to_expanded: {expanded TEST1}
feature

	to_expanded: expanded TEST1 is
		do
			create Result
			Result.set_value (value)
			Result.set_a (a)
		end

	value: INTEGER;

	set_a (v: DOUBLE) is
		do
			a := v;
		end

	set_value (v: INTEGER) is
		do
			value := v;
		end
	
	weasel (arg: expanded TEST1): expanded TEST1 is
		do
			Result := arg;
		end

	a: DOUBLE	
end
