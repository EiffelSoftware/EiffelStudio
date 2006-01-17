indexing

	description: 
		"Error for a feature call: type mismatch on one argument."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VUAR2 

inherit

	VUAR
		redefine
			build_explain, is_defined, subcode
		end

feature -- Properties

	subcode: INTEGER is 2;

	argument_name: STRING;
			-- Name of the involved argument

	argument_position: INTEGER;

	formal_type: TYPE_A;
			-- Formal type of the argument

	actual_type: TYPE_A;
			-- Actual type of the call

feature -- Status report

	is_defined: BOOLEAN is
			-- Is the error fully defined?
		do
			Result := Precursor and then
				argument_name /= Void and then formal_type /= Void and then actual_type /= Void
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			print_called_feature (st);
			st.add_string ("Argument name: ");
			st.add_string (argument_name);
			st.add_new_line;
			st.add_string ("Argument position: ");
			st.add_int (argument_position);
			st.add_new_line;
			st.add_string ("Actual argument type: ");
			actual_type.append_to (st);
			st.add_new_line;
			st.add_string ("Formal argument type: ");
			formal_type.append_to (st);
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_argument_name (n: STRING) is
			-- Assign `n' to `argument_name'.
		do
			argument_name := n;
		end;

	set_argument_position (i: INTEGER) is
		do
			argument_position := i
		end;

	set_formal_type (t: TYPE_A) is
			-- Assign `t' to `formal_type'.
		do
			formal_type := t;
		end;

	set_actual_type (a: TYPE_A) is
			-- Assign `a' to `actual_type'.
		do
			actual_type := a;
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

end -- class VUAR2
