-- Error when the is a conflict on values in an inspect expression

class VOMB3 

inherit

	VOMB
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 3;

feature

	interval: INTERVAL_B;
			-- Interval of conflicting values

	set_interval (t: INTERVAL_B) is
			-- Assign `t' to `interval'.
		do
			interval := t;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Duplicate values: ");
			interval.display (ow);
			ow.new_line;
		end;

end
