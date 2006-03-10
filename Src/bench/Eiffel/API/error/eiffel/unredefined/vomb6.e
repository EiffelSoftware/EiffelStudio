indexing

	description:
		"Error when all unique constants involved in an inspect %
		%instruction don't have the same origin class."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VOMB6

inherit

	VOMB
		redefine
			subcode, build_explain, is_defined
		end;

feature -- Properties

	subcode: INTEGER is 6;

	unique_feature: E_FEATURE;
			-- Unique feature name

	original_class: CLASS_C;
			-- Class involved

feature -- Access

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := is_class_defined and then
				is_feature_defined and then
				unique_feature /= Void and then
				original_class /= Void
		ensure then
			valid_original_class: Result implies original_class /= Void;
			valid_unique_feature: Result implies unique_feature /= Void
		end

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
		local
			wclass: CLASS_C
		do
			wclass := unique_feature.written_class;
			a_text_formatter.add ("Constant: ");
			unique_feature.append_name (a_text_formatter);
			a_text_formatter.add (" From: ");
			wclass.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Origin of conflicting constants: ");
			original_class.append_name (a_text_formatter);
			a_text_formatter.add_new_line;
		end;

feature {COMPILER_EXPORTEr}

	set_unique_feature (f: FEATURE_I) is
			-- Assign `s' to `unique_name'.
		require
			valid_f: f /= Void
		do
			unique_feature := f.api_feature (f.written_in);
		end;

	set_original_class (c: CLASS_C) is
			-- Assign `c' to `original_class'.
		require
			valid_c: c /= Void
		do
			original_class := c
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

end -- class VOMB6
