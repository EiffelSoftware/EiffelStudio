indexing

	description: 
		"Error for precompiled systems that cannot be succesfully%
		%retrieved.";
	date: "$Date$";
	revision: "$Revision $"

class VD52

inherit

	LACE_ERROR
		redefine
			build_explain, is_defined
		end;

feature -- Access

	path: STRING;
			-- Path of precompiled project

	compiler_version: STRING;
			-- Compiler version

	precompiled_version: STRING;
			-- Precompile version

	is_defined: BOOLEAN is
		do
			Result := path /= Void and then
				compiler_version /= Void and then
				precompiled_version /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Precompiled path: ");
			st.add_string (path);
			st.add_new_line
			st.add_string ("Compiler version: ");
			st.add_string (compiler_version);
			st.add_new_line;
			if precompiled_version.is_empty then
				st.add_string ("File `project.txt' does not exist in the EIFGEN directory");
			else
				st.add_string ("Precompile compiled with version: ");
				st.add_string (precompiled_version);
			end;
			st.add_new_line;
		end;

feature {PRECOMP_R, REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	set_precompiled_version (i: like precompiled_version) is
			-- Assign `i' to `precompiled_version'.
		do
			precompiled_version := i
		end;

	set_compiler_version (i: like compiler_version) is
			-- Assign `i' to `compiler_version'.
		do
			compiler_version := i
		end;

end -- class VD52
