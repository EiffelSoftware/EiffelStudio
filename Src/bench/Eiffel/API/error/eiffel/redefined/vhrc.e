-- Error for unvalid renaming

class VHRC

inherit

	FEATURE_NAME_ERROR
		redefine
			build_explain
		end;

feature 

	parent: CLASS_C;
			-- Involved parent

	code: STRING is "VHRC";
			-- Error for unvalid renaming

	set_parent (p: CLASS_C) is
		do
			parent := p;
		end;

	build_explain is
		do
			put_string ("Parent: ");
			parent.append_clickable_name (error_window);
			new_line;
		end;

end
