-- Interval has values of bad type

class VOMB2 

inherit

	VOMB1
	
feature

	interval: INTERVAL_AS;
			-- Interval involved in the error

	set_interval (t: INTERVAL_AS) is
			-- Assign `t' to `interval'.
		do
			interval := t;
		end;

	type: TYPE_A;
			-- Type of the inspect expression

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

end
