note

	description: "[
		Error for invalid parent type: different generic derivations
		of the same class are used in Parent parts.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class VHPR5_ECMA

inherit

	EIFFEL_ERROR
		redefine
			build_explain,
			subcode
		end

create

	make

feature {NONE} -- Creation

	make (c: CLASS_C; t1, t2: CL_TYPE_A; l: LOCATION_AS)
			-- Create error object for class `c' with offending
			-- parent types `t1' and `t2' at location `l'.
		require
			c_attached: c /= Void
			t1_attached: t1 /= Void
			t2_attached: t2 /= Void
			l_attached: l /= Void
		do
			set_class (c)
			parent_type_1 := t1
			parent_type_2 := t2
			set_location (l)
		ensure
			class_c_set: class_c = c
			parent_type_1_set: parent_type_1 = t1
			parent_type_2_set: parent_type_2 = t2
			line_set: line = l.line
			column_set: column = l.column
		end

feature -- Error code

	code: STRING = "ECMA-VHPR";
			-- Error code

	subcode: INTEGER = 5
			-- Error subcode

feature -- Output

	build_explain (a_text_formatter: TEXT_FORMATTER)
			-- Build specific explanation explain for current error
			-- in `a_text_formatter'.
		do
			a_text_formatter.add ("Derivation 1: ")
			parent_type_1.append_to (a_text_formatter)
			a_text_formatter.add_new_line
			a_text_formatter.add ("Derivation 2: ")
			parent_type_2.append_to (a_text_formatter)
			a_text_formatter.add_new_line
		end

feature {NONE} -- Data

	parent_type_1: CL_TYPE_A;
			-- Parent type involved in the error

	parent_type_2: CL_TYPE_A;
			-- Parent type involved in the error

note
	copyright:	"Copyright (c) 2006, Eiffel Software"
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

end
