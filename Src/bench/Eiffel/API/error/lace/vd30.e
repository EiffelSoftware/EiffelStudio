-- Error when root class name is unvalid

class VD30

inherit

	ERROR
		redefine
			trace
		end;

feature

	root_class_name: STRING;
			-- Unvalid root class name

	set_root_class_name (s: STRING) is
			-- Assign `s' to `root_class_name'.
		do
			root_class_name := s;
		end;

	code: STRING is "VD30";
			-- Error code

	trace is
		-- Debug purpose
		do
			io.error.putstring ("code VD30: the root class ");
			io.error.putstring (root_class_name);
			io.error.putstring (" cannot be found in the system");
			io.error.new_line;
		end;

end
