indexing

	description:
			"Error for unvalid anchored type (an anchored type cannot be evaluated). %
				%1. cycle in like features %
				%2. like feature wich is defined in terms of like argument %
				%3. unvalid feature name for anchor %
				%4. anchor is a procedure %
				%5. cycle involving like arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"


class VTAT1 obsolete "NOT THE SAME MEANING AS THE BOOK"

inherit

	FEATURE_ERROR
		redefine
			build_explain, subcode
		end
create
	default_create, make

feature {NONE} -- Initialize

	make (a_type: like type; an_anchor: like anchor_type) is
			-- New error occuring in `a_type' for anchor `an_anchor'.
		require
			a_type_not_void: a_type /= Void
			an_anchor_not_void: an_anchor /= Void
		do
			type := a_type
			anchor_type := an_anchor
		ensure
			type_set: type = a_type
			anchor_set: anchor_type = an_anchor
		end

feature -- Properties

	type: TYPE_A;
			-- Type in which VTAT error occurs

	anchor_type: STRING
			-- Anchor in which error occurs.

	code: STRING is "VTAT";
			-- Error code

	subcode: INTEGER is 1;

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER) is
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			if anchor_type /= Void then
				a_text_formatter.add ("Anchored type: ")
				a_text_formatter.add (anchor_type)
				a_text_formatter.add_new_line
			end
			a_text_formatter.add ("Appearing in type: ")
			type.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_type (t: like type) is
			-- Assign `t' to `type'.
		do
			type := t;
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

end
