-- Error when two files *.e with same class in the same cluster

class VD11

inherit

	VD10
		rename
			trace as vd10_trace
		redefine
			code
		end;
	VD10
		redefine
			code, trace
		select
			trace
		end;

feature

	a_class: CLASS_I;
			-- Class involved

	set_a_class (c: CLASS_I) is
			-- Assign `c' to `a_class'.
		do
			a_class := c;
		end;

	code: STRING is "VSCN";
			-- Error code

	trace is
			-- Debug purpose
		do
			vd10_trace;
			io.error.putstring ("\tclass: ");
			io.error.putstring (a_class.class_name);
			io.error.new_line;
		end;

end
