-- Error when all unique constants involved in an inspect 
-- instruction son't have the same origin class

class VOMB6 

inherit

	VOMB4
	
feature

	written_class: CLASS_C;
			-- Class involved

	set_written_class (c: CLASS_C) is
			-- Assign `c' to `written_class'.
		do
			written_class := c;
		end;

end
