-- Error when two files *.e with same class in the same cluster

class VD11

inherit

	VD10
		rename
			build_explain as vd10_build_explain
		redefine
			code
		end;
	VD10
		redefine
			code, build_explain
		select
			build_explain
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

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			vd10_build_explain (a_clickable);
			a_clickable.put_string ("%Tclass: ");
			a_clickable.put_string (a_class.class_name);
			a_clickable.new_line;
		end;

end
