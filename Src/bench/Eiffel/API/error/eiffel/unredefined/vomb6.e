-- Error when all unique constants involved in an inspect 
-- instruction son't have the same origin class

class VOMB6 

inherit

	VOMB
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is 6;

feature

	unique_feature: FEATURE_I;
			-- Unique feature name

	set_unique_feature (f: FEATURE_I) is
			-- Assign `s' to `unique_name'.
		do
			unique_feature := f;
		end;

	written_class: CLASS_C;
			-- Class involved

	set_written_class (c: CLASS_C) is
			-- Assign `c' to `written_class'.
		do
			written_class := c;
		end;

	build_explain is
		local
			wclass: CLASS_C
		do
			wclass := unique_feature.written_class;
			put_string ("Incompatible constant: ");
			unique_feature.append_clickable_name (error_window, wclass);
			put_string (" written in ");
			wclass.append_clickable_name (error_window);
			put_string ("%NOthers constants written in ");
			written_class.append_clickable_name (error_window);
			new_line;
		end;

end
