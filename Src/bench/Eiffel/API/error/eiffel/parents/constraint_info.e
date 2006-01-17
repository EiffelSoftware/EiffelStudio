indexing
	description: "Description of a violation of the constrained %
				%genericity validity rule."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class CONSTRAINT_INFO 

feature -- Properties

	type: GEN_TYPE_A
			-- Generic type in which the `formal_number'_th generic
			-- parameter violates the rule

	formal_number: INTEGER
			-- Number of the generic parameter violating the rule

	actual_type, c_type: TYPE_A
			-- Types involved

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		require
			actual_type /= Void
			c_type /= Void
		do
			st.add_new_line
			st.add_string ("For type: ")
			type.append_to (st)
			st.add_new_line
			st.add_string ("Argument number: ")
			st.add_int (formal_number)
			st.add_string (":")
			st.add_new_line
			st.add_string ("Actual generic parameter: ")
			actual_type.append_to (st)
			st.add_new_line
			st.add_string ("Type to which it should conform: ")
			c_type.append_to (st)
			st.add_new_line
		end

feature {COMPILER_EXPORTER} -- Setting

	set_actual_type (t: TYPE_A) is
			-- Assign `t' to `type1'.
		do
			actual_type := t
		end

	set_constraint_type (t: TYPE_A) is
			-- Assign `t' to `type2'.
		do
			c_type := t
		end

	set_type (t: GEN_TYPE_A) is
			-- Assign `t' to `type'.
		do
			type := t
		end

	set_formal_number (i: INTEGER) is
			-- Assign `i' to `formal_number'.
		do
			formal_number := i
		end

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

end -- class CONSTRAINT_INFO
