indexing

	description: 
		"Error when an id in a strip expression is %
		%not an attribute name.";
	date: "$Date$";
	revision: "$Revision $"

class VWST1 

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end
	
feature -- Properties

	subcode: INTEGER is
		do
			Result := 1;
		end;

	attribute_name: STRING;
			-- Attribute name in the strip expresssion

	code: STRING is "VWST";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Name: ");
			ow.put_string (attribute_name);
			ow.new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_attribute_name (s: STRING) is
			-- Assign `s' to `attribute_name'.
		do
			attribute_name := s;
		end;

end -- class VWST1
