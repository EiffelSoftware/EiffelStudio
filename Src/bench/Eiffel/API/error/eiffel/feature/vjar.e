indexing

	description: 
		"Error for invalid assignment attempt.";
	date: "$Date$";
	revision: "$Revision $"

class VJAR 

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Properties

	target_name: STRING;

	target_type: TYPE_A;
			-- Target type of the reverse assignment (left part)

	source_type: TYPE_A;
			-- Source type of the reverse assignment (right part)

	code: STRING is
		do
			Result := "VJAR";
		end;

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
			-- Build specific explanation image for current error
			-- in `ow'.
		do
			ow.put_string ("Target name: ");
			ow.put_string (target_name);
			ow.put_string ("%NTarget type: ");
			target_type.append_to (ow);
			ow.put_string ("%NSource_type: ");
			source_type.append_to (ow);
			ow.new_line
		end

feature {COMPILER_EXPORTER}

	set_source_type (s: TYPE_A) is
			-- Assign `s' to `source_type'.
		do
			source_type := s;
		end;

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end;

	set_target_name (s: STRING) is
		do
			target_name := s;
		end;

end -- class VJAR
