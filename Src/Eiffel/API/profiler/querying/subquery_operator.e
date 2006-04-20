indexing

	description:
		"Operator between two sub queries."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SUBQUERY_OPERATOR

inherit
	ACTIVATABLE

create
	make

feature -- Initialization

	make (op: STRING) is
			-- Create an active operator 'op'.
		do
			int_operator := op;
			activate;
		ensure
			activated: is_active;
			correct_body: actual_operator.is_equal (op);
		end;

feature -- Properties

	actual_operator: STRING is
		do
			Result := int_operator;
		end;

feature -- Setting

	change_operator (new_op: STRING) is
		require
			new_op_is_and_or_or: new_op.is_equal("and") or else
								 new_op.is_equal("or");
		do
			int_operator := new_op;
		ensure
			changed: actual_operator = new_op;
		end;

feature {NONE} -- Attributes

	int_operator: STRING;

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

end -- class SUBQUERY_OPERATOR
