-- Error when a class name is not found in the surrounding universe
class VTCT 

inherit

	EIFFEL_ERROR
		redefine
			build_explain
		end
	
feature 

	class_name: STRING;
			-- Class name not found

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

	code: STRING is "VTCT";
			-- Error code

	build_explain is
            -- Build specific explanation explain for current error
            -- in `error_window'.
        do
			put_string ("%Tclass name: ");
			put_string (class_name);
			new_line;
		end;

end
