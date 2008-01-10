indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class EXPR_ADDRESS_BL

inherit

	EXPR_ADDRESS_B
		redefine
			analyze, print_register, propagate,
			generate, unanalyze, free_register,
			register
		end;
create
	make

feature

	register: REGISTER;
			-- Register used to store expression value

	propagate (r: REGISTRABLE) is
			-- Propagate a register in expression.
		do
			if r = No_register or not used (r) then
				if not context.propagated or r = No_register then
					expr.propagate (r);
				end;
			end;
		end;

	free_register is
			-- Free register used by expression
		do
			expr.free_register;
			if register /= Void then
				register.free_register
			end
		end;

	analyze is
			-- Analyze expression
		do
			context.init_propagation;
			expr.propagate (no_register);
			expr.analyze;
			if
				expr.type.is_basic and then
				(expr.register = Void or else not expr.register.is_temporary)
			then
				create register.make (expr.type.c_type)
			end
			if expr.is_result and then expr.type.is_basic then
				context.mark_result_used;
			end
		end;

	unanalyze is
			-- Undo the analysis of the expression
		do
			expr.unanalyze;
		end;

	generate is
			-- Generate expression
		local
			buf: GENERATION_BUFFER
		do
			expr.generate;
			if register /= Void then
				buf := buffer
				buf.put_new_line
				register.print_register;
				buf.put_string (" = ");
				expr.print_register;
				buf.put_character (';');
			end
		end;

	print_register is
			-- Print expression value
		local
			r: REGISTRABLE
			buf: GENERATION_BUFFER
		do
			if register /= Void then
				r := register
			else
				r := expr
			end
			if expr.type.is_basic then
				buf := buffer
				buf.put_string ("(char *)&(");
				r.print_register;
				buf.put_character (')');
			else
				r.print_register;
			end
		end;

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

end
