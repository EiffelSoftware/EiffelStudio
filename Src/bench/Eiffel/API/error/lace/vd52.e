indexing

	description: 
		"Error for precompiled systems that cannot be succesfully%
		%retrieved."
	date: "$Date$"
	revision: "$Revision $"

class VD52

inherit

	LACE_ERROR
		redefine
			build_explain, is_defined
		end

feature -- Access

	path: STRING
			-- Path of precompiled project

	compiler_version: STRING
			-- Compiler version

	precompiled_version: STRING
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
			check
				path_not_void: path /= Void
				compiler_version_not_void: compiler_version /= Void
			end
			st.add_string ("Precompiled path: ")
			st.add_string (path)
			st.add_new_line
			st.add_string ("Compiler version: ")
			st.add_string (compiler_version)
			st.add_new_line
			st.add_string ("Precompile compiled with version: ")
			if precompiled_version.is_empty then
				st.add_string ("No version number could be retrieved.")
			else
				st.add_string (precompiled_version)
			end
			st.add_new_line
		end

feature {PRECOMP_R, REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		require
			s_not_void: s /= Void
		do
			path := s
		ensure
			path_set: path = s
		end

	set_precompiled_version (v: like precompiled_version) is
			-- Assign `v' to `precompiled_version'.
		do
			if v = Void then
				create precompiled_version.make_empty
			else
				precompiled_version := v
			end
		ensure
			precompiled_version_not_void: precompiled_version /= Void
			precompiled_version_set: v /= Void implies precompiled_version.is_equal (v)
		end

	set_compiler_version (v: like compiler_version) is
			-- Assign `v' to `compiler_version'.
		require
			v_not_void: v /= Void
		do
			compiler_version := v
		ensure
			compiler_version_set: compiler_version = v
		end

end -- class VD52
