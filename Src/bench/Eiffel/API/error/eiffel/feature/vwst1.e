-- Error when an id in a strip expression is not an attribute name

class VWST1 

inherit

	FEATURE_ERROR
		rename
			build_explain as old_build_explain
		end;

	FEATURE_ERROR
		redefine
			build_explain
		select
			build_explain
		end
	
feature

	attribute_name: ID_AS;
			-- Attribute name in the strip expresssion

	strip_expr: UN_STRIP_AS;
			-- Strip expression

	set_attribute_name (s: ID_AS) is
			-- Assign `s' to `attribute_name'.
		do
			attribute_name := s;
		end;

	set_strip_expr (expr: like strip_expr) is
			-- Assign `expr' to `strip_expr'.
		do
			strip_expr := expr;
		end;

	code: STRING is "VWST";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation image for current error
            -- in `a_clickable'.
		local
			compiled_class: CLASS_C
        do
			old_build_explain (a_clickable);
			a_clickable.put_string ("%Tattribute name: ");
			a_clickable.put_string (attribute_name);
			a_clickable.put_string ("%N")
		end

end
