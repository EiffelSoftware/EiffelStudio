-- Error for export list rule

class VLEL 

inherit

	EIFFEL_ERROR
	
feature

	parent: CLASS_C;
			-- Parent node involved

	set_parent (p: CLASS_C) is
			-- Assign `p' to `parent_id'.
		do
			parent := p;
		end;

	print_parent is
		do
			put_string ("Parent for which export list appears: ");
			parent.append_clickable_name (error_window);
			new_line;
		end;

	code: STRING is "VLEL";
			-- Error code

end
