indexing

	description: 
		"Error when a class name is not found in the surrounding universe.";
	date: "$Date$";
	revision: "$Revision $"

class VTCT 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	class_name: STRING;
			-- Class name not found

	code: STRING is "VTCT";
			-- Error code

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation explain for current error
			-- in `ow'.
		local
			c_name: STRING;
		do
			c_name := clone (class_name)
			c_name.to_upper;
			ow.put_string ("Unknown class name: ");
			ow.put_string (c_name);
			ow.new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

end -- class VTCT
