indexing

	description: 
		"Error in creation instruction.";
	date: "$Date$";
	revision: "$Revision $"

class VGCC 

inherit

	FEATURE_ERROR
		redefine
			build_Explain
		end;

feature -- Properties

	type: TYPE_A;
			-- Creation type involved

	code: STRING is "VGCC";
			-- Error code

	target_name: STRING
			-- If not Void target of creation instruction, otherwise it is an error
			-- in a creation expression.

feature -- Output

	print_name (st: STRUCTURED_TEXT) is
		do
			if target_name /= Void then
				st.add_string ("Creation of: ");
				st.add_string (target_name);
				st.add_new_line;
			end
			st.add_string ("Target type: ");
			type.append_to (st);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			print_name (st)
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_target_name (s: STRING) is
		do
			target_name := s
		end;

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

end -- class VGCC
