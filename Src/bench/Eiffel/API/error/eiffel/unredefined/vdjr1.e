indexing

	description: 
		"Error for join rule when the types are not the same.";
	date: "$Date$";
	revision: "$Revision $"

class VDJR1 

inherit

	VDJR
		redefine
			build_explain
		end;

feature -- Properties

	type: TYPE_A;
			-- Type of `new_feature'

	old_type: TYPE_A;
			-- Type of `old_feature'

feature -- Output

	print_types (st: STRUCTURED_TEXT) is
		do
			st.add_string ("First type: ");
			old_type.append_to (st);
			st.add_string ("%NSecond type: ");
			type.append_to (st);
			st.add_new_line;
		end;

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Result types are different%N");
			print_types (st);
			print_signatures (st);
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_type (t: TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t;
		end;

	set_old_type (t: TYPE_A) is
			-- Assign `t' to `old_type'.
		do
			old_type := t;
		end;

end -- class VDJR1
