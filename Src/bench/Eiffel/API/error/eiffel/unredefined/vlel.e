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

	print_parent (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Parent for which export list appears: ");
			parent.append_name (ow);
			ow.new_line;
		end;

	code: STRING is "VLEL";
			-- Error code

end
