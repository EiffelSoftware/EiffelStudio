-- Error when all unique constants involved in an inspect 
-- instruction son't have the same origin class

class VOMB6 

inherit

	VOMB
		redefine
			subcode
		end;

feature

	subcode: INTEGER is 6;

feature

	unique_name: STRING;
			-- Unique feature name

	set_unique_name (s: STRING) is
			-- Assign `s' to `unique_name'.
		do
			unique_name := s;
		end;

	written_class: CLASS_C;
			-- Class involved

	set_written_class (c: CLASS_C) is
			-- Assign `c' to `written_class'.
		do
			written_class := c;
		end;

end
