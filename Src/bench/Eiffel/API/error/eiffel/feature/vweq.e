indexing

	description:
		"Error for invalid equality."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VWEQ

inherit

	FEATURE_ERROR
		redefine
			build_explain
		end

feature -- Properties

	left_type: TYPE_A;
			-- Left type of the equality

	right_type: TYPE_A;
			-- Right type of the equality

	code: STRING is "VWEQ";
			-- Error code

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation image for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Left-hand type: ");
			left_type.append_to (a_text_formatter);
			a_text_formatter.add_new_line;
			a_text_formatter.add ("Right-hand type: ");
			right_type.append_to (a_text_formatter);
			a_text_formatter.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_right_type (t: TYPE_A) is
		do
			right_type := t;
		end;

	set_left_type (t: TYPE_A) is
		do
			left_type := t;
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

end -- class VWEQ
