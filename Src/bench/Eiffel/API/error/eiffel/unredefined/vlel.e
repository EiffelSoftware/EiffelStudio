-- Error for export list rule

class VLEL 

inherit

	EIFFEL_ERROR
	
feature

	parent_id: INTEGER;
			-- Parent node involved

	set_parent_id (p: INTEGER) is
			-- Assign `p' to `parent_id'.
		do
			parent_id := p;
		end;

	code: STRING is "VLEL";
			-- Error code

end
