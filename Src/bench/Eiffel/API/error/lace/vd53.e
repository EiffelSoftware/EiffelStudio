indexing

	description: 
		"Error for invalid precompiled systems used for a project";
	date: "$Date$";
	revision: "$Revision $"

class VD53

inherit

	LACE_ERROR
		redefine
			build_explain, is_defined
		end;

feature -- Access

	path: STRING;
			-- Path of precompiled project

	expected_date: STRING;
			-- Expected date of precompile

	precompiled_date: STRING;
			-- Precompile date

	is_defined: BOOLEAN is
		do
			Result := path /= Void and then
				expected_date /= Void and then
				precompiled_date /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line
			st.add_string ("Expected creation date: ")
			st.add_string (expected_date);
			st.add_new_line;
			st.add_string ("Precompilation creation date: ");
			st.add_string (precompiled_date);
			st.add_new_line;
		end;

feature {PRECOMP_R, REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	set_precompiled_date (i: like precompiled_date) is
			-- Assign `i' to `precompiled_date'.
		do
			i.replace_substring_all ("%N", ""); -- Hack to remove %N
			precompiled_date := i;
		end;

	set_expected_date (i: like expected_date) is
			-- Assign `i' to `expected_date'.
		do
			i.replace_substring_all ("%N", ""); -- Hack to remove %N
			expected_date := i
		end;

end -- class VD53
