-- Error when a class name is not found in the surrounding universe
class VTCT 

inherit

	EIFFEL_ERROR
		rename
			build_explain as old_build_explain
		end;

	EIFFEL_ERROR
		redefine
			build_explain
		select
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

	build_explain (a_clickable: CLICK_WINDOW) is
            -- Build specific explanation explain for current error
            -- in `a_clickable'.
        do
            old_build_explain (a_clickable);
			a_clickable.put_string ("%Tclass name: ");
			a_clickable.put_string (class_name);
			a_clickable.put_string ("%N")
		end;

end
