-- Error when there is an ambiguity for a visible class name

class VD26

inherit

	CLUSTER_ERROR
		rename
			trace as basic_trace
		end;
	CLUSTER_ERROR
		redefine
			trace
		select
			trace
		end

feature

	class_name: STRING;
			-- Class name subject to ambiguity

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	code: STRING is "VD26";
			-- Error code

	trace is
		do
			basic_trace;
			io.error.putstring ("\tclass name: ");
			io.error.putstring (class_name);
			io.error.new_line;
		end;

end
