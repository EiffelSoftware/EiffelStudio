-- Error when an id in a strip expression is not an attribute name

class VWST1 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end
	
feature

	subcode: INTEGER is
		do
			Result := 1;
		end;

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

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		local
			compiled_class: CLASS_C
		do
			put_string ("%Tattribute name: ");
			put_string (attribute_name);
			new_line
		end

end
