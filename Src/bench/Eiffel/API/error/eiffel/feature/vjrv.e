indexing
	description: "Error for invalid reverse assignment attempt.";
	date: "$Date$";
	revision: "$Revision $"

class VJRV 

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	target_type: TYPE_A;
			-- Target type

	target_name: STRING;

	code: STRING is "VJRV";
			-- Error code

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Target name: ");
			st.add_string (target_name);
			st.add_new_line;
			st.add_string ("Target type: ");
			target_type.append_to (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER}

	set_target_name (s: STRING) is
		do
			target_name := s;
		end;

	set_target_type (t: TYPE_A) is
			-- Assign `t' to `target_type'.
		do
			target_type := t;
		end; -- set_target_type

end -- class VJRV
