indexing

	description: 
		"Error for precompiled systems that cannot be succesfully%
		%retrieved."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			check
				path_not_void: path /= Void
				compiler_version_not_void: compiler_version /= Void
			end
			a_text_formatter.add ("Precompiled path: ")
			a_text_formatter.add (path)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Compiler version: ")
			a_text_formatter.add (compiler_version)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Precompile compiled with version: ")
			if precompiled_version.is_empty then
				a_text_formatter.add ("No version number could be retrieved.")
			else
				a_text_formatter.add (precompiled_version)
			end
			a_text_formatter.add_new_line
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class VD52
