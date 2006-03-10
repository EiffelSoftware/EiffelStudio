indexing

	description: 
		"Error for invalid precompiled systems used for a project"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		do
			a_text_formatter.add ("Precompiled path: ");
			a_text_formatter.add (path);
			a_text_formatter.add_new_line
			a_text_formatter.add ("Expected creation date: ")
			a_text_formatter.add (expected_date);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Precompilation creation date: ");
			a_text_formatter.add (precompiled_date);
			a_text_formatter.add_new_line;
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class VD53
