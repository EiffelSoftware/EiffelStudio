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

	attribute_name: STRING;
			-- Attribute name in the strip expresssion

	set_attribute_name (s: STRING) is
			-- Assign `s' to `attribute_name'.
		do
			attribute_name := s;
		end;

	code: STRING is "VWST";
			-- Error code

	build_explain is
			-- Build specific explanation image for current error
			-- in `error_window'.
		do
			put_string ("Name: ");
			put_string (attribute_name);
			new_line
		end

end
